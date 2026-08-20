# Bodování Movement 2.0 — dohodnutá specifikace

Vzniklo z analýzy 445 reálných záznamů za 96 dní (16. 5. – 19. 8. 2026) a diskuse s Markem.
Nahrazuje celý dosavadní bodovací systém.

---

## Pravidlo

**Body dává aktivita podle zvolené obtížnosti. Nic jiného body nedává.**

```
body = úroveň × 25
```

| úroveň | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|---|---|---|---|---|---|---|---|---|---|---|
| body | 25 | 50 | 75 | 100 | 125 | 150 | 175 | 200 | 225 | 250 |

Obtížnost je **subjektivní** — „jak těžké to bylo pro mě dnes". U každého stupně je popisek,
v appce je vysvětlení, že se hodnotí vůči sobě, ne vůči ostatním. Devítku a desítku si hráči
vyhradí sami pro výjimečné dny (závod, celodenní túra v horách).

Cena omylu o jeden stupeň je vždy 25 bodů, nezávisle na tom, kde na škále jsi.

---

## Cviky a lezecké cesty

Zapisují se **jako detail pod aktivitu** — opakování, přidaná váha, série; u lezení jednotlivé
cesty a jejich obtížnost.

**Za cviky ani cesty nejsou žádné body.** Slouží pro:

- osobní rekordy (nejvíc shybů v jedné sérii, nejtěžší přelezený boulder),
- statistiky a grafy zlepšení v čase,
- vlastní přehled hráče o tom, co dělal.

Cvik nejde uložit samostatně. Buď se připne k dnešní aktivitě, nebo appka jedním klikem založí
aktivitu („Cvičení doma"), které hráč přiřadí úroveň.

---

## Maxima

Aktualizují se **automaticky** ze zapsaných cviků. Hráč dostane upozornění
„nový osobní rekord: 24 shybů (bylo 21)", admin to vidí v přehledu změn.

**Pozor při implementaci:** sloupec `cviky.opakovani` je součet za celý záznam, ne jedna série —
79 % záznamů (119 ze 151) má víc sérií. Maximum se musí brát z rozpisu v `poznamka`:

| režim | kde je jedna série |
|---|---|
| `single` | `opakovani` |
| `same` | `ops` (počet v jedné sérii) |
| `varied` | `max(list[].op)` |

U dřepu se sleduje váha, ne opakování; `pridana_vaha` je u víceřadých záznamů **průměr přes série**,
takže se taky musí brát z `poznamka`.

Když nový rekord přesáhne dosavadní o víc než polovinu, appka se zeptá „opravdu?".

---

## Žebříček

- Filtr období **Celkem / Týden / Měsíc zůstává.** Týden a měsíc jsou to hlavní — resetují se
  a dávají každému opakovaně novou motivaci. Celkový součet se po pár měsících nedá ovlivnit.
- Týdenní liga zůstává.
- Filtr typu **Vše / Cviky / Aktivity v žebříčku mizí** — je jen jedna měna, není co filtrovat.
  V historii a v profilu hráče zůstává jako filtr pro prohlížení.
- Vedle bodů se ukazuje **průměrná zvolená obtížnost** hráče a průměr party. Není to kontrola,
  je to zrcadlo — každý si sám srovná měřítko.

**Otevřené:** sezónní trofej = součet bodů, nebo počet vyhraných týdnů?

---

## Co se ruší

| co | proč |
|---|---|
| Wilksův koeficient | existoval jen kvůli bodování cviků |
| exponent 0,55 | totéž |
| volumeFactor | totéž |
| bodování cviků | přesunuto do statistik a rekordů |
| zvláštní bodování lezení | lezení je běžná aktivita s úrovní |
| `LEVEL_POINTS` 1–5 | nahrazeno škálou 1–10 |
| `STRETCH_POINTS` | strečink je běžná aktivita s úrovní |
| denní strop | ověřeno, že není potřeba (nejvyšší den v historii = 270 b) |

---

## Start verze 2.0

Všem se **vynulují body**, stará sezóna zůstane jako archiv.

- Databáze potřebuje sloupec `sezona` na `aktivity` i `cviky`; staré záznamy = 1, nové = 2.
  Mazat řádky nejde — přišly by kalendář aktivit, heatmapa a streaky.
- **Reset se nesmí dotknout rekordů** — jinak by první zápis každého cviku po startu byl
  „nový osobní rekord" a upozornění by ztratilo smysl.
- Historických 23 dnů, které mají jen cviky bez aktivity, se nepřevádí — zůstanou v archivu.
- Lezecké sloupce v ostré databázi zatím vůbec nejsou, budou se zakládat od nuly.
  17 historických lezeckých záznamů zůstane jako běžné aktivity bez rozpisu cest.

---

## Proč to takhle

Rozbor 445 záznamů ukázal, že problém nebyl v tom, že aktivnější lidé mají víc bodů — to je správně.
Problém byl, že **za tutéž věc dostal každý jindy něco jiného**: „Squash" byl zapsaný na úrovních
1, 2, 4 i 5; „Gym" na 1 až 4; Mára zapsal stejnou „Procházku 45min" jednou jako jedničku a jindy
jako dvojku. Ke všemu 87 % záznamů cviků patřilo dvěma lidem ze sedmi, takže cviky byly
privilegovaná měna, na kterou zbytek party nedosáhl.

Přepočet nového systému na reálných datech: pořadí zůstává, rozestup 1. a posledního klesá
ze 17,4× na 13,2×, a nejvíc si polepší Péťa a Káťa (z třetiny vítěze na polovinu) — tedy přesně ti,
kteří cviky nezapisovali.

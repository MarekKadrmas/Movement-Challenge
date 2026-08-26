# Movement Challenge — přehled stavu

> Živý dokument. Aktualizuje se po každé dokončené části. Detailní nápady a kontext = `BACKLOG.md`.
> Poslední aktualizace: 2026-08-25

---

## 🔨 Právě se dělá
- **Návyky** — přestavba obrazovky. Hotovo: řádek týdne jako přepínač dnů (teplý přechod, prstenec plnění),
  přepínání dnů i týdnů (šipky + prst, s rolovací animací), zaškrtnutí aktualizuje kolečka i poměr,
  denní návyky vs. cíle za období (týden/měsíc/rok) ve vlastních sekcích, rychlé plnění měřitelných návyků
  (klik = +krok, podržení = hotovo), test libovolného dne přes `?den=RRRR-MM-DD`. Systém: `NAVYKY-NAVRH.md`.
  Zbývá: nahrazení zameškaného dne (§13), kategorie a vlastní řazení (§14), kolečka dnů u týdenních cílů (§15),
  okno pro založení a úpravu návyku je pořád ve starém designu.

## 🔢 Co právě řešíme

**Čísla jsou stálá a každé číslo je JEDEN task.** Marek odpovídá „7-ok, 22-ne".
Stav: ⏳ čeká na Markovu kontrolu · 🔧 dělá se · ✅ uzavřeno · 🅼 na Markovi

| # | Název | Kde | Stav |
|---|---|---|---|
| 1 | Animace přepnutí filtru žebříčku | Přehled | ✅ |
| 2 | Rádiusy u krajních filtrů | Přehled | ✅ |
| 3 | Čtverečky dnů jsou opravdu čtverce | Přehled, horní karta | ✅ |
| 4 | Ukázkový týden natvrdo v appce | Přehled, horní karta | ✅ vráceno na reálná data |
| 5 | Sloupce dnů — tmavší hrana, strop, plusko | Přehled, horní karta | ✅ |
| 6 | Viditelnost výplně koleček | Návyky | ✅ |
| 7 | Prstenec — hladký oblouk a gradient | Návyky | ✅ |
| 8 | Velikost koleček | Návyky | ✅ |
| 9 | Mezera pod kolečky | Návyky | ✅ |
| 10 | Tlačítko Dnes u data | Návyky | ✅ |
| 11 | Proužek dnů Po–Ne u týdenního cíle | Návyky | ✅ |
| 12 | Měřitelné návyky klikem a podržením | Návyky | ✅ |
| 13 | Nahrazení návyku z přebytku | Návyky | ✅ migrace na TEST DB hotová |
| 14 | Světlý pruh u pravého okraje | Tmavý režim | ✅ |
| 15 | Vycentrování aplikace | Celá appka | ✅ |
| 16 | Výběr aktivity v tmavém režimu | Zelené plus | ✅ |
| 17 | Plusko ve spodní liště na střed | Spodní lišta | ✅ |
| 18 | Bublina Návyky — číslo, šipka, logo | Přehled | ✅ |
| 19 | Obrazovka Historie výkonu | Nová obrazovka | ⏳ postavená v appce: proklik z horní karty, měsíc / rok / detail týdne |
| 20 | Ikony jako textové znaky → SVG | Celá appka | ✅ |
| 21 | Seznam skákal při přepnutí dne | Návyky | ✅ |
| 22 | Barva prstence podle plnění | Návyky, kolečka dnů | ✅ kulička se nevrací |
| 23 | Hlavička bez iniciál, fialová série | Návyky | ✅ |
| 24 | Poskakování prstenců při přepnutí týdne | Návyky | ✅ |
| 25 | Plamínky se ořezávaly a skákaly | Žebříček | ✅ |
| 26 | Označení vybraného dne | Návyky | ✅ |
| 27 | Systémová oprava měření rozměrů | Celá appka | ✅ |
| 28 | Mezera mezi prstenci a datem | Návyky | ✅ |
| 29 | Logo Návyků a bubliny se sérií | Přehled + Návyky | ✅ |
| 30 | Řádek nad kolečky — datum, W35, šipky, Dnes | Návyky | ✅ |
| 31 | Budoucí dny nejdou odškrtnout | Návyky | ✅ |
| 32 | Další nápady na prstenec — mockup | Návyky | 🔧 |
| 33 | Bílý proužek pod posledním řádkem žebříčku | Přehled | ✅ |
| 34 | Bublina série — vůle nad lištou a posun doleva | Přehled, žebříček | ✅ |
| 35 | Barevné odlišení hráčů v žebříčku | Přehled, žebříček | ✅ |
| 19 | Historie výkonu — prémiový redesign | Přehled → horní karta | 🔨 |
| 32 | Prstenec — další nápady na progres a splněný den | Mockup | 🔨 |
| 36 | Úprava a mazání záznamu přímo v appce | Já, Dění, Záznamy | ⏳ |
| 37 | Admin kolečko s iniciálami + zápis za jiného hráče | Horní lišta | ⏳ |
| 38 | Maximálky — nejtěžší váha na cvik | Rekordy | ⏳ |
| 39 | Rekordy pro všechny cviky, ne jen 4 | Rekordy | ⏳ |
| 40 | Úprava návyku — nový design, odladit chování | Návyky | ⏳ |
| 41 | Upravit profil — pořád stará modálka | Já → Nastavení | ⏳ |
| 42 | Emoji reakce se neukládají do DB (komentáře už ano) | Dění v partě | ⏳ |
| 43 | Notifikace — přepínače nic nedělají | Já → Notifikace | ⏳ |
| 44 | Cíle a ochrana série — ukázková data, nic se neukládá | Já → Cíle | ⏳ |
| 45 | Pozvat kamaráda — kód z mockupu, sdílení bez akce | Já → Pozvat | ⏳ |
| 46 | Zápis — výběr aktivity, kategorie, oblíbené | Zápis | ⏳ |
| 47 | Šablony do gymu (Push / Pull / Nohy) | Zápis | ⏳ |
| 48 | Rozpis cviků ve feedu místo holého „Gym" | Dění v partě | ⏳ |
| 49 | Lezení — cesty dotáhnout na úroveň karet cviků | Zápis | ⏳ |
| 50 | Vlastní ikony — 103 aktivit sdílí 14 ikon | Celá appka | ⏳ |
| 51 | Kategorie a ruční řazení návyků | Návyky | ⏳ |
| 52 | Vypnout demo čísla v hero kartě | Přehled | ⏳ |


## ⏸️ Rozdělané (schválně odloženo)
- **Systém zápisu** — rozhodnout A/B ([mockup](https://claude.ai/code/artifact/f3760cb0-7d1d-4cb7-8c8c-dca2d18f7cfa)), doladit výběr aktivity, kategorie, srdíčko oblíbených
- **Šablony do gymu** — „Push den / Pull den / Nohy" bez hledání cviků pokaždé
- **Rozpis cviků ve feedu** — Gym se 3 cviky se v dění ukáže jen jako „Gym"
- **Lezení** — cesty jsou jednodušší verze než karty cviků
- **Vlastní ikony** — 103 aktivit sdílí 14 ikon, některé dvojice jsou identické
- **Demo čísla v hero kartě** (`MM_UKAZKA_KARTA = true`) — vypnout, až bude bodování sedět

---

## 🆕 Nové moduly (nezačaté)
- **Kalorické tabulky** — jídlo, makra, databáze potravin, spálené vs. přijaté
- **Tělesné údaje** — váha, výška, obvody + historie a graf (nová tabulka `body_metrics`)
- **Kalendář akcí + ankety** — společný trénink, hlasování o termínu (styl Doodle), export .ics
- **Modulární appky (Marek 25. 8.)** — appka nebude jeden monolit. Na **profilu** si hráč přidá moduly,
  které chce používat: kalorické tabulky, učení slovíček / jazyků, návyky, tréninkový deník, protahovací deník,
  flashcards… Kdo chce počítat kalorie, přidá si kalorie; kdo se učí jazyk, přidá si jazyky.
  **Dopad na stavbu už teď:** každou featuru držet jako samostatný modul (vlastní obrazovka, vlastní data,
  vlastní render), aby šla zapnout a vypnout bez zásahu do zbytku. Otevřené otázky na potom: co ve spodní liště
  (pevné 4 sloty vs. dynamické), jestli moduly sypou body do žebříčku, a kde se drží seznam zapnutých modulů
  (sloupec u hráče v DB).
- **Widget na plochu** — zápis na jedno kliknutí (PWA shortcuts + deep-linky jako první krok)

## 👥 Sociální / retence
- **Kdo dal reakci** — tuknutí na pilulku ukáže jména
- **Vítěz týdne, síň slávy, odznaky** — vítězové se dopočítávají, ale nejsou nikde jako událost
- **Komentáře u záznamů**

## ⚙️ Základ
- **Notifikace** — obrazovka je vizuální placeholder, service worker ani push neexistují
- **Offline / instalovatelná PWA**
- **Bezpečnost DB** — RLS hotové na testu (Fáze 0), ověřit stav na produkci
- **Onboarding + in-app návod**

## ✨ Polish
- Haptika, skeletony místo „Načítám…", prázdné stavy s výzvou
- Odstranit zbylé nativní `prompt/confirm/alert`
- Inline validace formulářů

---

## ✅ Hotové milníky
- Momentum redesign (Přehled, Žebříček, Já, Parta, dění, reakce)
- Kalendář aktivity: stránky po celých týdnech, jeden předěl uprostřed, datumy a čísla týdnů nad čtverečky, dnešek zeleně, čtvercové buňky (2026-08-23)
- Žebříček: nadpis + odpočet, bez iniciál a korunky, stejně vysoké řádky, přepínač období jako záložka spojená s tabulkou
- Zápis aktivit: katalog 103 aktivit v 10 kategoriích, vlastní aktivity, oblíbené, rozpisy cviků a sérií, spodní lišta s kalendářem
- Habit tracker (F52): frekvence denní/vybrané dny/týdenní/měsíční/roční, měřitelné návyky, statistiky, knihovna ~85 presetů
- Přihlášení přes Supabase Auth (e-mail + heslo)
- Lezení (na produkci)

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

## 🔢 Co právě řešíme (čísla jsou stálá — Marek na ně odpovídá „1-ok, 2-ne")

| # | Věc | Stav |
|---|---|---|
| 1 | Žebříček — animace přepnutí filtru | hotovo |
| 2 | Žebříček — rádiusy u krajních filtrů | ~~uzavřeno~~ |
| 3 | Přehled — čtverečky dnů jsou čtverce | hotovo |
| 4 | Přehled — ukázkový týden natvrdo v appce | **čeká na odsouhlasení, pak vrátit na reálná data** |
| 5 | Přehled — ryska cíle | vlásková linka jen po horní hraně čtverce (výška = rádius, žádná svislá ramena — právě ta z ní dělaly plovoucí rámeček) + nad cílem plná barva bez přechodu — čeká na posouzení |
| 6 | Návyky — viditelnost výplně koleček | ~~prozatím ok~~ |
| 7 | Návyky — konec oblouku se rozšíří do kuličky, zaoblení zmenšeno | ~~uzavřeno~~ |
| 8 | Návyky — velikost koleček | ~~uzavřeno~~ (46,6 px) |
| 9 | Návyky — mezera pod kolečky | ~~uzavřeno~~ |
| 10 | Návyky — přepnutí týdne: hlavička se mění hned se startem dojezdu, sousední týden je identický s cílovým (prstence neposkočí) | čeká na posouzení |
| 11 | Návyky — proužek dnů Po–Ne u týdenního cíle | hotovo, Markovi se líbí |
| 12 | Návyky — měřitelné návyky klikem a podržením | hotovo, Marek zkouší v provozu |
| 13 | Návyky — nahrazení z přebytku (§13) | hotovo v kódu, **čeká na migraci `F53-nahrazeni.sql`** |
| 14 | Tmavý režim — světlý pruh vpravo | hotovo |
| 15 | Vycentrování aplikace (4+4 px) | hotovo |
| 16 | Výběr aktivity (zelené plus) v tmavém režimu | ~~uzavřeno~~ |
| 17 | Plusko ve spodní liště na střed | ~~uzavřeno~~ |
| 18 | Bublina Návyky — „2/5" blíž k šipce, ikona je stejný prstenec s kuličkou jako v Návycích | čeká na posouzení (posunuto podruhé) |
| 19 | Přehled — historie čtverečků | **zadání od Marka 25. 8.:** proklik z horního banneru → přehled týdnů v průběhu měsíce a celého roku, jednotlivé týdny se dají rozkliknout. V přehledu se dny nad cíl značí jen plusky nad čtverečky nebo lehkým přesahem; detailní výška sloupce až po rozkliknutí týdne. **Mockup se dělá.** |
| 20 | Ikony jako textové znaky (plusko, šipky) → SVG, optický střed změřen | ~~uzavřeno~~; křížky `×` v modálech projít při jejich předělání |
| 21 | Návyky — seznam skákal při přepnutí dne | ~~uzavřeno~~ |


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
- **Add-ony** — tréninkový deník, protahovací deník, flashcards (volitelné moduly)
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

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

**Čísla jsou stálá.** Marek odpovídá „7-ok, 10-ne". Stav: ⏳ čeká na Markovu kontrolu · 🔧 dělá se · ✅ uzavřeno (Marek potvrdil) · 🅼 na Markovi

| # | Věc | Stav |
|---|---|---|
| 1 | Žebříček — animace přepnutí filtru | ✅ |
| 2 | Žebříček — rádiusy u krajních filtrů | ✅ |
| 3 | Přehled — čtverečky dnů jsou čtverce | ✅ |
| 4 | Přehled — ukázkový týden natvrdo v appce | 🅼 odsouhlasit, pak vrátím reálná data |
| 5 | Přehled — ryska cíle, varianta D | 🔧 doladit čtverečky nahoře v týdnu (Čt/Pá/So) |
| 6 | Návyky — viditelnost výplně koleček | ✅ |
| 7 | Návyky — prstenec: hladký oblouk, kulička, gradient | ✅ |
| 8 | Návyky — velikost koleček | ✅ |
| 9 | Návyky — mezera pod kolečky | ✅ |
| 10 | Návyky — tlačítko Dnes u data | ⏳ posunuto ještě o 23 px doleva |
| 11 | Návyky — proužek dnů Po–Ne u týdenního cíle | ✅ |
| 12 | Návyky — měřitelné návyky klikem a podržením | ✅ |
| 13 | Návyky — nahrazení z přebytku | 🅼 spustit `F53-KOPIROVAT.sql` v Supabase |
| 14 | Tmavý režim — světlý pruh vpravo | ✅ |
| 15 | Vycentrování aplikace | ✅ |
| 16 | Výběr aktivity v tmavém režimu | ✅ |
| 17 | Plusko ve spodní liště na střed | ✅ |
| 18 | Bublina Návyky — číslo, šipka, logo s fajfkou | ✅ |
| 19 | Historie výkonu — mockup | 🔧 dny z okolních měsíců v prvním a posledním týdnu + vejít se na jednu obrazovku |
| 20 | Ikony jako textové znaky → SVG | ✅ (křížky `×` v modálech až při jejich předělání) |
| 21 | Návyky — seznam skákal při přepnutí dne | ✅ |
| 22 | Návyky — označení dnů | ✅ hotovo; 🔧 zbývá mockup jiného označení splněného dne |
| 23 | Návyky — hlavička bez iniciál, fialová série | ✅ |
| 24 | Návyky — poskakování prstenců při přepnutí týdne | ⏳ opraveny dvě příčiny, třetí je nejspíš překreslování SVG v Safari po animaci — nasazen lék, Marek ověří |
| 25 | Žebříček — plamínky se ořezávaly a skákaly | ⏳ šířka sloupce se jmény se už neměří, počítá se z dat |
| 26 | Návyky — proužek dnů u běhu, výraznější splněné dny | ⏳ |
| 27 | **Systémová oprava:** 60 měření DOM ve 20 funkcích, 9 z nich běží při vykreslení — zdroj celé třídy bugů | 🔧 Marek schválil, dělá se |


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

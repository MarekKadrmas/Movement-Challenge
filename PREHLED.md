# Movement Challenge — přehled stavu

> Živý dokument. Aktualizuje se po každé dokončené části. Detailní nápady a kontext = `BACKLOG.md`.
> Poslední aktualizace: 2026-08-23

---

## 🔨 Právě se dělá
- **Návyky** — kompletní promyšlení a přestavba (systém + design). Systém odsouhlasen (`NAVYKY-NAVRH.md`), běží návrh obrazovek — mockup: https://claude.ai/code/artifact/5fd56578-5bd0-4881-a040-56ace6f39acc

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
- Žebříček: nadpis + odpočet, bez iniciál a korunky, stejně vysoké řádky, přepínač období jako záložka spojená s tabulkou
- Zápis aktivit: katalog 103 aktivit v 10 kategoriích, vlastní aktivity, oblíbené, rozpisy cviků a sérií, spodní lišta s kalendářem
- Habit tracker (F52): frekvence denní/vybrané dny/týdenní/měsíční/roční, měřitelné návyky, statistiky, knihovna ~85 presetů
- Přihlášení přes Supabase Auth (e-mail + heslo)
- Lezení (na produkci)

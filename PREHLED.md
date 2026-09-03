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
| 19 | Historie výkonu — postavená, teď prémiový redesign | Přehled → horní karta | 🔨 |
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
| 32 | Prstenec — další nápady na progres a splněný den | Mockup | 🔨 |
| 33 | Bílý proužek pod posledním řádkem žebříčku | Přehled | ✅ |
| 34 | Bublina série — vůle nad lištou a posun doleva | Přehled, žebříček | ✅ |
| 35 | Barevné odlišení hráčů v žebříčku | Přehled, žebříček | ✅ |
| 36 | Úprava a mazání záznamu — široké akce v řádku | Já, Dění, Záznamy | ✅ |
| 37 | Admin kolečko — plovoucí vpravo u pluska | vpravo od spodní lišty | ✅ |
| 38 | Maximálky — vidět a upravit v appce | Já → Rekordy | 🔧 vzhled a funkčnost k přepracování |
| 39 | Rekordy pro všechny cviky + nejtěžší váha | Já → Rekordy | 📱 |
| 40 | Úprava návyku — přestavba do designu appky | Návyky | 📱 |
| 41 | Upravit profil — pořád stará modálka | Já → Nastavení | ⏳ |
| 42 | Emoji reakce se neukládají do DB (komentáře už ano) | Dění v partě | ⏳ |
| 43 | Notifikace — přepínače se pamatují | Já → Nastavení → Notifikace | ⏸️ na finální polish |
| 44 | Cíle a ochrana série — skutečná data | Já → Nastavení → Cíle | ✅ |
| 45 | Pozvat kamaráda — kód z mockupu, sdílení bez akce | Já → Pozvat | ⏳ |
| 46 | Zápis — výběr aktivity, kategorie, oblíbené | Zápis | ⏳ |
| 47 | Šablony do gymu (Push / Pull / Nohy) | Zápis | ⏳ |
| 48 | Rozpis cviků ve feedu místo holého „Gym" | Dění v partě | ⏳ |
| 49 | Lezení — cesty dotáhnout na úroveň karet cviků | Zápis | ⏳ |
| 50 | Vlastní ikony — 103 aktivit sdílí 14 ikon | Celá appka | ⏳ |
| 51 | Řazení návyků pod sebou + pojmenované rozdělovníky | Návyky | 🔨 |
| 52 | Demo — přepínač v nastavení + odznak když běží | Já → Nastavení → Demo režim | ✅ |
| 53 | Ukotvení spodní lišty | Celá appka | ✅ |
| 54 | Vzhled komentářů — předělat design | Dění, Přehled | 📌 |
| 55 | Animace přehození pořadí hráčů | Přehled, žebříček | 📌 |
| 56 | Animace přírůstku prstence | Návyky | 📌 |
| 57 | Kdo dal reakci — ťuknutí ukáže jména | Dění v partě | 📌 |
| 58 | Kalendář událostí + ankety pro partu | Nová obrazovka | 📌 |
| 59 | Tělesné údaje hráče | Profil | 📌 |
| 60 | Modulární appky — přidávání modulů z profilu | Profil | 📌 |
| 61 | Kalorické tabulky | Nový modul | 🆕 |
| 62 | Učení slovíček a jazyků | Nový modul | 🆕 |
| 63 | Widget na plochu | Systém | 🆕 |
| 64 | Vítěz týdne, síň slávy, odznaky | Parta | 🆕 |
| 65 | Tréninkový a protahovací deník | Add-on | 🆕 |
| 66 | Flashcards | Add-on | 🆕 |
| 67 | Logo návyků podle progresu + dvě řady čárek | Přehled → bublina „Návyky dnes" | 📱 |
| 68 | Crash „Moje záznamy" a detailu dne | Já → Moje záznamy | ✅ |
| 69 | Nástěnka — všechny obrazovky vedle sebe na PC | na PC: adresa appky + `/nastenka.html` | 📱 |
| 70 | Detail dne — nevedlo k němu žádné tlačítko | Přehled → Kalendář aktivity → ťukni na čtvereček | ✅ |
| 71 | Stránky šly scrollovat do nekonečna | Celá appka | ✅ |
| 72 | Cviky nebodují — podle Bodování 2.0 | Zápis cviku, Dění | ✅ |
| 73 | Profil — maximálky a rekordy přímo v profilu | Já → Profil | ⏳ |
| 74 | Nabídka Upravit/Smazat — jiné řešení (finální polish) | Dění → rozbalený záznam | 📌 |
| 75 | Dění — načíst starší období, s najetím | Přehled → Dění, dole | 📱 |
| 76 | Denní cíl — pole k přepsání + jasné, že jde kliknout | Přehled → ťukni na „z 40 b" | 📱 |
| 77 | Týdenní přehled bodů v horní kartě | Přehled → horní karta | ✅ |
| 78 | Zelený řádek prvního místa navazuje na filtr | Přehled → žebříček | ✅ |
| 79 | Zlozvyky nejsou nijak odlišené od návyků | Návyky | ⏳ |
| 80 | Kolečka návyků měla nerovnoměrnou tloušťku | Návyky → odškrtávací kolečka | ✅ |
| 81 | Odškrtnutí návyku — prodleva a animace zpět | Návyky | 📱 |




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

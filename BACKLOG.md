# Movement Challenge — Backlog / Roadmap

> Vize (Marek, 2026-06-26): posunout appku z „projektu ze srandy" na **prémiový produkt**, který lidi reálně chtějí používat. Kvalita a feel jako appka od Applu.

## 🚀 Velká vize — posun na novou úroveň
- [ ] **Účty hráčů s přihlášením** — reálná autentizace (e-mail/heslo nebo OAuth), místo jednoduchého výběru hráče přes localStorage. Vlastní profil, soukromá data.
- [ ] **Notifikace** — připomínky návyků, push notifikace (PWA / web push), denní upozornění, motivační hlášky.
- [ ] **Redesign — prémiový vzhled** — vypadat a chovat se jako nativní appka od Applu: jemné animace, haptika, konzistentní design systém, špičkový polish, light/dark mode.
- [ ] **Skutečná použitelnost** — aby to fakt dobře sloužilo a všichni to chtěli používat (ne jen 7 lidí ze srandy). Onboarding, výkon, stabilita.

## 🧭 Roadmapa z kritického review (2026-06-26)
> Multi-agentní review celé appky. Klíč: **nejdřív bezpečnost, pak retenční smyčka, až pak redesign.** Nezačínat „prémiem" na děravém základu.

- [ ] **Fáze 0 — Bezpečnost (NUTNÉ první!)**
  - 🔴 DB je prakticky veřejná: anon klíč v HTML, žádné RLS, soft-auth přes localStorage, nesolený SHA-256 hash čtený do prohlížeče. Kdokoli s URL může číst/přepsat data všech.
  - Zapnout RLS na všech tabulkách; view pro `players` bez `password_hash`; unique index `habit_logs(habit_id,player_id,datum)` + check constraints; FK ON DELETE CASCADE; verzovat schéma DB do repa + smoke testy bodovacích vzorců.
- [ ] **Fáze 1 — Účty** — Supabase Auth (magic link), `auth_user_id` v players, RLS dle `auth.uid()`, vlastní login bottom-sheet místo `prompt()`.
- [ ] **Fáze 2 — Retenční smyčka** — reakce 1 tapem (💪🔥👏) + komentář, živý feed „právě se stalo", **vítěz týdne + týdenní reset + síň slávy**, odznaky/achievementy, propojit habit streaky se soutěží.
- [ ] **Fáze 3 — Notifikace** — service worker (instalovatelná PWA + offline), web push (VAPID, `push_subscriptions`), Edge Function + pg_cron: „streak v ohrožení", „X tě předběhl", nedělní recap. (iOS push jen po přidání na plochu.)
- [ ] **Fáze 4 — Redesign „jako od Applu"** — design tokeny (typo škála, spacing, radiusy, barvy), dark mode, nahradit 13 nativních prompt/confirm/alert, sjednotit ikonografii, prázdné stavy.

### ⚡ Rychlé výhry (kdykoli)
- [ ] Haptika (`navigator.vibrate`) na odškrtnutí návyku / submit / nový PR.
- [ ] Unique index `habit_logs(habit_id,player_id,datum)` — zabrání rozbití statistik dvojklikem.
- [ ] Inline validace formulářů (.error na pole + scroll na první chybu).
- [ ] Skeleton/shimmer loading (leaderboard, heatmapa, recent) místo „Načítám…".
- [ ] `@media (hover:hover)` na :hover + `prefers-reduced-motion`.
- [ ] Prázdné stavy jako výzva s CTA.

## 📌 Menší / průběžné nápady
- [ ] Sdílené návyky (Phase 2 F52) — návyky napříč hráči.
- [ ] **Kopírovat návyk na jiné datum / rozsah** (2026-06-26): u existujícího návyku možnost „zkopírovat" — otevře se kalendář a nastavím OD–DO. Varianty: od data v minulosti, bez konce (do nekonečna), nebo ohraničený začátek+konec. Umožní rychle naklonovat návyk na jiné období.
- [ ] **Calorie tracker / kalorické tabulky** (2026-06-30): sledování kalorií a maker (bílkoviny/sacharidy/tuky), databáze potravin/jídel. KLÍČ = **mega snadné a přívětivé používání** — rychlé přidání jídla (oblíbené nahoře, vyhledávání, nedávná jídla, chytré porce), minimum tapů, čistý denní přehled (snědeno / zbývá / cíl). Vymazlit tak, ať je to radost používat, ne otrava jako u běžných kaloričkových appek. Napojit na pohyb (spálené vs. přijaté). Zvážit vlastní tab nebo sekci v Já.
- [ ] **In-app návod „jak appku používat" + praktické ukázky** (2026-06-29): průvodce s reálnými use-casy, aby z appky byl skutečně skvělý nástroj a pomocníček, ne jen žebříček. Ukázky: jak si založit a naplánovat návyk, jak rychle zapsat trénink, jak appku využít na vlastní cíl/plán (rehabilitace zranění, nácvik stojky/jednoručky…), jak číst statistiky/rekordy, tipy na udržení konzistence. Forma: onboarding při prvním spuštění + sekce „Návod / Tipy" (v Já) + krátké kontextové nápovědy přímo u funkcí. Cíl: každý hned ví, jak z toho vytěžit maximum.
- [ ] **Add-ony — volitelné moduly (každý si přidá sám)** (2026-07-06):
  - **Tréninkový deník** — poskládám si vlastní tréninkový plán (moje cviky/série/plán).
  - **Protahovací deník** — poskládám si vlastní cviky pro protažení.
  - **Flashcards** — vlastní kartičky pro učení/opakování (spaced repetition?).
  - Princip: uživatel si add-on aktivuje/přidá volitelně, není součást základu pro všechny.
- [ ] **Widget na plochu telefonu — zápis na jedno kliknutí** (2026-08-21): z domovské obrazovky se má dát okamžitě něco zapsat — jídlo do kalorických tabulek, návyk, ranní váha, aktivita. Cíl: **co nejmenší tření** — kliknu na widget a rovnou píšu, žádné otevírání appky, hledání záložky a proklikávání. Varianty ke zvážení: (a) iOS Shortcuts + `x-callback` URL do PWA — jde bez App Storu, ale widget je od Zkratek, ne od nás; (b) nativní obal (Capacitor) s vlastním WidgetKit widgetem — plná kontrola, ale znamená to appku v App Storu a build pipeline; (c) Android jde jednodušeji přes PWA shortcuts v manifestu (dlouhý stisk ikony = zkratky „Zapsat aktivitu / Zvážit se / Návyk"). Nejlevnější první krok: **PWA shortcuts + deep-linky** (`/?zapis=vaha`), které otevřou rovnou konkrétní formulář — funguje hned na Androidu a na iOS aspoň přes Zkratky.
- [ ] (sem přibývají další drobnosti)

## ✅ Hotové milníky (kontext)
- Habit tracker (F52): denní/týdenní/měsíční frekvence, měřitelné návyky, statistiky Týden/Měsíc/Rok, proklik buněk = editace, posun po týdnech + tlačítko Dnes.
- Lezení (na produkci).

---
*Pozn.: Toto je živý seznam priorit. Velká vize = vícefázový projekt, ne jednorázová změna — rozdělit na milníky až se k tomu dostaneme.*

## ✅ HOTOVO (2026-08-01) — Napad (Marek, 2026-07-20): plusko ma "svitit"
- Kolecko + (pridani aktivity) by melo nejak svitit / zit.
- Napad: po obvodu kolecka jezdi svetelna linka s NELINEARNIM pohybem (zrychluje/zpomaluje), aby bylo jasne, ze se pluskem pridava aktivita.
- Az po dokonceni vzhledu 1:1 (fáze funkce/efekty).

## ✅ HOTOVO (2026-07-27, swipe-back zleva + vetsi hitboxy) — Backlog (Marek, 2026-07-21): tlacitko Zpet
- "Nejde moc dobre dat zpet tlacitko vsude" - zpetna navigace na podobrazovkach je neohrabana/spatne dostupna.
- Promyslet: vetsi tap-target sipky, konzistentni pozice, pripadne gesto swipe-back.

## ✅ OPRAVENO (2026-07-27) — Bug (Marek, 2026-07-21): admin rezim se vypinal pri vyberu sebe
- Admin rezim + Novy zaznam + "Za koho" -> klik na Mara (sebe) VYPNE admin rezim.
- Ocekavani: vyber sebe = jen prepnuti cile zapisu, admin rezim zustava zapnuty.
- Faze funkce - doladit spolu s ostatnimi mosty formularu.

## Feature (Marek, 2026-08-14): telesne udaje hrace v profilu
- Hrac si bude moct zapisovat udaje o sobe: vaha, vyska, obvody (pas, hrudnik, biceps...), atd.
- Nekde ve svem profilu; casem idealne s historii a grafem vyvoje.
- Vyzaduje novou DB tabulku (body_metrics) + UI v profilu.

## Feature (Marek, 2026-08-18): kalendar udalosti + ankety pro partu
- Sdileny kalendar v aplikaci, kde muzou HRACI vytvaret UDALOSTI (spolecny trenink, lezeni, beh, akce).
- ANKETY / hlasovani o terminu: navrhnout vice terminu, ostatni odskrtnou kdy muzou -> vidi se, kdy se potka nejvic lidi (styl Doodle).
- Ucel: planovat spolecne akce a sporty, domlouvat se kdy se potkat.
- Zvazit: ucast (jdu / nejdu / mozna), pripominka pred akci (notifikace), komentare u udalosti, opakovane akce (kazdy utery lezeni).
- Vyzaduje DB tabulky (events, event_options, event_votes/attendance) + novou obrazovku nebo tab.
- KOMPATIBILITA s Apple/Google kalendarem (Marek 2026-08-18):
  - Export udalosti do .ics (iCalendar) — tlacitko "Pridat do kalendare" u kazde akce, funguje na iOS i Androidu/Google.
  - Idealne i odberovy kalendar (webcal:// feed s ICS) — hrac si prihlasi kalendar party a akce se mu doplnuji automaticky vc. zmen.
  - Zvazit dvoucestnou integraci (Google Calendar API / CalDAV) az v pozdejsi fazi — pro start staci ICS export + feed.
  - Pozor na casove zony, opakovane akce (RRULE) a UID/SEQUENCE pri zmene akce.

## Backlog (Marek, 2026-08-20): kdo dal reakci
- U emoji reakce videt, KDO ji dal (jako na Instagramu — tuknuti na pilulku ukaze seznam hracu).
- Az po dokonceni zakladu reakci.

## Žebříček — animace přehození pořadí (Marek 25. 8. 2026)
Při přepnutí filtru Týden / Měsíc / Celkem se mění pořadí hráčů. Teď se obsah jen prolne.
Marek chce, aby se **řádky mezi sebou prohodily** — hráč, který stoupá, viditelně přejede nahoru
a ten, kdo klesá, dolů. Technicky: zapamatovat si pozice řádků před překreslením, po překreslení
je nasadit zpět transformem a nechat dojet na nové místo (FLIP). Pozor na to, že transform
na řádcích rozbíjí rastrování SVG v Safari — plamínky jsou proto rastr, ne SVG.

## Návyky — animace přírůstku prstence (Marek 25. 8. 2026)
Po odkliknutí návyku má prstenec dne dorůst animací, ne skočit. Marek to bere jako **finální polish** —
až bude koncept funkční, projdeme celou appku a všemu dodáme život a prémiovost.

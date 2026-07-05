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
- [ ] (sem přibývají další drobnosti)

## ✅ Hotové milníky (kontext)
- Habit tracker (F52): denní/týdenní/měsíční frekvence, měřitelné návyky, statistiky Týden/Měsíc/Rok, proklik buněk = editace, posun po týdnech + tlačítko Dnes.
- Lezení (na produkci).

---
*Pozn.: Toto je živý seznam priorit. Velká vize = vícefázový projekt, ne jednorázová změna — rozdělit na milníky až se k tomu dostaneme.*

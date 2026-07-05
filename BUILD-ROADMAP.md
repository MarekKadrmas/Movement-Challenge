# Build roadmapa — Momentum (redesign do appky)

## Východisko
- **Ostrá:** F1–F47 na produkci. Bezpečnost **Fáze 0 hotová + ověřená na TESTu** (RLS, hardening, claim kódy).
- **Podklad:** finální design `tools/browser/redesign-designed-v2.html` (**Momentum**, paleta, 46 SVG ikon, branding) + kompletní blueprint mockup (`redesign-pro.html`) + `REDESIGN-SPEC.md` + `ICON-INVENTORY.md`.
- **Pravidla (neměnit):** vše v **TEST prostředí** (v1.5-test + test DB), ostrá **čeká na výslovný pokyn** (cutover all-at-once). Před každou DB změnou **backup** (`db-backup.js`). Po změně scoringu **přepočet historie**. Design replikuju **1:1 z kódu v2**, nehádám.

## Princip
Appka **má funkční logiku** (scoring, DB, CRUD, auth). Redesign = **reskin + nová IA + nové funkce**, NE přepis od nuly. Držíme logiku, měníme vzhled a přidáváme.

---

## Fáze 1 — Design systém + skeleton  *(základ pro vše, L)*
- Design tokeny (paleta light/dark, fonty Figtree + Space Grotesk, `--env` systém), **46 SVG ikon** (sprite) — z v2 kódu 1:1.
- Nová **IA**: 4 taby Dnešek / Parta / Návyky / Já + centrální **＋** + spodní lišta (ekvidistantní).
- **Branding:** název Momentum, app ikona, PWA manifest + icons + splash.
- ✅ Test: appka má nový vzhled + navigaci (i s rozpracovanými obrazovkami).

## Fáze 2 — Zápis (＋)  *(M)*
- Cvik (3 režimy) / Aktivita / **Běh (km)** / **Lezení** (systém + cesty) / náročnost s příklady / edit + smazat.
- **Admin „za koho"** (jen admin).
- Napojit na **stávající scoring + DB**.
- ✅ Test: zápis všech typů funguje v novém designu, body sedí.

## Fáze 3 — Dnešek + Parta  *(reskin stávajícího, M)*
- **Dnešek:** prsten, týden, žebříček (podium), návyky dnes, feed (UI shell).
- **Parta:** žebříček (období/kategorie), heatmapa, rekordy, karta hráče, rok party, historie, detail dne.
- ✅ Test: přehledové obrazovky v novém designu, data z DB.

## Fáze 4 — Návyky  *(M)*
- Seznam + odškrtávání, **tvorba** (frekvence vč. Měsíčně/Ročně, „Více možností", platnost od–do), **zápis hodnoty** (stepper/posuvník/kolečko), **statistiky per-návyk**, knihovna, prázdné stavy.
- ✅ Test: habit tracker kompletní v novém designu.

## Fáze 5 — Já + Účet + Admin  *(M)*
- Profil, historie + edit, úprava profilu, jak se boduje, auth (registrace/zapomenuté/odkaz/nové heslo), claim 2 kroky.
- **Admin model:** přepínač, zápis/úprava za druhé, **audit historie úprav** + upozornění adminovi.
- ✅ Test: účet + admin flow funkční.

## Fáze 6 — Retence (net-new backend)  *(L)*
- **Liga týdne** (uzávěrka, vítěz, reset, historie vítězů) — DB + logika.
- **Feed + reakce + komentáře** — DB tabulky + realtime.
- **Cíle & ochrana série** — DB + logika.
- **Milníky / konfety**, gap + load bar v žebříčku.
- **Pozvat kamaráda** (admin RPC: vytvoř profil + kód) + onboarding.
- ✅ Test: sociální/herní vrstva funguje.

## Fáze 7 — Notifikace (push)  *(M)*
- Service worker + web push (liga končí, dohnal tě parťák, reakce/komentář, vítěz týdne) + obrazovka Notifikace (nastavení).
- ✅ Test: push chodí, přepínače fungují.

## Fáze 8 — Cutover na PROD  *(na výslovný pokyn Marka)*
- F52 SQL (RLS + hardening + `F52-rls-func-lockdown.sql`), **H1 confirm-email + Resend SMTP**, přepočet historie.
- **All-at-once**, po explicitním pokynu. (leaked-pwd skip — free plán.)

---

## Doporučené pořadí
1 → 2 → 3 → 4 → 5 (redesign + funkce v test appce) → 6 → 7 (retence + notifikace) → **8 cutover**.
Každá fáze je testovatelná samostatně. Net-new UI (liga/feed) se v Fázi 3 postaví jako shell, backend se dopojí ve Fázi 6.

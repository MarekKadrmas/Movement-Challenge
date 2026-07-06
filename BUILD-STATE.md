# BUILD-STATE — stav appky pro Momentum redesign

> Průzkumný report (read-only), vygenerováno 2026-07-06. Zdroje: `index.html` (6704 řádků, branch `v2.0-test`) a mockup `C:\Claude Code\tools\browser\momentum-iphone.html` (42 obrazovek).
>
> **Git stav:** branch `v2.0-test`, čistý až na rozpracovaný `BACKLOG.md` (nestageováno). Poslední commity: `b1399b9` (test indikátor), `4a326c7`/`0aa6393`/`3fd6fd6`/`866bd8d` (Fáze 3 — Dnešek 1:1 přes Shadow DOM), `884969b` (Fáze 1 — design systém + skeleton).
>
> **Existující plánovací dokumenty** (už v repu, stojí za přečtení před stavbou dalších obrazovek): `BUILD-ROADMAP.md` (fáze 1–8, viz níže), `BACKLOG.md` (vize + priority), `REDESIGN-IA.md` (volba informační architektury — 4 taby Dnešek/Parta/Návyky/Já vyhrálo), `REDESIGN-SCREENS.md` (obsahová logika obrazovky Dnešek), `REDESIGN-SUBSCREENS.md` (kritický průchod 17 podobrazovek s 🔧 poznámkami co doladit), `REDESIGN-ITER2.md` (spec pro prsten/ligu/feed/kalendář/rekordy). Tento report se soustředí na **stav kódu appky**, ne na re-analýzu designu — ten už je hotový v mockupu a v těchto docs.

---

## 0. Roadmapa (z `BUILD-ROADMAP.md`) — kde jsme

| Fáze | Obsah | Stav |
|---|---|---|
| 1 | Design systém + skeleton (tokeny, 46 SVG ikon, IA 4 taby, PWA branding) | ✅ hotovo (`884969b`) |
| 2 | Zápis (＋) — cvik/aktivita/běh/lezení v novém designu | ❌ nezačato — `openModal()` pořád starý design |
| 3 | Dnešek + Parta reskin | 🟡 **jen Dnešek hotový** (Shadow DOM, `renderDnesek`). **Parta ještě NE** — `renderPlayers()` starý design |
| 4 | Návyky (nový design) | ❌ nezačato — `renderNavyky()` starý design (funkčně hotovo, vizuálně staré) |
| 5 | Já + účet + admin (nový design) | ❌ nezačato |
| 6 | Retence (net-new backend): liga týdne, feed+reakce+komentáře, cíle & ochrana série, pozvat kamaráda, milníky | ❌ nezačato — chat/reakce byly dokonce **odstraněny** (viz sekce 5) |
| 7 | Notifikace (push, service worker) | ❌ nezačato |
| 8 | Cutover na PROD | čeká na výslovný pokyn Marka |

---

## 1. Render architektura

- Appka je jeden `index.html` (Alpine-less vanilla JS, Supabase JS klient jako `db`). Views se přepínají přes `state.view` a čtyři `<div id="view-...">` kontejnery (`view-prehled`, `view-hraci`, `view-navyky`, `view-historie`), viditelnost řízená přímým `style.display` togglem v listeneru na `.tb-btn` (řádky 6598–6611).
- **Tab bar** (`#mc-tabbar`, ř. 2300–2305) má 4 položky: `prehled` (Dnešek), `hraci` (Parta), `navyky` (Návyky), `historie` (Já) — přesně mockupová IA.
- **Momentum / Shadow DOM systém (zatím JEN pro Dnešek):**
  - `<template id="mm-tpl">` (ř. 1962) obsahuje **doslovné CSS z mockupu** (stejné CSS proměnné `--green/--blue/--card/--sep/...`, stejné třídy `.hero`, `.ring`, `.lc`, `.lr`, `.hl`, `.hbm`, `.nav` atd. — 1:1 zkopírováno z `momentum-iphone.html`).
  - `<svg id="momentum-sprite">` (ř. 1914) = sprite se všemi ikonami mockupu (`i-flame`, `i-bolt`, `i-crown`, `i-check`, …), klonuje se do shadow rootu.
  - `renderDnesek()` (ř. 4789–4845): najde `host = #dnesek-mm` (ř. 2308, uvnitř `#view-prehled`), vytvoří/znovupoužije `host.attachShadow({mode:'open'})`, do shadow rootu vloží klon `mm-tpl` obsahu + klon sprite + vlastní overlay `<style>` (mění `.scr` na `width:306px` bez rámečku telefonu) + samotný markup (nav/hero/ring/leaderboard/feed).
  - **Škálování:** `const z = Math.max(1, window.innerWidth) / 306; scrEl.style.zoom = z;` — mockup je navržený na šířku 306px (obsah uvnitř iPhone rámu), appka ho roztáhne `zoom`em na celou šířku reálného telefonu. Height se dopočítá `window.innerHeight / z`. Re-render při `resize` (jen když `state.view === 'prehled'`).
  - Zbytek `#view-prehled` (starý leaderboard hero, period-tabs atd., ř. 2309+) **zůstává v DOM, ale je natvrdo schovaný** pravidlem `#view-prehled > :not(#dnesek-mm){display:none!important;}` (ř. 1906). Tzn. `renderAllViews()` pořád volá `renderLeaderboardTotal()`, `renderLeaderboardWeek()`, `renderHeatmap()` atd. (mrtvý výpočet/DOM, nikdo ho nevidí) — buď legacy k odstranění, nebo záměrný fallback.
  - `mmChrome()` (ř. 4778): na `state.view==='prehled'` schová starou tab bar (`#mc-tabbar`) i `.header`/`.fab-group` — Dnešek má vlastní `mmBar()` tab bar vykreslenou uvnitř shadow DOM (4 ikony floating).
  - `mmGo(v)` (ř. 4777): programové přepnutí view (klikne na skutečné `.tb-btn[data-view=...]`) — používá se z odkazů uvnitř Shadow DOM (`onclick="mmGo('navyky')"` atd.), protože ty needí na obyčejné globální funkce.
- **Views 2–4 (Parta / Návyky / Já) žádný Shadow DOM nemají** — renderují se přímo do světlého DOM starými render funkcemi a starým CSS (viz sekce 2).

## 2. Co je hotové v Momentum stylu vs. starý design

**Hotovo v Momentum stylu (Shadow DOM, 1:1 mockup CSS):**
- `renderDnesek()` (ř. 4789) — jediná obrazovka. Obsahuje: hlavičku (datum + pozdrav + streak + ＋), prsten týdne (body/trend/průměr), 3 statistiky (body/tréninky/rekord dne), dlaždici „Návyky dnes" (proklik na `navyky`), TOP-7 žebříček týdne s odznakem u mě, feed „Dění v partě" (posledních 5 záznamů + „dohání tě" hint), spodní tab bar.

**Ještě starý design (funkčně hotovo/rozpracováno, vizuálně pre-Momentum):**
- `renderPlayers()` (ř. 4519) — Parta/hráči, karty `.player-card` se starým CSS, PR sekce, celkové statistiky. Odpovídá mockup skupině **2 · Parta**, ale ne v novém vzhledu.
- `renderScoringExplanation()` (ř. 4653) — „Jak funguje bodování" (mockup 4.3 „Jak se boduje", momentálně vklíněno pod Parta místo Já).
- `renderNavyky()` + celý habit tracker cluster (`renderHabitWeekStrip`, `renderHabitStats`, `renderHabitCatTabs`, `renderHabitPresets`, `renderHabitDays`, `renderHabitCastChips`, `renderHabitKotvaChips`) — funkčně bohatý (frekvence denní/týdenní/měsíční/roční, statistiky týden/měsíc/rok, knihovna presetů), ale starý vizuál (`.habit-card`, `.habit-empty` atd.), ne mockup CSS.
- `renderAllEntries()` / `renderEntryGroup()` / `renderPlayerEntries()` (Já → Moje historie / Historie party) — starý design.
- `renderLoginScreen()` (ř. 4239) — **legacy**, používá se jen z `openSwitchPlayer()` (admin-device přepínání hráčů), NE jako hlavní přihlašovací obrazovka. Primární login je `#auth-form` (Supabase Auth e-mail+heslo, `mcAuthSubmit()`) + claim flow (`showClaim`/`pickClaim`/`mcClaimConfirm`) — obojí starý CSS (`.login-*`, `.auth-*` třídy), ne mockup.
- `openModal()` / `renderVariedSeries()` / `renderLezeniRoutes()` / `renderDatePicker()` — jeden univerzální modal pro zápis (cvik/aktivita/lezení/admin-za-koho), starý design; mockup to má rozdělené do samostatných bottom-sheetů (`formcvik`, `formcviks`, `formcvikv`, `formbeh`, `formlez`, `formadmin`, `datum`).

## 3. `state` objekt — reálná data k dispozici (ř. 3102–3139)

```js
state = {
  players: [],           // hráči (viz DB shape níže) — leaderboard, avatary, admin flag
  cviky: [],              // záznamy cviků (shyby/dřep/kliky/dipy)
  aktivity: [],           // záznamy aktivit (běh/aktivita/stretching/lezení — rozlišeno polem je_stretching + poznamka JSON pro lezení)
  history: [],            // player_history — audit log úprav profilu (kdo/co/kdy změnil)
  habits: [], habitLogs: [],  // F52 habit tracker

  selectedPlayer, selectedCvik, selectedLevel, selectedStretch,  // stav rozepsaného formuláře zápisu
  serieMode: 'single'|'same'|'varied', variedSeries: [],
  entryType: 'cvik'|'aktivita'|..., view: 'prehled'|'hraci'|'navyky'|'historie',
  editMode, editId, editTable,               // editace existujícího záznamu
  editorPlayer, playerBeingEdited,           // editace cizího profilu (admin)
  selectedDate, pickerYear, pickerMonth,     // date picker pro zápis

  peCurrentPlayer, peTypeFilter,             // modal "všechny záznamy hráče"
  historyPlayerFilter, historyTypeFilter, historyMonthsLoaded, recentMonthsLoaded,
  totalPeriod: 'week'|'month'|'all', periodMode, periodAnchor, totalCategory,

  currentPlayerId,        // F19: přihlášený hráč (odvozeno i ze Supabase Auth session)
  isGuest,                // F45: read-only guest mode (?guest=true)

  lezeniDisc: 'boulder'|'lano', lezeniRoutes: [{grade, sys, idx}],

  habitEditId, habitView, habitCat, habitSearch, habitFreq, habitIcon, habitColor,
  habitZapis, habitDays, habitCast, habitDay, habitValueId, habitTab: 'dnes'|'stats',
  statRange: 'tyden'|'mesic'|'rok', statAnchor
}
```

**DB tvar záznamů (z insert/select payloadů), pro appku dostupné po `loadData()`:**
- `players`: `id, jmeno, pohlavi, vaha, vyska, max_shyby, max_drep, max_kliky, max_dipy, max_boulder, max_lano, barva, aktivni, created_at, is_admin, auth_user_id` (H5: `email`/`password_hash` se **nečtou** do appky — bezpečnostní hardening).
- `cviky`: `player_id, cvik, opakovani, pridana_vaha, body, poznamka, datum, created_at`.
- `aktivity`: `player_id, nazev, uroven, body, datum, km, je_stretching, poznamka` (`poznamka` = JSON `{mode:'lezeni', discipline, routes}` pro lezení).
- `player_history`: `player_id, changed_by_player_id, field_name, old_value, new_value, created_at` (audit log úprav profilu → mapuje se na mockup 4.2b „Historie úprav").
- `habits`: `player_id, nazev, ikona, barva, frekvence_typ, frekvence_cil, frekvence_dny, mira_typ, zapis_typ, cil_hodnota, cil_jednotka, cast_dne, kotva, poznamka, zacatek, konec, poradi, archived`.
- `habit_logs`: `habit_id, player_id, datum, hodnota`.
- **Nepoužívané/legacy tabulky:** `chat_messages`, `chat_reactions` — zůstaly v DB jako historický backup po odstranění chatu (viz sekce 5), appka je nikde nečte.

**Odvozené výpočty (klíčové pro napojení nových obrazovek):**
- `computeStreak(playerId)` (ř. 3574) — série po sobě jdoucích dní se záznamem, s "grace day" (dnešek se ještě nemusí započítávat).
- `computePersonalRecords(playerId)` (ř. ~3638, F34) — osobní rekordy (nejvíc kliků/shybů/dřepů/dipů, nejdelší běh, nejvíc bodů/den...), 6 typů.
- `sumRoundedBody(entries)` — součet bodů přes cviky+aktivity.
- `calcPlayerStats(playerId)` — celkové statistiky za celou dobu (počty po cvicích, km aktivit...).
- `mmWeek()` (ř. 4776) — aktuální týden (po–ne) jako `{from, to, start, end}`, používá `renderDnesek`.

## 4. Seznam render funkcí (podle výskytu v souboru)

| Řádek | Funkce | Obrazovka / účel |
|---|---|---|
| 3773 | `renderWeekLabel()` | popisek období (starý leaderboard) |
| 3860 | `renderLeaderboardTotal()` | starý leaderboard „Celková historie" (view-prehled, teď schovaný) |
| 3918 | `renderLeaderboardWeek()` | alias na total |
| 3920 | `renderHeatmap()` | heatmapa aktivity (starý, view-prehled) |
| 4013 | `renderRecent()` | „Poslední záznamy" (starý, view-prehled) |
| 4042 | `renderAllEntries()` | Historie / Já → všechny záznamy s filtry |
| 4094 | `renderEntryGroup(group)` | seskupení záznamů podle dne |
| 4138 | `renderPlayerEntries()` | modal „všechny záznamy hráče" |
| 4239 | `renderLoginScreen()` | legacy login (jen admin switch-player) |
| 4376 | `renderEntryCard(e, withActions)` | jedna karta záznamu |
| 4519 | `renderPlayers()` | **Parta** — karty hráčů, PR, statistiky (starý design) |
| 4653 | `renderScoringExplanation()` | „Jak se boduje" |
| **4789** | **`renderDnesek()`** | **Dnešek — Momentum/Shadow DOM (hotovo)** |
| 4847 | `renderAllViews()` | master re-render (volá všechny výše po loadData/akci) |
| 4894 | `renderHabitWeekStrip()` | týdenní pruh dnů nad Návyky |
| 5033 | `renderHabitStats()` | statistiky návyků (týden/měsíc/rok) |
| 5201 | `renderNavyky()` | **Návyky** — denní checklist (starý design) |
| 5492 | `renderHabitCatTabs()` | kategorie v knihovně návyků |
| 5502 | `renderHabitPresets()` | knihovna presetů návyků |
| 5583 | `renderHabitDays()` | výběr dnů frekvence (tvorba návyku) |
| 5612 | `renderHabitCastChips()` | chipy „část dne" |
| 5618 | `renderHabitKotvaChips()` | chipy „kotva" (habit stacking) |
| 5825 | `renderDatePicker()` | kalendář ve formuláři zápisu |
| 5925 | `renderLezeniRoutes()` | řádky cest ve formuláři lezení |
| 6032 | `renderVariedSeries()` | řádky sérií ve formuláři cviku |

Pomocné Momentum funkce (ne `render*`, ale patří k Dnešku): `mmGreet` (4775), `mmWeek` (4776), `mmGo` (4777), `mmChrome` (4778), `mmFirst` (4779), `mmBar` (4781).

## 5. Mapování mockup (42 obrazovek) → appka

Mockup je generovaný přes `S.<key>()` šablony (viz `momentum-iphone.html` ř. 496–535), seskupené do 5 větví: **1·Dnešek** (8 podobrazovek), **2·Parta** (6), **3·Návyky** (9), **4·Já** (9), **5·Přihlášení** (5) + 5 root obrazovek = 42.

| Mockup klíč | Popis | Appka — odpovídající funkce/view | Stav |
|---|---|---|---|
| **1 · Dnešek** (root) | Domovská | `renderDnesek()`, `view-prehled` | ✅ hotovo |
| 1.1 `formcvik` | ＋ Cvik jedna sada | `openModal()` + `state.entryType='cvik'`, `serieMode='single'` | 🟡 funkčně ano, vizuálně starý modal |
| 1.1b `formcviks` | Cvik stejné série | `serieMode='same'` | 🟡 stejný modal, starý design |
| 1.1c `formcvikv` | Cvik různé série | `serieMode='varied'`, `renderVariedSeries()` | 🟡 starý design |
| 1.1d `formadmin` | Admin — zápis za hráče | `buildPlayerPills()` + `player-select-field` v modalu (viditelné jen adminovi) | 🟡 starý design |
| 1.2 `formakt` | ＋ Aktivita | `state.entryType='aktivita'` v modalu | 🟡 starý design |
| 1.2b `formbeh` | Aktivita → Běh (km) | pole `aktivita-km` v modalu | 🟡 starý design |
| 1.3 `formlez` | Aktivita → Lezení | `state.lezeniDisc`, `renderLezeniRoutes()` | 🟡 starý design |
| 1.4 `datum` | Výběr data | `openDatePicker()`, `renderDatePicker()` | 🟡 starý design (jen týden, ne celý měsíc — viz REDESIGN-SUBSCREENS.md) |
| **2 · Parta** (root) | Přehled ostatních | `renderPlayers()`, `view-hraci` | ❌ starý design |
| 2.1 `profil` | Karta hráče | součást `renderPlayers()` (`.player-card`) | 🟡 data existují, samostatná obrazovka/detail chybí |
| 2.2 `rekordy` | Rekordy & maximálky | `computePersonalRecords()` + `.pr-section` v `renderPlayers()` | 🟡 data existují, chybí samostatná obrazovka |
| 2.3 `rokparty` | Rok party (roční heatmapa) | ❌ **chybí** — nic obdobného nenalezeno (jen `renderHeatmap()` = starý, jiný rozsah) | ❌ TODO |
| 2.4 `zaznamy` | Historie party | `renderAllEntries()` s `historyPlayerFilter` (částečně) | 🟡 existuje jako "Historie" v Já, ne jako podobrazovka Party |
| 2.5 `den` | Detail dne | ❌ **chybí** — appka nemá pohled "všichni v konkrétní den" | ❌ TODO |
| 2.6 `feed` | Feed s reakcemi + komentáři | ❌ **odstraněno** (F18, "2026-05-21 — Marek decision: use Messenger instead"), DB tabulky `chat_messages`/`chat_reactions` zůstaly jako backup. Lehká verze bez reakcí existuje v `renderDnesek()` (feed "Dění v partě") | ❌ TODO / net-new (Fáze 6) |
| **3 · Návyky** (root) | Habit tracker přehled | `renderNavyky()`, `view-navyky` | ❌ starý design (funkčně hotovo) |
| 3.1 `statistiky` | Statistiky návyků | `renderHabitStats()` | 🟡 starý design |
| 3.2 `knihovna` | Knihovna návyků | `renderHabitPresets()`, `renderHabitCatTabs()`, `HABIT_ICONS` | 🟡 starý design |
| 3.3 `tvorba`/`tvorba2/3/4`/`tvorbad` | Nový návyk (denní/vybrané dny/týdně/měsíčně/ročně) | formulář návyku (`habitFreq`, `renderHabitDays()`) | 🟡 starý design, ale frekvence roční `tvorbad` — ověřit pokrytí `frekvence_typ` |
| 3.4 `zapis` | Zápis hodnoty návyku | `editHabitCell()`, `openHabitModal()` | 🟡 starý design |
| 3 `navykyempty` | Prázdný stav | `renderNavyky()` (`habit-empty`) | 🟡 existuje, starý design |
| **4 · Já** (root) | Osobní svět/nastavení | ❌ **chybí jako samostatný tab obsah** — appka nemá souhrnnou "Já" domovskou obrazovku, `view-historie` je jen seznam záznamů | ❌ TODO (hub obrazovka) |
| 4.1 `historie` | Moje historie | `renderAllEntries()` s filtrem na sebe | 🟡 starý design |
| 4.1b `editzaznam` | Úprava/smazání záznamu | `openEditModal(id, type)` | 🟡 starý design |
| 4.1c `histempty` | Historie prázdná | `.entries` prázdný stav v `renderAllEntries()` | 🟡 starý design |
| 4.2 `uprava` | Úprava profilu | `openPlayerModal`/`savePlayerEdit` (kolem ř. 6500) | 🟡 starý design |
| 4.2b `historieuprav` | Historie úprav profilu | `openPlayerHistory()` (ř. 6564), čte `state.history` | 🟡 starý design, funkčně hotovo |
| 4.3 `bodovani` | Jak se boduje | `renderScoringExplanation()` | 🟡 starý design, zavěšeno pod Parta ne Já |
| 4.4 `notifikace` | Notifikace (nastavení) | ❌ **chybí zcela** — žádný push/notifikační systém | ❌ TODO (Fáze 7) |
| 4.5 `cile` | Cíle & ochrana série | ❌ **chybí zcela** — `computeStreak` počítá streak, ale žádná "ochrana série" (streak freeze) ani uživatelské cíle | ❌ TODO (Fáze 6, net-new) |
| 4.6 `pozvat` | Pozvat kamaráda (admin) | Existuje **jiný** mechanismus — párovací kód / claim (`showClaim`, `pickClaim`, `mcClaimConfirm`, RPC `claim_profile`) — hráč se claimne na existující (adminem předvytvořený) profil, ale appka nemá obrazovku "vygeneruj a pošli pozvánku" | 🟡 příbuzná funkce existuje, mockup obrazovka chybí |
| **5 · Přihlášení** (root) | Auth | `#auth-form`, `mcAuthSubmit()` (Supabase Auth e-mail/heslo) | 🟡 starý design, funkčně hotovo |
| 5.1 `claim` | Výběr profilu | `showClaim()`, `pickClaim()`, `mcClaimConfirm()` | 🟡 starý design |
| 5.2 `registrace` | Registrace | `toggleAuthMode()` → signup větev `mcAuthSubmit()` | 🟡 starý design |
| 5.3 `forgot` | Zapomenuté heslo | `showForgotForm()` | 🟡 starý design |
| 5.4 `authsent` | Odkaz odeslán | `#auth-sent` blok | 🟡 starý design |
| 5.5 `newpass` | Nové heslo | `showResetForm()`, `mcSetNewPassword()` | 🟡 starý design |

**Shrnutí:** z 42 mockup obrazovek má appka reálná data/logiku pro cca 33–35 z nich (chybí čistě: **2.3 Rok party, 2.5 Detail dne, 4.4 Notifikace, 4.5 Cíle & ochrana série, 4.6 Pozvat kamaráda jako samostatná obrazovka, 2.6 Feed s reakcemi** — všechny tyto jsou explicitně v `BUILD-ROADMAP.md` Fázi 6/7 jako "net-new backend"). Ze zbytku je **jen Dnešek (root)** vizuálně hotový v Momentum stylu; všechno ostatní běží na starém CSS/starých render funkcích i když data/logika existují.

## 6. Datová vrstva — kam se napojit

- **`loadData()`** (ř. 6613–6666, async) — hlavní bootstrap: čeká na `db.auth.getSession()`, pak paralelně stáhne `players`, `cviky`, `aktivity`, `player_history` (Promise.all), zvlášť (odděleně, ať appka nespadne když tabulky neexistují) `habits` + `habit_logs`. Řeší i password-recovery redirect a claim-flow větev. Na konci volá `renderAllViews()`.
- **`renderAllViews()`** (ř. 4847) — master re-render volaný po každé změně dat (po uložení záznamu, po loadData, po smazání...). Zavolá `renderDnesek()` + všechny staré render funkce. Nové obrazovky (Parta/Návyky/Já v Momentum stylu) se sem budou muset přidat.
- **Body/scoring:** `sumRoundedBody()` sčítá `body` sloupec (počítá se už při zápisu a ukládá se přímo do DB, appka ho nepočítá znovu při čtení — bodovací vzorec žije ve formulářových `computeCvikBody`/`computeAktivitaBody`-like funkcích při ukládání, ne při renderu).
- **Žebříček:** `renderDnesek()` počítá inline (`board = state.players...map(...).sort(...)`) — filtr na aktuální týden přes `mmWeek()`. Starý leaderboard (`renderLeaderboardTotal`) podporuje navíc period `week/month/all` a kategorie (`totalCategory`) — při stavbě nové Party obrazovky (2.x) se vyplatí vzít filtrovací logiku odtud, ne psát znovu.
- **Streak:** `computeStreak(playerId)` (ř. 3574).
- **Personal records:** `computePersonalRecords(playerId)` (~ř. 3638, F34 blok, 6 typů rekordů, `prToast()` pro oslavnou notifikaci při novém rekordu).
- **Habit tracker CRUD:** insert/update/delete na `habits` a `habit_logs` roztroušené kolem ř. 5321–5432 (log hodnoty) a ř. 5679–5710 (CRUD návyku samotného).
- **Auth:** `db.auth.signUp/signInWithPassword/getSession/signOut`, napojení na `players.auth_user_id` v `loadSessionPlayer()` (ř. 3167). Claim flow přes RPC `claim_profile` (server-side, přímý PATCH je v DB zakázaný — H4 hardening).
- **Bezpečnost (relevantní při napojování nových obrazovek na profil hráče):** appka NEsmí číst `email`/`password_hash` z `players` (H5) — `loadData()` select už to respektuje, jen pozor při psaní nových selectů.

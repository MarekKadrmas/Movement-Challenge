# Redesign — 2. iterace (prsten, liga, feed, kalendář, rekordy)

Mám vše, co potřebuji. Kód potvrzuje strukturu i tokeny z návrhů. Píšu finální spec.

---

# FINÁLNÍ SPEC — 5 bodů, sladěno

Marku, tady je jeden konkrétní, hotový návrh za každý bod. Vše jsem ověřil přímo v `redesign-pro.html`, takže se to dá rovnou vymodelovat. Držím tvoje pravidla: přehlednost, minimální tření, žádné gradienty po ploše, žádné laciné barvy, samovysvětlující na první pohled.

**Tři pravidla, která platí napříč všemi 5 body (konzistence):**
1. **Šipky vždy jen jako malá barevná ikona těsně u čísla/textu, nikdy samostatně.** ▲ růst = zelená (`#0FA968` / dark `#34D399`), ▼ pokles = červená (`#E5484D`), beze změny = šedá (`#6B7280` / token `--sec`). Vždy ji doprovází celé slovo (víc/míň).
2. **Zelená sytost = kolik pohybu.** Všechny mřížky (heatmapa dne, roční přehled) používají JEDNU zelenou škálu opacit `[0, .28, .55, .9]` na `var(--green)`. Nikdy více barev na „kdo“.
3. **↓ = rozbalí na místě, → = odejde na jinou obrazovku.** Platí pro „Načíst starší ↓“ i „Celá historie →“.

---

## 1) PRSTEN (obrazovka Dnešek)

**Co je špatně dnes (ř. 149):** prsten hlásí `▲ 35 · 75 %` a pod tím `ø 80 b/den` — to jsou 3–4 holá čísla a symboly, které nutí luštit. Vedle jsou 3 řádky statistik. Moc věcí na jeden pohled.

**Co udělat:**

**Uvnitř prstenu (3 řádky, vycentrované, kruh vyplněný na dnešní % z průměru):**
- Řádek 1 — číslo dneška, velké tučné, `var(--green)`: **`60`**
- Řádek 2 — popisek, `--sec`: **`bodů dnes`**
- Řádek 3 — poměr, `--sec`, menší: **`z průměru 80`**

Slovo **„cíl“ NEPOUŽÍVAT** — 80 není cíl, který sis zadal, ale tvůj průměr. „z průměru 80“ jednou frází řekne, co je vyplnění kruhu (75 %) i co je 80. Holé „75 %“ i symbol „ø“ mizí (procento se čte z prstenu).

**Pod prstenem (mimo kruh) DVĚ krátké věty, každá na řádek:**
- Nálada podle stavu (jedna z variant):
  - když pod průměrem: **`Ještě 20 bodů na tvůj průměr`** (`--sec`)
  - když nad průměrem: **`Dnes nad průměrem, super 💪`** (`var(--green)`)
- Porovnání s včerejškem, celou větou (nahradí matoucí „▲ 35“):
  - růst: malá ▲ + **`O 35 bodů víc než včera`** (zelená)
  - pokles: malá ▼ + **`O 12 bodů míň než včera`** (červená `#E5484D`)
  - stejně: **`Stejně jako včera`** (`--sec`)

**Vedle prstenu místo 3 volných řádků JEDEN kompaktní blok „Tento týden“** (nadpis `--sec` + 3 řádky, každý = ikona vlevo, slovo, číslo vpravo tučně):

```
Tento týden
📅  body celkem      505 b
🏋️  tréninky            6
🏆  tvůj rekord/den   120 b
```

Pod blokem jedna malá řádka s porovnáním: malá ▲ + **`o 12 % víc než minulý týden`** (zelená).

**Proč:** prsten odpovídá na jedinou otázku „Jak jsem na tom dnes?“ — proto uvnitř jen dnešek + s čím se poměřuje. Věta „O 35 bodů víc než včera“ přečte i dítě bez přemýšlení, na rozdíl od „▲ 35“. Tři karty → jedna tabulka s ikonami = oko to přečte za sekundu.

**Pojistka (když by i ten blok byl moc):** nech na Dnešku nahoře JEN prsten + věta o včerejšku, a týdenní data (505 b / 6 / 120) dej pod prsten do jemně oddělené sekce „Tvůj týden“, viditelné až po malém odscrollování. První pohled pak drží čistě jen dnešek.

---

## 2) LIGA — barevné odlišení karty (obrazovka Parta i Dnešek)

**Co je špatně dnes (ř. 58):** `.wkl` má amber podbarvení plochy `rgba(214,162,58,.14)` + amber rámeček. To je přesně ta „AI barva“ / placaté podbarvení, které nesnášíš.

**Co udělat — „Perleťová liga“, JEDNA odlišnost:** karta zůstane 100% čistě bílá jako všechny ostatní (`--card`: světlo `#FFFFFF` / tma `#161C19`). Přidá se JEN tenký **1,5px iridescentní rámeček** složený ze čtyř akcentních barev appky. Žádné podbarvení plochy, žádný rohový nádech. Barva žije jen v obrysu (~2 % povrchu karty), 98 % je čistá bílá.

Nahraď pravidlo `.wkl`:

```css
.wkl{position:relative;background:var(--card);border:1.5px solid transparent;border-radius:14px;padding:8px 12px;margin-bottom:11px;
  background-image:linear-gradient(var(--card),var(--card)),
    linear-gradient(115deg,#D6A23A 0%,#0FA968 40%,#3FAEC2 68%,#8A7BCB 100%);
  background-origin:border-box;background-clip:padding-box,border-box;
  box-shadow:var(--shadow);}
```

- Čtyři barvy rámečku = přesně akcentní proměnné appky (`--gold #D6A23A` → `--green #0FA968` → `--blue #3FAEC2` → `--purple #8A7BCB`). Není to náhodná „AI duha“, je to barevná DNA appky roztažená do oblouku → čte se jako trofej.
- **SMAŽ** celé `[data-theme="dark"] .wkl{...}` — tmavý režim zdědí rámeček automaticky (na `#161C19` působí jako perleťový lesk).
- **Žádný `::before` nádech přes plochu.**

**Odpočet `.wkls` (ř. 59):** dnes zlatý. Barvu ať nese jen rámeček, text ať zneutrální:
```css
.wkls{font-size:10.5px;font-weight:700;color:var(--sec);}
```
Text ponech: **`končí za 2 dny ›`** (je jasný).

**Bary NESAHAT** — to je hlavní čitelnost. Medailové zůstávají (`🥇 #E0A23A`, `🥈 #AEB6BC`, `🥉 #8B6FE0`), můj řádek `.wkbar.me` zelený `#34C759`, oddělený `border-top:1px dashed var(--sep)`. Nadpis **`🏆 Liga týdne`** beze změny.

**Proč:** řeší všechny tři tvoje bolesti najednou — zelená plocha nesplývá (odlišuje obrys, ne plocha), amber „AI barva“ mizí (zlatá je jen jeden ze čtyř tónů v tenké lince), gradient nepokrývá ani centimetr plochy. Perleťový obrys lidsky čte „medaile/pohár“ → i babička vidí „tady se soutěží“, bez čtení.

**Pojistka (kdyby ti perleť přišla moc lesklá):** „Pódium vlevo“ — karta čistě bílá s `border:1px solid var(--sep)`, jediná odlišnost je 4px svislý proužek u levé hrany rozdělený na TŘI pevné pásy (ne přechod): `linear-gradient(#E0A23A 0 33%,#AEB6BC 33% 66%,#CD8B5C 66% 100%)` = zlatá/stříbro/bronz = tři stupně vítězů. Doslova „žebříčkové“, nulové riziko lesku.

---

## 3) FEED „Poslední v partě“ (obrazovka Parta, ř. 186–191)

**Co udělat s hlavičkou (nahradí ř. 186):**
```html
<div class="sl"><span>Naposledy · dnes</span><a>celá historie →</a></div>
```
- Levý text je **freshness fakt, ne nadpis**. „Naposledy“ (ne „Poslední zápis“ — to na Partě svádí ke čtení „můj poslední zápis“). Hodnota za `·`:
  - dnes → **`Naposledy · dnes`**
  - včera → **`Naposledy · včera`**
  - starší → **`Naposledy · pá 20. 6.`** (zkratka dne + tečka + den. měsíc.)
- Odkaz `celá historie →`, barva `--green`, malými písmeny.

**Feed pod hlavičkou — VŠECHNY `.recday` zůstávají (ř. 187–190 nemazat).** `.recday` nese i denní součet bodů a je to strukturální oddělovač dne. Header (slovo čerstvosti) a `.recday` (oddělovač dne + součet) jsou dvě různé role — nekolidují: „Naposledy · dnes“ nahoře vs `Dnes · pá 27. 6.` níž jsou dvě různé informace. (Původní nápad smazat první `.recday` by udělal asymetrický seznam a ztratil součet nejnovějšího dne — to je tření, nedělat.)

**Chování „Načíst starší“ s tvrdým stropem (nahradí ř. 191):**
- Výchozí: ~7 dní. Pod nimi tlačítko **`Načíst starší ↓`**.
- Každý klik dogeneruje ~7 dní do minulosti, strop = 30 dní → **max 3 kliky** (7 → 14 → 21 → 30).
- Po dosažení stropu se `.loadmore` NAHRADÍ:
```html
<div class="feedcap">Zobrazen poslední měsíc</div>
<button class="loadmore loadmore--all">Celá historie →</button>
```

Nové CSS (k ř. 81):
```css
.feedcap{text-align:center;font-size:10px;font-weight:600;color:var(--ter);margin:12px 0 6px;}
.loadmore--all{color:var(--green);font-weight:800;}
```

Málo dat → `.loadmore` se vůbec neukáže, jen rovnou `Celá historie →`.

**Proč:** „Naposledy · dnes“ odpovídá na reálnou otázku „je tu čerstvo?“ místo dekorativního nadpisu bez informace. Strop drží feed krátký a rychlý na telefonu; kdo chce hloub, jde na dedikovanou historii s filtry (už existuje). Šipky ↓/→ dávají naučitelný signál bez čtení.

**Pojistka (nulová logika):** vynech inline rozbalování — header zůstane, feed ukáže napevno ~7 dní a hned pod tím jediné `Celá historie →`. Žádný strop k hlídání.

---

## 4) KALENDÁŘ / HEATMAPA „KDO CVIČIL“ (obrazovka Parta)

**Umístění — nové pořadí bloků Party shora dolů:**
1. `.wkl` **🏆 Liga týdne** (ř. 168–174)
2. **NOVĚ: heatmapa „KDO CVIČIL“** (přesunout sem `heat()` z ř. 192) — vloží se za ř. 174
3. Dvojdlaždice Rekordy + Celá historie (viz bod 5)
4. `.seg` Týden/Měsíc/Celkem + `.chips` + žebříček `.lc`
5. Feed „Naposledy“ (bod 3)
6. Body v čase (graf)

**Zruš dropdown „období ▾“.** Nahraď ho hybridem: heatmapa je scrollovatelná prstem, ale nad ní je VŽDY viditelná ovládací lišta.

**Nadpis sekce (`.sl`):** vlevo velké **`KDO CVIČIL`** (ne „Kalendář aktivity celkem“ — moc úřední), vpravo odkaz **`Celý rok →`** (`--green`).

**Ovládací lišta uvnitř `.heatcard` nad mřížkou** — grid `[‹] [rozsah] [›]` + vpravo pilulka Dnes:
- Šipky: klikací plochy min 32×32px, znak `‹` / `›` 16px, `color:var(--label)`, `background:var(--track)`, `border-radius:9px`. Levá = starší (−7 dní), pravá = novější (+7 dní).
- Rozsah uprostřed: **`14.–27. 6.`** — 11px, tučné, `--sec`, vždy ukazuje aktuální okno.
- Pilulka vpravo: **`⟳ Dnes`** — `background:var(--green);color:#fff;border-radius:999px;padding:5px 11px`. Když JSI na dnešku → zšedne (`background:var(--track);color:var(--ter)`, disabled). **Nikdy nemizí.**

**Mřížka (scrollovatelná):** wrapper `.hcells` →
```css
overflow-x:auto; scroll-snap-type:x proximity; -webkit-overflow-scrolling:touch;
overscroll-behavior-x:contain;  /* KLÍČOVÉ: brání posunu celé stránky */
```
Vnitřní grid `grid-auto-flow:column; grid-auto-columns:13px`. Sloupec jmen hráčů `.hll` **sticky** vlevo (`position:sticky;left:0;z-index:1;background:var(--card)`) → při scrollu pořád vidíš, kdo je kdo. Nejpravější sloupec = dnešek, buňky s `outline:1.5px solid var(--green);outline-offset:-1px`.

**Barvy buněk — SJEDNOTIT NA JEDNU ZELENOU (největší výhra na jasnost).** Dnes `heat()` (ř. 141) dává KAŽDÉMU hráči jinou barvu z pole `cols` = šum, sytost nic neznamená. Přepiš `heat()` na stejnou logiku jako `mheat()` (ř. 143): `rgba(15,169,104,op)` se stupni `op=[0, .28, .55, .9]` podle úrovně (0 dní = `var(--track)`, pak 3 stupně). **Sytost = KOLIK ten den nadělal, ne kdo to je.** (V dark režimu `var(--green)` = `#34D399`, škála funguje stejně.)

**Legenda (jednou, drobně pod mřížkou):** NE unicode čtverečky (rozbité napříč zařízeními), ale 4 reálné `<i>` jako `.dleg` (ř. 67): `width:9px;height:9px;border-radius:2px` s pozadím `var(--track)` → `rgba(15,169,104,.28)` → `.55` → `.9`, po stranách text **`méně`** … **`více`** (9.5px, `--ter`).

**Mikropopisek pod legendou (1 řádek, centrovaný, `--ter`):** **`Tmavší = víc pohybu ten den`**.

**Roční přehled — nová obrazovka „Rok party“** (analogicky k S.statistiky, jako kid Party, vstup přes `Celý rok →`):
- `navhdr('Rok party')`
- Segment `.seg` jako u Návyků: **`Týden / Měsíc / Rok`**, aktivní = Rok (konzistence s tím, co znáš z Návyků).
- 3 dlaždice `.stat2/.st` se samovysvětlujícími dvouřádkovými popisky:
  - **`🔥 12`** — `série party — dní v řadě, kdy aspoň 1 cvičil`
  - **`Út`** — `nejaktivnější den týdne`
  - **`263`** — `aktivních dní letos`
- `.sl` **`AKTIVITA PO HRÁČÍCH · 2026`**
- Roční mřížka: recykluj `.statg/.yg` z Návyků (ř. 91), ale řádek = HRÁČ (avatar + jméno vlevo `.lav/.lnm`), uprostřed `.yg` s `grid-template-columns:repeat(53,1fr)` = 53 týdnů, **1 buňka = 1 TÝDEN**, sytost = kolik dní ten týden hráč cvičil (stejná zelená škála), vpravo `.ct2` např. **`184 dní`** (ne jen „184×“).
- Pod mřížkou legenda + mikropopisek **`1 čtvereček = 1 týden · tmavší = víc dní`** (u roku nutné říct, že buňka = týden, jinak se to čte jako den).

**Proč:** heatmapa hned pod ligou = „kdo z party makal“ je vidět OKAMŽITĚ, bez proscrollování žebříčku a feedu. Dropdown „období ▾“ je skryté tření („nevím, co udělá, dokud nekliknu“) → pryč. Čistý swipe by měl taky skryté tření (prst neví, že jde scrollovat) → hybrid: viditelné šipky říkají „tady se listuje v čase“ na první pohled, scroll je bonus, `overscroll-behavior-x:contain` řeší konflikt se svislým scrollem stránky. Fixní tlačítko Dnes (jen zšedne) = žádné „kam zmizelo“. Jedna zelená škála = „tmavší = víc pohybu“ na první dobrou; sedm barev byl ten AI/laciný šum.

**Pojistka (ještě míň zařizování):** vypni scroll úplně, nech JEN šipky `‹ 14.–27. 6. › [⟳ Dnes]`. Heatmapa ukazuje fixních 14 dní, šipky posouvají okno o 7 dní. Nulový konflikt s gesty stránky, každý krok je viditelné tlačítko.

---

## 5) REKORDY — umístění (obrazovka Parta)

**Souhlas se zamítnutím horního přepínače „Žebříček · Rekordy · Kalendář“** — zdaňuje i toho, kdo jde jen na žebříček (nejčastější akce, 10× denně), a schovává i to, co dnes vidíš rovnou.

**Stav dnes (ověřeno):** dlaždice „Rekordy & maximálky všech“ je úplně poslední prvek Party (ř. 194–195), před lištou. Obrazovka `S.rekordy` i rekordy v profilu už HOTOVÉ jsou — jde jen o umístění dlaždice.

**Co udělat — 3 věci v S.parta:**

**1) Dvojdlaždice HNED POD ŽEBŘÍČEK** (nový řádek za uzávěrkou žebříčku ř. 185, PŘED feedem). Dvě rovnocenné dlaždice vedle sebe (`flex; gap:8px`), aby držely v jednom oku:
- LEVÁ: ikona **`🏅`** na podkladu `#E0A23A22` (jantar), velký řádek **`Rekordy`**, malý podřádek **`kdo je v čem nejlepší`**. Cíl = `S.rekordy`.
- PRAVÁ: ikona **`🕓`** na podkladu `#3FAEC222` (modrá), velký řádek **`Celá historie`**, malý podřádek **`všechny zápisy party`**. Cíl = `S.zaznamy`.

**2) Popisek zjednodušit** na `kdo je v čem nejlepší` (říká PROČ tam kliknout). Výčet „shyby · dřep · kliky · boulder…“ NE — to je 5 slov drobně, co nikdo nečte; výčet disciplín patří až do tabulky.

**3) Smaž dlaždici z konce (ř. 194–195)** — nahradily ji dvojdlaždice nahoře. Kalendář (bod 4) a Body v čase zůstávají — to je „hezké se podívat“, ne denní akce. Z hlavičky feedu můžeš odebrat `Celá historie →` (je teď v pravé dlaždici) — ale drobná redundance nevadí, obojí míří stejně.

**Obrazovka `S.rekordy` (ř. 229): BEZ ZMĚN** — už má vše (nadpis „Rekordy“, „Maximálky všech na jednom místě“, tabulka se zvýrazněním nej hodnoty zeleně `.bst`, Síň rekordů, „Jak se bodují cviky“). **Jediné drobné vylepšení:** nad tabulku dej drobně šedě (`#A7AFA9` / `--ter`) **`‹ táhni pro další cviky ›`** — tabulka má 4+ sloupce a na úzkém mobilu se scrolluje do strany; bez nápovědy uživatel neví, že vpravo je Boulder/další.

**Profil hráče (ř. 231): BEZ ZMĚN** — rekordy už nese.

**Hex:** ikona rekordů jantar `#E0A23A` na 13% podkladu `#E0A23A22`; ikona historie modrá `#3FAEC2` na `#3FAEC222`; zvýraznění nej hodnoty v tabulce `#0FA968` (light) / `#34D399` (dark). Bez gradientů.

**Kolik kliků:** srovnání všech = 1 klik (dlaždice), rekord jednoho hráče = 1 klik (jeho řádek v žebříčku). Stejně jako přepínač, ale bez nové navigační vrstvy a bez schování žebříčku.

**Proč:** vznikne jasné patro — nahoře „žhavá zóna“ (Liga → žebříček, denně), hned pod ní dvě souřadné cesty „chci vrtat hloub“ (Rekordy / Historie), viditelné najednou jedním pohledem bez scrollu. Přesně samovysvětlitelnost, kterou chceš: nahoře pořadí, pod tím dvě tlačítka „kdo je nejlepší“ a „co kdo dělal“.

**Pojistka:** kdyby dvojdlaždice byla moc, nech jen JEDNU `🏅 Rekordy` pod žebříčkem a „Celou historii“ řeš dál odkazem v hlavičce feedu. Přepínač nahoře bych nezaváděl v žádné variantě.

---

Klíčové soubory: `C:\Claude Code\tools\browser\redesign-pro.html` (prsten ř. 149, `.wkl` ř. 58–59, S.parta ř. 167–195, `heat()` ř. 141, `mheat()` ř. 143, `yg()` ř. 142).


# Příloha: návrhy po bodech (JSON)

```json
[
  {
    "key": "prsten",
    "doporuceni": "Marku, návrh je dobrý směrem, ale pořád má dva zdroje tření: (1) prsten hlásí dvě různé věci najednou (dnešní body VS cíl/průměr) a číslo \"cíl 80\" je zavádějící, protože 80 není cíl který sis dal, ale tvůj průměr; (2) tři karty pod sebou = moc textu na první pohled, poruší to \"na první dobrou\". Finální řešení: v prstenu JEN dnešek proti dennímu průměru s poctivým popiskem \"z průměru\", pod prstenem JEDNA věta-nálada. Vedle prstenu NE tři karty, ale JEDEN kompaktní blok \"Tento týden\" s třemi řádky (týden / tréninky / rekord), každý řádek = ikona + slovo + číslo. Tím se z 3 karet stane 1 přehledná tabulka a zmizí opakované nadpisy.",
    "jak": "UVNITŘ PRSTENU (3 řádky, vycentrované, kruh vyplněný na 75 % obvodu):\n  Radek 1 (44px, tučné, #0FA968 / dark #34D399): \"60\"\n  Radek 2 (14px, #6B7280): \"bodů dnes\"\n  Radek 3 (13px, #6B7280): \"z průměru 80\"   ← NE \"cíl 80\". 80 není cíl, je to tvůj průměr; napsat \"cíl\" by lhalo a při dalším pohledu (proč mi to říká cíl, který jsem nezadal?) vzniká tření. \"z průměru 80\" jednou větou řekne co je 75 % i co je 80.\n\nPOD PRSTENEM (mimo kruh, 13px, jedna řádka-nálada):\n  • když < 100 %: \"Ještě 20 bodů na tvůj průměr\" (#6B7280)\n  • když ≥ 100 %: \"Dnes nad průměrem, super 💪\" (#0FA968)\n  Tím z prstenu mizí holé \"75 %\" (čte se z vyplnění) i matoucí \"▲ 35\".\n\nVEDLE PRSTENU — místo 3 samostatných karet JEDEN blok s nadpisem a 3 řádky (každý ikona vlevo, popisek, číslo vpravo tučně):\n  Nadpis bloku (13px, #6B7280, VELKÁ ROVNÁ PÍSMENA nebo obyčejný): \"Tento týden\"\n   📅  body celkem        505 b\n   🏋️  tréninky              6\n   🏆  tvůj rekord/den    120 b\n  Pod blokem jedna malá řádka s porovnáním (13px, #0FA968 pokud růst): \"▲ o 12 % víc než minulý týden\" — šipka JEN jako malá barevná ikona těsně u textu, nikdy samostatně.\n\nPOROVNÁNÍ S VČEREJŠKEM (to co dřív mátlo jako \"▲ 35\"):\n  NEDÁVAT ho jako samostatnou kartu s velkým \"+35\" — to je pořád holé číslo co nutí luštit. Místo toho ho vlož jako jedinou větu POD nálada-řádek pod prstenem, celou větou:\n   • růst: \"O 35 bodů víc než včera\" (#0FA968, malá ▲ ikona vlevo)\n   • pokles: \"O 12 bodů míň než včera\" (#E5484D, malá ▼ ikona vlevo)\n   • stejně: \"Stejně jako včera\" (#6B7280)\n  Věta = žádné hádání \"šipka čeho, 35 čeho\".\n\nPRAVIDLO NA ŠIPKY (drž natvrdo): ▲/▼ smí být jen malá barevná ikona TĚSNĚ u textu/čísla se znaménkem, NIKDY samostatně jako \"▲ 35\". Vždy ji doprovází celé slovo (víc/míň). Barvy: růst #0FA968, pokles #E5484D, beze změny #6B7280.\n\nCO VYPUSTIT ÚPLNĚ: holé \"75 %\" jako text (čte se z prstenu), symbol \"ø\", holé \"▲ 35\", \"b/den\". Slovo \"cíl\" NEPOUŽÍVAT dokud si Marek reálně cíl nezadá — do té doby \"průměr\".",
    "proc": "Prsten odpovídá na jedinou otázku \"Jak jsem na tom dnes?\" — proto uvnitř jen dnešek + s čím se to poměřuje. Oprava proti původnímu návrhu: \"cíl 80\" je skryté tření, protože 80 není cíl, který si uživatel zvolil, ale statistika (průměr); při druhém pohledu by se ptal \"jaký cíl? kdo mi ho dal?\". \"z průměru 80\" je poctivé a jednoznačné. Tři samostatné karty pod sebou opakují strukturu nadpis+číslo+věta 3×, což je vizuální šum — sloučení do jednoho bloku \"Tento týden\" s ikonami udělá z toho tabulku, kterou oko přečte za sekundu (ikona říká co to je bez čtení). Porovnání s včerejškem jako celá věta pod prstenem řeší přesně to, co Marka štvalo (\"▲ 35\"): sedmiletý i babička přečtou \"O 35 bodů víc než včera\" bez přemýšlení. Míň čísel a nadpisů v zorném poli = rychlejší pochopení = Markovo \"na první dobrou\".",
    "alt": "Kdyby i jeden blok vedle prstenu byl moc: nech na obrazovce Dnešek JEN prsten (dnešek + \"z průměru 80\" + věta o včerejšku) a týdenní data (505 b, 6 tréninků, rekord 120) přesuň na tab Parta/Já nebo pod prsten do jemně oddělené sekce \"Tvůj týden\", která je vidět až po odscrollování. Prsten pak drží úplně čistý první pohled — jen dnešek — a týdenní přehled nikoho neruší, ale je hned dole bez extra kliku."
  },
  {
    "key": "liga_barva",
    "doporuceni": "Varianta A vylepšená — \"Perleťová liga\" ZJEDNODUŠENÁ: karta zůstane úplně stejná bílá jako všechny ostatní (světlo #FFFFFF / tma #161C19), přidá se JEN jeden 1,5px iridescentní rámeček složený ze čtyř barev appky (zlatá → emerald → modrá → purpur). ŽÁDNÝ rohový nádech, ŽÁDNÝ radial-gradient přes plochu. Rámeček je jediná odlišnost. Důvod škrtu proti původnímu návrhu: dvě odlišovací vrstvy (rámeček + 10% rohový wash) = dvě věci, které oko musí zpracovat, a ten wash je přesně to \"podbarvení plochy\", co Marek u gradientů zamítl. Jedna decentní věc je jasnější než dvě. Karta pak čte jako jediná v appce s \"trofejovým\" okrajem — samovysvětlující, že tohle je to speciální (liga), zbytek je čistý.",
    "jak": "DRŽÍ STÁVAJÍCÍ HTML beze změny (.wkl → .wklh: .wklt \"🏆 Liga týdne\" + .wkls \"končí za 2 dny ›\" → .wkbars → řádky .wkbar / .wkbar.me).\n\n1) RÁMEČEK (jediná odlišnost karty). Nahraď stávající .wkl (dnes: amber wash rgba(214,162,58,.14) + amber border — to je ta \"AI barva\", pryč s tím):\n.wkl{position:relative;background:var(--card);border:1.5px solid transparent;border-radius:14px;padding:8px 12px;margin-bottom:11px;\n  background-image:linear-gradient(var(--card),var(--card)),linear-gradient(115deg,#D6A23A 0%,#0FA968 40%,#3FAEC2 68%,#8A7BCB 100%);\n  background-origin:border-box;background-clip:padding-box,border-box;\n  box-shadow:var(--shadow);}\nUvnitř 100% čistá bílá, barva žije POUZE v 1,5px obrysu. Padding a radius sjednocené se sousední .seg kartou (radius 13–14, padding 8/12), aby to nevyčnívalo velikostí.\nSMAZAT celé pravidlo [data-theme=\"dark\"] .wkl{...} (amber) — tmavý režim dědí rámeček automaticky, na #161C19 působí jako olejový/perleťový lesk.\n\n2) NÁDECH ::before — VYPUSTIT. Žádný radial-gradient přes kartu. (Kdyby Marek na tmavém chtěl rámeček výraznější, jediná povolená úprava: [data-theme=\"dark\"] .wkl{border-width:1.5px} zůstává, barvy jsou syté dost.)\n\n3) ODPOČET .wkls: dnes je zlatý (color:var(--gold)) resp. v2 zelený — obojí přidává barvu navíc. Změň na neutrální sekundární a přidej doslovnější text, ať je to samovysvětlující:\n.wkls{font-size:10.5px;font-weight:700;color:var(--sec);}\na text z \"končí za 2 dny ›\" nech — je jasný. (Barvu ať nese jen rámeček.)\n\n4) BARY — NESAHAT, to je hlavní čitelnost. Ponech medailové: 🥇 #E0A23A, 🥈 #AEB6BC, 🥉 #8B6FE0, můj řádek .wkbar.me #34C759 (tma zůstává; hex jsou přímo v inline stylech na <i>). Můj řádek dál oddělený border-top:1px dashed var(--sep).\n\n5) DROBNOST proti splývání s .seg pod kartou: mezi .wkl a .seg je margin-bottom:11px — stačí. Nezvětšovat stín, prémiovost nese rámeček, ne těžší shadow.\n\nVÝSLEDEK: 4 barvy rámečku = 4 akcentní barvy appky (--gold/--green/--blue/--purple z :root) roztažené do oblouku → \"duha\" není náhodná ani laciná, je to barevná DNA appky = čte se jako trofej. Světlo i tma sdílí jeden rámeček.",
    "proc": "Řeší Markovo trojnapětí čistěji než původní návrh: (1) zelená splývá → rámeček odlišuje, aniž přidá zelenou plochu; (2) amber = \"AI barva\" → jednolitá zlatá plocha úplně zmizí, zlatá je jen jeden ze čtyř tónů v tenkém obrysu; (3) \"placatý gradient\" → gradient NEpokrývá ani centimetr plochy, je to 1,5px linka, tj. cca 2 % povrchu karty; 98 % je čistá bílá jako zbytek appky. Oproti verzi s rohovým nádechem ubírám druhou barevnou vrstvu — méně tření, jedna jasná signalizace místo dvou. Samovysvětlující zůstává, protože obsah (🏆, medailové bary, můj řádek \"Ty\") je nedotčený; barva jen šeptá \"tohle je speciální\". Perleťový obrys lidsky čte \"medaile/pohár\" → i dítě a babička na první pohled vidí \"tady se soutěží\", bez čtení. A protože barvy rámečku jsou přesně proměnné z appky, nepůsobí to jako cizí \"AI duha\" nalepená navrch.",
    "alt": "Varianta B — \"Pódium vlevo\" (tři pevné pruhy, žádný gradient). Kdyby perleťový rámeček přišel Markovi moc \"hravý/lesklý\". Karta čistě bílá bez rámečku, jediná odlišnost je 4px svislý proužek u levé hrany rozdělený na TŘI pevné pásy = stupně vítězů 1-2-3 (ne přechod, tři plné barvy = vůbec ne \"AI wash\"):\n.wkl{position:relative;overflow:hidden;background:var(--card);border:1px solid var(--sep);border-radius:14px;padding:8px 12px 8px 15px;margin-bottom:11px;box-shadow:var(--shadow);}\n.wkl::before{content:\"\";position:absolute;left:0;top:0;bottom:0;width:4px;background:linear-gradient(#E0A23A 0 33%,#AEB6BC 33% 66%,#CD8B5C 66% 100%);}\n(zlatá/stříbrná/bronz jako pevné pásy, ne plynulý gradient). Odpočet .wkls neutrálně var(--sec). Tma: proužek stejný, karta #161C19, border var(--sep). Výhoda: absolutně čisté a doslova \"žebříčkové\" — tři barvy = tři stupně → význam čitelný okamžitě, nulové riziko \"lesku\". Nevýhoda: méně prémiové/\"wow\" než perleťový obrys, blíž k běžnému list-itemu."
  },
  {
    "key": "feed",
    "doporuceni": "Zrušit nadpis \"Poslední v partě\" — správně. Nahradit ho jedním .sl řádkem: vlevo freshness fakt \"Naposledy · dnes\", vpravo emeraldový odkaz \"celá historie →\". ALE: NEMAZAT první .recday (to je chyba v původním návrhu — vznikla by rozbitá, asymetrická sekce, kde horní blok nemá datový oddělovač a spodní ano). .recday oddělovače jsou strukturální (nesou i denní součet bodů) a musí zůstat u VŠECH dní. Header a .recday si neodporují: header odpovídá na otázku \"je tu čerstvo?\" (slovem dnes/včera/datum), .recday je nadpis konkrétního dne. Aby nedošlo k doslovné duplicitě, header nese jen SLOVO (dnes/včera), zatímco datum drží .recday. Inline \"Načíst starší ↓\" nechat, s tvrdým stropem ~1 měsíc (max 3 kliky: 7 → 14 → 21 → 30 dní), pak se tlačítko nahradí drobným popiskem stropu + plným \"Celá historie →\" (šipka doprava = odchod na jinou obrazovku).",
    "jak": "HLAVIČKA SEKCE (nahradí řádek 186 v redesign-pro.html `<div class=\"sl\"><span>Poslední v partě</span><a>Celá historie →</a></div>`):\n\n`<div class=\"sl\"><span>Naposledy · dnes</span><a>celá historie →</a></div>`\n\nLevý text = freshness fakt, NE nadpis. Slovo \"Naposledy\" (ne \"Poslední zápis\") — na Partě, kde jde o celou skupinu, je \"Poslední zápis\" matoucí (čte se jako \"můj poslední zápis\"). \"Naposledy\" jednoznačně znamená \"kdy tu naposled někdo něco přidal\". Hodnota za \"·\":\n- poslední zápis dnes → \"Naposledy · dnes\"\n- včera → \"Naposledy · včera\"\n- starší → datum ve formátu appky \"Naposledy · pá 20. 6.\" (den zkratka + tečka + den. měsíc.)\nHeader nese jen slovo/datum čerstvosti; NENESE datum, které už je v prvním .recday, když je poslední zápis dnes → žádná doslovná duplicita (\"Naposledy · dnes\" nahoře vs \".recday: Dnes · pá 27. 6.\" pod tím jsou dvě různé informace: čerstvost vs oddělovač dne se součtem bodů).\nOdkaz malými \"celá historie →\" (styl .sl a: --green #0FA968 / dark #34D399, bez uppercase). Zůstává i nahoře jako rychlá zkratka.\n\nFEED POD HLAVIČKOU — beze změny struktury, VŠECHNY .recday zůstávají (řádky 187–190 nechat):\n`<div class=\"recday\">Dnes · pá 27. 6.</div>`\n`<div class=\"rec\">…frow…</div>`\n`<div class=\"recday\">Čtvrtek 26. 6.</div>`\n`<div class=\"rec\">…frow…</div>`\n(Pozn.: NEMAZAT první .recday. V reálné appce nese i denní součet \"+X b.\" — smazáním by uživatel u nejnovějšího dne přišel o součet a horní blok by vypadal jinak než spodní = tření na první pohled.)\n\nCHOVÁNÍ \"NAČÍST STARŠÍ\" S LIMITEM (nahrazuje řádek 191 `<button class=\"loadmore\">Načíst starší ↓</button>`):\n\nVýchozí stav: ~7 dní zápisů. Pod nimi inline tlačítko:\n`<button class=\"loadmore\">Načíst starší ↓</button>`\n\nKaždý klik dogeneruje ~7 dní do minulosti, max do stropu 30 dní = max 3 kliky (7 → 14 → 21 → 30). Po dosažení stropu se .loadmore NAHRADÍ tímto blokem:\n`<div class=\"feedcap\">Zobrazen poslední měsíc</div>`\n`<button class=\"loadmore loadmore--all\">Celá historie →</button>`\n\nPřesné texty:\n- Inline (pod stropem): \"Načíst starší ↓\"\n- Popisek stropu (drobný, --ter, centrovaný): \"Zobrazen poslední měsíc\"\n- Koncové tlačítko: \"Celá historie →\"\n\nŠipky nesou význam bez čtení: ↓ = rozbalí na místě, → = odejde na jinou obrazovku (stejná logika jako \"celá historie →\" v hlavičce).\n\nNOVÉ CSS (přidat k řádku 81 vedle .loadmore):\n`.feedcap{text-align:center;font-size:10px;font-weight:600;color:var(--ter);margin:12px 0 6px;}`\n`.loadmore--all{color:var(--green);font-weight:800;}`\n\nMálo dat (v partě nic staršího než pár nejnovějších zápisů): .loadmore se vůbec neukáže, pod feedem je rovnou jen \"Celá historie →\" bez popisku stropu.",
    "proc": "1) \"Naposledy\" místo \"Poslední zápis\" ruší skrytou dvojznačnost na Partě: sekce je o celé skupině, ale \"Poslední zápis\" svádí ke čtení \"můj poslední zápis\". \"Naposledy · dnes\" je na první dobrou jasné i babičce — odpovídá na reálnou otázku \"je tu čerstvo / přidal dnes někdo něco?\" místo dekorativního nadpisu, který nenesl žádnou informaci.\n2) Zachování VŠECH .recday opravuje tichou chybu původního návrhu: smazání jen prvního oddělovače by vytvořilo asymetrický seznam (horní den bez datové hlavičky, spodní s ní) + ztrátu denního součtu bodů u nejnovějšího dne. To je přesně to \"nepochopím na první dobrou\" tření, které tu nemá být. Header (slovo čerstvosti) a .recday (oddělovač dne + součet) jsou dvě různé role, takže spolu nekolidují ani se neopakují.\n3) Tvrdý strop ~1 měsíc (max 3 kliky) drží feed krátký a rychlý na telefonu; kdo chce hlouběji, jde přirozeně na dedikovanou historii s filtry (v appce už existuje view-historie s filtry hráč/typ). Konzistence šipek ↓/→ dává naučitelný signál bez čtení. Vše sedí do stávajícího jazyka (.sl, .recday, .loadmore, --sec/--ter/--green z redesign-pro.html), nic nevypadá \"nalepené\" ani \"AI\".",
    "alt": "Bez inline rozbalování úplně: header \"Naposledy · dnes / celá historie →\" zůstane, feed ukáže napevno posledních ~7 dní (nebo ~15 zápisů) a hned pod tím jediné tlačítko \"Celá historie →\". Žádný strop k hlídání, nula stavů, feed je vždy stejně krátký. Nevýhoda: kdo chce mrknout jen o pár dní zpět, musí opustit obrazovku Parta. Vhodné, když Marek chce úplně nulovou logiku; jinak doporučuji hlavní variantu s omezeným inline rozbalením (3 kliky)."
  },
  {
    "key": "kalendar",
    "doporuceni": "Heatmapu (\"KDO CVIČIL\") posuň hned pod \"Ligu týdne\" jako druhý blok Party — před segment Týden/Měsíc/Celkem i před žebříček. Dropdown \"období ▾\" zruš. Interakci ale nedělej čistým swipe-scrollem: dej HYBRID — heatmapa je horizontálně scrollovatelná PRSTEM, ale nad ní je vždy viditelná ovládací lišta s dvěma velkými šipkami \"‹ ›\" a rozsahem uprostřed (\"14.–27. 6.\"). Šipka = skok o 7 dní (jistota pro babičku), scroll prstem = plynulé listování (rychlost pro zdatné). Tím padá jediné riziko čistého scrollu (skrytá afordance + konflikt se svislým scrollem stránky) a zároveň zůstává přímá manipulace. Tlačítko návratu \"⟳ Dnes\" drž v té samé liště vpravo — NE plovoucí, NE mizící: je vždy vidět, jen ZŠEDNE (disabled) když už na dnešku jsi. Pod heatmapou odkaz \"Celý rok →\" → nová obrazovka \"Rok party\" (roční mřížka řádek/hráč + 3 čísla). Scroll ANO, ale POVINNĚ doplněný o šipky a fixní tlačítko Dnes — samotný dropdown i samotný skrytý scroll jsou obojí tření.",
    "jak": "UMÍSTĚNÍ (S.parta, redesign-pro.html ř.167): nové pořadí bloků shora → 1) blok .wkl \"🏆 Liga týdne\" (ř.168–174, zůstává), 2) NOVĚ kalendář aktivity (přesuň sem heatmapu z ř.192), 3) .seg Týden/Měsíc/Celkem + .chips + žebříček .lc (ř.175–185), 4) \"Poslední v partě\" (ř.186–191), 5) graf Body v čase (ř.193), 6) Rekordy (ř.194–195). Heatmapu tedy vlož za ř.174 (za uzavření .wkl).\n\nNADPIS SEKCE (.sl za ř.174): vlevo velké samovysvětlující \"KDO CVIČIL\" (NE \"Kalendář aktivity celkem\" — moc dlouhé/úřední), vpravo odkaz \"Celý rok →\" barva var(--green). Pod .sl karta .heatcard.\n\nOVLÁDACÍ LIŠTA (nová, uvnitř .heatcard nad mřížkou) — grid 3 sloupce: [tlačítko ‹] [rozsah] [tlačítko ›], plus vpravo pilulka \"⟳ Dnes\". Konkrétně:\n- šipky: dvě klikací plochy min 32×32px, znak ‹ a › font-size:16px, color:var(--label); background:var(--track);border-radius:9px. Levá = starší (posun -7 dní), pravá = novější (+7 dní).\n- rozsah uprostřed: text \"14.–27. 6.\" font-size:11px;font-weight:700;color:var(--sec);text-align:center. Vždy ukazuje aktuálně viditelné okno.\n- pilulka Dnes vpravo: \"⟳ Dnes\" background:var(--green);color:#fff;border-radius:999px;padding:5px 11px;font-size:11px;font-weight:700. Když JSI na dnešku → background:var(--track);color:var(--ter) (zšedne, disabled). Nikdy nemizí → žádné \"kam se podělo tlačítko\".\n\nMŘÍŽKA (scrollovatelná): .hcells wrapper → overflow-x:auto; scroll-snap-type:x proximity; -webkit-overflow-scrolling:touch; overscroll-behavior-x:contain (KLÍČOVÉ — zabrání tomu, aby vodorovný scroll heatmapy omylem posouval celou stránku). Vnitřní grid: grid-auto-flow:column; grid-auto-columns:13px (buňka min-width 13px, aby scroll dával smysl). Řádek se jmény hráčů (.hll, ř.69) STICKY vlevo: position:sticky;left:0;z-index:1;background:var(--card) → při scrollu je pořád vidět kdo je kdo. Nejpravější sloupec = dnešek: buňky dneška outline:1.5px solid var(--green);outline-offset:-1px + nad ním v liště pravá šipka › zšedne (dál doprava nic není).\n\nBARVY BUNĚK — SJEDNOŤ NA JEDNU ZELENOU (největší výhra na jasnost). Teď heat() na ř.141 dává KAŽDÉMU hráči jinou barvu (pole cols) = vizuální šum, sytost neznamená nic. Přepiš heat() ať používá stejnou logiku jako mheat() ř.143: rgba(15,169,104,op) se stupni op=[0,.28,.55,.9] podle úrovně (0 dní=var(--track), pak 3 stupně sytosti). Sytost = KOLIK ten den nadělal, ne kdo to je. (V dark režimu var(--green) je #34D399, škála funguje stejně.)\n\nLEGENDA (jednou, drobně pod mřížkou): NE unicode \"▢▪◾◼\" (renderuje se v různých velikostech, vypadá rozbitě). Místo toho reálné 4 čtverečky jako .dleg i (ř.67): 4× <i> width:9px;height:9px;border-radius:2px s background var(--track) → rgba(15,169,104,.28) → .55 → .9, po stranách text \"méně\" a \"více\" font-size:9.5px;color:var(--ter). Řádek: \"méně ◻◻◻◻ více\".\n\nMIKROPOPISEK POD LEGENDOU (samovysvětlující čtení, 1 řádek): \"Tmavší = víc pohybu ten den\" font-size:9.5px;color:var(--ter);text-align:center. Sedmiletý i babička pochopí na první pohled.\n\nROČNÍ PŘEHLED (nová obrazovka S.rokparty, analogicky k S.statistiky ř.233 a jako kid Party):\n- navhdr('Rok party')\n- segment .seg jako u Návyků: \"Týden / Měsíc / Rok\", on=Rok (konzistence s tím, co Marek zná z Návyků).\n- 3 statistické dlaždice .stat2/.st (ř.199) — samovysvětlující dvouřádkové popisky:\n  dl.1 → v:\"🔥 12\", k:\"série party — dní v řadě, kdy aspoň 1 cvičil\"\n  dl.2 → v:\"Út\", k:\"nejaktivnější den týdne\"\n  dl.3 → v:\"263\", k:\"aktivních dní letos\"\n- .sl \"AKTIVITA PO HRÁČÍCH · 2026\"\n- roční mřížka: recykluj .statg/.yg z Návyků (ř.91), ale řádek = HRÁČ místo návyku. Struktura řádku .gr (grid 64px 1fr auto): vlevo avatar+jméno (styl .lav/.lnm), uprostřed .yg s grid-template-columns:repeat(53,1fr) = 53 týdnů roku, 1 buňka = 1 TÝDEN, sytost = kolik dní ten týden hráč cvičil (stejná zelená škála [0,.28,.55,.9]), vpravo .ct2 počet aktivních dní hráče (např. \"184 dní\" — NE jen \"184×\", ať je jasné co to číslo je).\n- pod mřížkou stejná legenda + mikropopisek \"1 čtvereček = 1 týden · tmavší = víc dní\" (u roku je nutné říct, že buňka = týden, jinak to čte jako den).\n- vstup: odkaz \"Celý rok →\" z Party (viz výše).\n\nHEX/TOKENY (drž stávající): akcent světlý #0FA968 / dark #34D399 (var(--green)); prázdná buňka var(--track) #E7ECE7; popisky var(--sec)/var(--ter); karty var(--card), radius 18px, box-shadow var(--shadow). Bez gradientů, škála buněk je opacita jedné zelené (ne gradient).",
    "proc": "1) Heatmapa nahoře = \"kdo z party makal\" je vidět HNED po lize, bez proscrollování celého žebříčku, feedu a tlačítka Načíst starší. Přesně to, co Marek chtěl (\"líp vidět\").\n2) Dropdown \"období ▾\" je klasické skryté tření — Marek správně říká \"nevím co to udělá, dokud neklikneš\". Ruším ho. ALE čistý swipe-scroll, jak zněl původní návrh, má taky skryté tření: prst na mobilu neví, že mřížka jde posouvat do strany, a vodorovný scroll snadno omylem hne celou stránkou. Proto HYBRID: viditelné šipky ‹ › říkají \"tady se listuje v čase\" na první pohled (afordance je vidět, ne skrytá), scroll prstem je bonus pro rychlé. overscroll-behavior-x:contain fyzicky vyřeší konflikt se svislým scrollem. Tím mám výhody scrollu i jistotu tlačítek zároveň — proto to je lepší než buď-anebo.\n3) Tlačítko \"⟳ Dnes\", které se objevuje a mizí (původní návrh), je samo o sobě drobné tření — \"kam zmizelo\". Fixní tlačítko, které jen zšedne, je vždy na stejném místě → nulové překvapení. Rozsah \"14.–27. 6.\" pořád viditelný = uživatel vždy ví, na jaké dny kouká (řeší jediné riziko listování — ztrátu orientace v čase). Sticky jména řeší druhé riziko — ztrátu orientace, kdo je kdo.\n4) Jedna zelená škála místo 7 barev = mozek čte \"tmavší = víc pohybu\" na první dobrou. Sedm barev byl přesně ten \"AI/laciný\" šum, který Marek nesnáší, a sytost u něj neznamenala nic. Mikropopisek \"Tmavší = víc pohybu\" to dořekne slovy pro babičku.\n5) Reálné čtverečky v legendě (ne unicode) = konzistentní vzhled napříč zařízeními, žádné rozbité znaky.\n6) Roční přehled používá stejný komponent (.statg/.yg) a stejný segment jako Návyky → uživatel se učí JEDEN vzor a použije ho na dvou místech. Tři čísla (série party / nejaktivnější den / aktivní dny) jsou motivační a samovysvětlující — to je jádro appky (konzistence + soutěž). \"1 čtvereček = 1 týden\" u roku je nutné explicitně říct, jinak by to lidi četli jako den a číslo by nesedělo — to by bylo tření.",
    "alt": "Kdyby Marek chtěl ještě míň zařizování a scroll považoval za zbytečný: vypni scroll úplně a nech JEN šipky \"‹ 14.–27. 6. › [⟳ Dnes]\". Heatmapa pak ukazuje fixních 14 dní, šipky posouvají okno o 7 (nebo 14) dní, tlačítko Dnes skočí na aktuální okno. Žádný scroll = nulový konflikt s gesty stránky, každý krok je viditelné tlačítko s jasným efektem (posun o týden), i babička to zvládne bez učení. Nevýhoda: prohlížení hodně dozadu je pomalejší (klik-klik-klik místo švihnutí prstem). Umístění nahoře, jedna zelená škála i roční přehled zůstávají beze změny — mění se jen to, že mizí plynulý scroll a zůstanou čistě šipky."
  },
  {
    "key": "rekordy",
    "doporuceni": "Souhlas se zamítnutím horního přepínače \"Žebříček · Rekordy · Kalendář\" — to je správně a drž se toho. ALE původní návrh přehlíží dvě věci, které jsem ověřil přímo v kódu (redesign-pro.html), a proto ho zpřesňuju: (1) tabulka rekordů, Síň rekordů i rekordy v profilu UŽ HOTOVÉ jsou (S.rekordy ř.229, S.profil ř.231) — nejde o \"co udělat\", jen o umístění dlaždice. (2) Přesunout dlaždici jen \"pod žebříček, ale pořád doprostřed dlouhého scrollu\" pořád nechává nejčastější akci (koukni na pořadí) zamíchanou s vzácnou (srovnej rekordy). FINÁLNÍ ŘEŠENÍ: udělej z Party jasně oddělené patro. Nahoře \"žhavá zóna\" (Liga týdne → žebříček) = to, co člověk otevírá 10× denně. Hned pod žebříček dvě rovnocenné dlaždice VEDLE SEBE v jednom řádku: \"🏅 Rekordy\" a \"🕓 Celá historie\". Zbytek (kalendář, graf) až pod ně. Rekordy = 1 klik z dlaždice, rekord konkrétního hráče = 1 klik na jeho řádek v žebříčku. Žádný přepínač, žádné schování žebříčku.",
    "jak": "STAV DNES (ověřeno v redesign-pro.html): Parta (S.parta, ř.167-195) je scroll Liga → segment → chips → žebříček → \"Poslední v partě\" + Načíst starší → Kalendář → Body v čase → a AŽ ÚPLNĚ NAKONEC (ř.194-195) dlaždice \"Rekordy & maximálky všech\". Rekordy jsou doslova poslední prvek před lištou. Přesně to tření, co Marek popisuje.\n\nCO ZMĚNIT — 3 věci, všechny v S.parta:\n\n1) DVOJDLAŽDICE HNED POD ŽEBŘÍČEK (nový řádek za ř.185, tj. za uzávěrku žebříčku, PŘED \"Poslední v partě\"). Dvě dlaždice vedle sebe v jednom řádku (flex, gap 8px), aby držely v jednom oku:\n   - LEVÁ: ikona 🏅 na podkladu #E0A23A22 (jantar), velký řádek \"Rekordy\", malý podřádek \"kdo je v čem nejlepší\". Cíl = obrazovka S.rekordy.\n   - PRAVÁ: ikona 🕓 na podkladu #3FAEC222 (modrá), velký řádek \"Celá historie\", malý podřádek \"všechny zápisy party\". Cíl = S.zaznamy.\n   Tím z \"Poslední v partě\" (ř.186) můžeš odebrat odkaz \"Celá historie →\" v hlavičce — je teď redundantní, drží se to čistší.\n   Proč vedle sebe: dvě nejčastější \"chci víc\" akce (rekordy vs. historie) jsou vizuálně souřadné, člověk je vidí najednou, nemusí scrollovat a hádat.\n\n2) POPISEK DLAŽDICE zjednodušit. Původní návrh dával podřádek \"shyby · dřep · kliky · boulder · běh\" — to je 5 slov drobným písmem, které nikdo nečte a jen dělá šum. Samovysvětlující je \"kdo je v čem nejlepší\" (říká PROČ tam kliknout, ne technický výčet). Výčet disciplín patří až do tabulky.\n\n3) Dlaždici \"Rekordy & maximálky všech\" ze ř.194-195 SMAZAT z konce (nahradily ji dvojdlaždice nahoře). Kalendář (ř.192) a Body v čase (ř.193) zůstávají dole tak jak jsou — to je \"hezké se podívat\", ne \"denní akce\", tam patří.\n\nOBRAZOVKA S.rekordy (ř.229): nech BEZ ZMĚN, už splňuje vše z návrhu — nadpis \"Rekordy\", label \"Maximálky všech na jednom místě\", tabulka s .bst zvýrazněním nej hodnoty zeleně (#0FA968 / dark #34D399 tučně), Síň rekordů (🏅 Nejvíc kliků: Martin · 110, 🪨 Nejtěžší boulder: Káťa · V7), \"Jak se bodují cviky\". Jediné drobné vylepšení k zvážení: nad tabulku dát řádek \"‹ táhni pro další cviky ›\" drobně šedě (#A7AFA9), protože tabulka má 4+ sloupce a na úzkém mobilu se scrolluje do strany — bez nápovědy uživatel neví, že vpravo je Boulder/další.\n\nPROFIL HRÁČE (S.profil, ř.231): nech BEZ ZMĚN, rekordy už nese (grid max shyby/dřep/kliky/boulder + \"Osobní rekordy\").\n\nHEX: ikona rekordů jantar #E0A23A na 13% podkladu (#E0A23A22); ikona historie modrá #3FAEC2 na #3FAEC222; zvýraznění nej hodnoty v tabulce #0FA968 (light) / #34D399 (dark). Bez gradientů.\n\nKOLIK KLIKŮ: srovnání všech = 1 klik (dlaždice), rekord jednoho hráče = 1 klik (řádek v žebříčku). Stejně jako u přepínače, ale bez nové navigační vrstvy a bez schování žebříčku za klik.",
    "proc": "Tři důvody, proč je tohle jasnější a míň tření než (a) přepínač i (b) původní \"jen posuň dlaždici výš\":\n\n1) PŘEPÍNAČ zdaní každého. I člověk, co jde jen na žebříček (nejčastější akce, 10× denně), musí přečíst 3 slova a ověřit, na které záložce je. To je mikrotření na to nejčastější. Rekordy se otevírají řádově míň — nezaslouží stálé místo v horní liště. Navíc přepínač je přesný opak vlastní teze Party \"vše na jedné stránce, detaily rozklikneš\": schoval by i žebříček a kalendář za klik, i když je dnes vidíš rovnou.\n\n2) PROTI PŮVODNÍMU NÁVRHU: jen posunout dlaždici \"pod žebříček\" ji sice zvedne, ale pořád ji nechá plavat uprostřed dlouhého scrollu mezi grafy. Dvě souřadné dlaždice (\"Rekordy\" + \"Celá historie\") hned pod žebříčkem vytvoří jasné patro: nahoře \"jak vedu\" (denní), pod tím \"chci vrtat hloub\" (rekordy/historie). Uživatel vidí obě cesty ven najednou, jedním pohledem, bez scrollu a bez hádání. To je ta samovysvětlitelnost, kterou Marek chce — pochopí to i sedmiletý: nahoře pořadí, pod tím dvě tlačítka \"kdo je nejlepší\" a \"co kdo dělal\".\n\n3) POPISEK \"kdo je v čem nejlepší\" místo výčtu \"shyby · dřep · kliky · boulder\" říká DŮVOD kliknutí lidskou řečí, ne technický seznam. Míň slov, víc jasnosti — přesně minimální tření.\n\nProfil nese rekordy přirozeně: když mě zajímá Martinův rekord, kliknu na Martina, ne na abstraktní záložku. Počet kliků shodný s přepínačem (1), ale nulová nová navigace a nic se neschovává.",
    "alt": "Kdyby ti dvojdlaždice připadala jako moc prvků: nech jen JEDNU dlaždici \"🏅 Rekordy\" pod žebříčkem a \"Celou historii\" řeš dál jen odkazem v hlavičce \"Poslední v partě\" (tak jak je dnes na ř.186). Rekordy jsou vzácnější a zaslouží si vlastní dlaždici víc než historie, kterou hledá málokdo.\n\nDruhá alternativa (kdyby vadilo, že tabulka je další obrazovka): dlaždice Rekordy = SKLÁPĚCÍ accordion přímo v Partě — klepnutím rozbalí tabulku in-place pod sebou, dalším klepnutím zavře. 0 navigace, 1 tap, pořád na jedné stránce. Nevýhoda: tabulka má 4+ sloupce a na úzkém mobilu se do vertikálního scrollu vejde hůř než na plné obrazovce (musela by mít vodorovný scroll uvnitř sklápěcí sekce, což je dvojí scrollování = tření). Proto je dlaždice → plná stránka bezpečnější default. Přepínač nahoře bych nezaváděl v žádné variantě."
  }
]
```

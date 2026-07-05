# Redesign — informační architektura (návrh)

I'll analyze the four IA concepts and produce a recommendation for Marek. Let me think through this carefully — no tools needed, this is a design judgment task.

Tady je upřímné porovnání a doporučení.

---

# Doporučení k informační architektuře Movement Challenge

## 1) Krátké porovnání čtyř koncepcí

**Koncept A — „Dnešek" (3 taby: Dnešek / Žebříček / Já)**
- **Silné:** Nejvyváženější. Domovská je klidný rituál (Apple kroužky), ale soutěž i návyky jsou hned na očích jako jemné vrstvy. Filtry vyřešené chytře (segment období + tiché čipy kategorií jen na Žebříčku). Logické sloučení rozházených kusů.
- **Slabé:** Tři pevné kroužky (Cviky/Aktivity/Strečink) nesednou každému — kdo dělá jen sílu, strečinkový kroužek nikdy nezavře a vzniká frustrace. Tab „Já" hrozí, že se stane skládkou. Soutěž je o tap dál (může vadit kompetitivní partě).

**Koncept B — „Denní rituál" (3 taby: Domov / Liga / Já)**
- **Silné:** Nejsilnější Duolingo motor — plamínek série, „Cesta dne" (3 micro-cíle), streak-freeze, týdenní liga s korunou, rostoucí maskot. Nejvyšší šance vybudovat denní návyk návratu. Domov je čistý jeden „prsten dne" (ne tři).
- **Slabé:** Domov je našlapaný (prsten + série + 3 dlaždice + mini-liga) — snadno ztratí Apple klid. Maskot a konfety u party dospělých můžou sklouznout k dětskosti, když se nepřežene jen lehce. Liga = silný týdenní reset (kdo chce „celkem", musí přepínat).

**Koncept C — „Aréna" (4 taby: Aréna / Já / + / Parta)**
- **Silné:** Nejsilnější sociální tah — žebříček + živý feed jsou rovnou domovská, okamžitě vím „kde stojím a co se děje". Sednutí na kompetitivní partu je dokonalé.
- **Slabé:** Zpět na 4 taby (krok zpět v jednoduchosti). Návyky jsou schované pod „Já", takže osobní rozvoj je upozaděný. Pro slabší/zaneprázdněné hráče může „věčně poslední" demotivovat. Feed u 7 lidí bývá v klidných dnech prázdný.

**Koncept D — „Dva taby" (Výzva / Já)**
- **Silné:** Nejčistší mentální model — dvě duše appky = dvě obrazovky. Palec dosáhne na vše. Elegantní řešení kategorií (swipe + barevný mikro-proužek à la Apple).
- **Slabé:** Dvě obrazovky neunesou vše donekonečna — „Já" se přeplní (návyky + čísla + historie + heatmapa). Kategorie schované za swipem jsou špatně objevitelné. Žebříček jako tvrdý default demotivuje ty na konci. Dvě cesty k „záznamům" (moje historie vs. cizí profil) můžou mást.

---

## 2) DOPORUČENÁ architektura — HYBRID (A jako kostra + B jako motor)

Beru **strukturu konceptu A** (nejlepší rovnováha) a **napumpuju do ní gamifikační duši konceptu B** (nejsilnější návyk návratu). Z A si nechávám eleganci filtrů a tříobrazovkový model; z B beru sérii s plamínkem, „Cestu dne" a týdenní ligu. A opravuju největší slabinu A — rigidní tři kroužky.

### Tři taby + centrální „+"

**TAB 1 — „Dnešek" (ikona: jeden prsten s plamínkem uvnitř)** ← DOMOVSKÁ
Tohle je srdce. Po otevření svislý, klidný scroll:

1. **JEDEN velký prsten dne** (ne tři — to je oprava slabiny A). Prsten = celkový denní pohybový cíl v bodech. Uvnitř velké číslo dnešních bodů. Tři kategorie (síla/kardio/strečink) jsou jen **tenký trojbarevný oblouček po obvodu prstenu** (vidíš složení, ale nemusíš zavírat tři samostatné kroužky). Tím každý zavře „svůj" prsten, i kdyby dělal jen kliky.
2. **Série s plamínkem** (nad nebo vedle prstenu) — „17 dní v řadě". Hoří jasně dokud dnes nezapíšeš, po splnění se zklidní do zlaté. Streak-freeze 1× týdně (z B).
3. **„Cesta dne"** (z B) — 3 malé dlaždice denního rituálu: Pohyb · Strečink · 1 návyk. Splníš → cvakne s jemnou haptikou. Tohle je ten lehký Duolingo dopamin.
4. **Žebříčkový proužek** (z A) — jeden klidný řádek „3. — 40 b za Petrem, 12 b před Jančou". Tap = celý žebříček.
5. **Živý proud** (dole, decentní) — poslední 3-4 záznamy přátel s možností lehké reakce (🔥/👏).

> Klíč: vizuálně přísně odlehčit. Hodně bílého prostoru, velká typografie, jedna akcentní barva. Prsten + série jsou hrdě nahoře, zbytek se decentně odkrývá scrollem.

**TAB 2 — „Liga" (ikona: pohár / stupně vítězů)**
Plná soutěž jako **týdenní liga** (z B — silnější rituál než jen „žebříček"). Reset v neděli večer, klidná uzávěrka + vítěz týdne dostane korunu na profil. Nahoře plný žebříček s avatary.

**TAB 3 — „Já" (ikona: silueta v prstenu)**
Osobní svět: detail návyků a jejich editace, heatmapa aktivity, osobní rekordy, odznaky, kompletní historie tvých záznamů. **Důležité — proti slabině A:** držet přísnou vnitřní hierarchii (návyky nahoře → rekordy → archiv dole), ať to není skládka.

**Centrální „+"** (vyvýšené, akcentní, uprostřed spodní lišty — z A i C)
Dostupné ze všech tabů. Tap → bottom sheet:
- Krok 1: tři velké dlaždice Cvik / Aktivita / Strečink (barvy = barvy oblouku na prstenu → vizuální spojitost).
- Krok 2: konkrétní pohyb + množství, **body se počítají živě** („+35 b") ještě před uložením.
- Uložit → sheet zmizí, vrátíš se na Dnešek, **prsten se dotočí animací, body naskočí**. To je odměnový moment.
- Návyk lze odškrtnout přímo z „Cesty dne" bez „+".

### Jak se řeší období + kategorie (konec dvou pásů pilulek)
- **Z domovské mizí filtry úplně** — Dnešek je vždy „dnešek".
- Filtry žijí **jen na tabu Liga**, ve dvou úrovních důležitosti:
  - **OBDOBÍ** = jeden segmentový přepínač nahoře (Týden default / Měsíc / Celkem). Primární, vždy viditelný.
  - **KATEGORIE** = řeší se **swipem doleva/doprava** přes kartu žebříčku (Dohromady → Cviky → Aktivity → Strečink) s tečkovým indikátorem. Default „Dohromady" pokryje 80 % případů. Žádný druhý pás pilulek — kategorie je gesto, ne řádek.

### Jak gamifikace
Tři vrstvy, klidně ale živě: **série s plamínkem** (denní páka), **prsten dne** (zavři dnešek), **odměnový moment** po každém záznamu (body vyletí, prsten se dotočí, mikro-konfety jen u milníků — osobní rekord, posun v pořadí, kulatý streak 7/30). **Týdenní liga** s korunou vítěze. Heatmapa na „Já" = dlouhodobý vizuální dopamin.

---

## 3) Proč je tahle nejlepší a co obětuje

**Proč nejlepší:**
- **Tři taby + „+"** = jasný mentální model (méně než C i původní 4 taby), ale unese víc než dvě obrazovky D, takže se „Já" nepřeplní jako u D.
- **Skloubí obě duše:** soutěž (Liga) a osobní rozvoj (Já) jsou fyzicky oddělené, ale na domovské koexistují jemně — nepřebíjejí se. Přesně to Marek chce.
- **Apple klid × Duolingo radost** je tu nejvyváženější: domovská dýchá (A), ale má skutečný denní rituál a sérii, co tě tahá zpět (B).
- **Filtry vyřešené nejelegantněji ze všech:** segment + swipe + barevný oblouček — žádný šum.
- **Opravuje největší slabinu A** (rigidní tři kroužky → jeden prsten s barevným obloukem) i největší slabinu B (našlapaný domov → přísně odlehčený, jeden prsten místo prstenu+3 dlaždic ve stejné váze).

**Co obětuje:**
- **Soutěž není rovnou na úvod** (jako v C). Pro hyper-kompetitivní partu mírné upozadění — mitigace = výrazný žebříčkový proužek „já ±1" a živý proud na domovské.
- **Kategorie za swipem** jsou méně objevné než viditelné pilulky — nutný jemný onboarding tip + tečkový indikátor.
- **Týdenní reset Ligy** může vadit těm, kdo chtějí jen „celkem" — řeší segment „Celkem".
- **Tab „Já"** musí být disciplinovaně udržovaný, ať není skládka — to je trvalý designérský závazek.

---

## 4) Tři odvážnější „třešničky" (z dobré na vymazlenou)

1. **Živý prsten reaguje na reálný pohyb v ten okamžik.** Při ukládání záznamu se prsten nedotočí jen tak — **rozsvítí se přesně tím barevným segmentem** (síla/kardio/strečink), který jsi právě přidal, s jemnou vlnou světla po obvodu a haptickým „cvaknutím" při uzavření celého prstenu. Apple-úroveň detailu, který dělá z čísla zážitek.

2. **Týdenní „uzávěrka" jako malý filmový moment, ne pop-up.** V neděli večer se Liga na pár vteřin promění v klidnou celoobrazovkovou kartu: podium se zvedne, koruna dosedne vítězi, tvůj řádek se zvýrazní s tvým týdenním shrnutím („2. místo, +340 b, nejlepší den: středa"). Pak se týden tiše vynuluje. Rituál uzávěrky = důvod otevřít appku i v neděli večer.

3. **„Souboj týdne" — automatický 1:1 rival.** Každé pondělí ti appka tiše přiřadí jednoho přítele s podobným skóre jako tvého „rivala týdne" (mini-páska na domovské: „Souboj: ty 230 — Petr 245"). Drobná, osobní, ne-demotivující soutěž **i pro toho, kdo je celkově poslední** — protože každý má někoho na svojí úrovni. Řeší to největší slabinu všech kompetitivních konceptů (věční poslední se vzdají) a přidává sociální jiskru, kterou samotný absolutní žebříček nikdy nedá.

---

**Shrnutí jednou větou:** Vezmi klidnou tříobrazovkovou kostru „Dnešku" (A), dej do ní plamínek série, Cestu dne a týdenní ligu z „Denního rituálu" (B), nahraď tři rigidní kroužky jedním prstenem s barevným obloukem a kategorie řeš swipem — dostaneš appku, která je zároveň prémiově klidná i živě hravá, a která má důvod ji otevřít každý den.


# Příloha: všechny koncepce (JSON)

```json
[
  {
    "name": "Dnešek (The Today View)",
    "philosophy": "Domovská obrazovka je jediný \"dnešek\" — klidná stránka, která ti řekne, jak na tom dnes jsi, kde stojíš mezi přáteli a co ti zbývá. Vše ostatní je o krok dál. Klid, prostor, data napřed; soutěž je jemná vrstva, ne křik.",
    "homeScreen": "HNED po otevření vidíš svislý, scrollovatelný \"Dnešek\" — žádné taby filtrů, žádný chrome navíc:\n\n1) HERO KROUŽKY (nahoře, jako Apple Activity): tři soustředné prstence = Cviky (síla), Aktivity (kardio/sport), Strečink. Plní se k dennímu cíli podle bodů. Pod nimi jedno velké číslo: dnešní body + jemný delta vs. včera. Tohle je tvůj \"dnešek na první pohled\".\n\n2) ŽEBŘÍČKOVÝ PROUŽEK (jeden řádek, klidný): tvoje aktuální pozice + 1 nad tebou a 1 pod tebou (\"3. — 40 b za Petrem, 12 b před Jančou\"). Tap = rozbalí plný žebříček. Soutěž je přítomná, ale ne hlučná.\n\n3) STREAK & NÁVYKY (kompaktní karta): dnešní habit checklist (pít vodu, spát do 23:00…) jako řada malých zaškrtávacích teček + číslo streaku. Splníš → tečka se klidně rozsvítí.\n\n4) ŽIVÝ PROUD (dole, decentní): poslední 3-4 záznamy přátel (\"Petr +35 b — běh 5 km · před 20 min\") jako jemné řádky, ne notifikační šum. Sociální tah bez rušení.\n\nCelé to dýchá: velká typografie, hodně bílého prostoru, jedna akcentní barva na kroužcích. Pull-to-refresh, jinak nic.",
    "tabBar": [
      {
        "label": "Dnešek",
        "icon": "tři soustředné kroužky (Activity-style), výplň = denní progres",
        "obsah": "Domovská. Hero kroužky + dnešní body, kompaktní žebříčkový proužek (já ±1), streak + dnešní návyky, živý proud přátel. Vše na jedné scrollovatelné stránce."
      },
      {
        "label": "Žebříček",
        "icon": "stupně vítězů / sloupcový graf, klidná tenká linka",
        "obsah": "Plná soutěž. Seřazení přátel s avatary a body. Nahoře jeden segmentový přepínač Období (Týden / Měsíc / Celkem). Kategorie (Dohromady/Cviky/Aktivity/Strečink) jako tiché horizontálně posuvné čipy POD ním — defaultně Dohromady. Tap na hráče → jeho profil/karta (heatmapa, osobní rekordy, poslední pohyb)."
      },
      {
        "label": "Já",
        "icon": "silueta osoby v kroužku / osobní medailon",
        "obsah": "Tvůj svět: heatmapa aktivity (kalendář teček), návyky a jejich detail/editace, osobní rekordy a odznaky, kompletní historie tvých záznamů (filtrovatelná). Spojuje osobní rozvoj a archiv na jedno místo — odděleno od soutěže."
      }
    ],
    "filtryReseni": "Zruším oba pásy pilulek z domovské úplně. Domovská má kroužky pevně dané kategorie (Cviky/Aktivity/Strečink) a vždy \"dnešek\" — žádné filtry.\n\nFiltry žijí JEN na tabu Žebříček a jsou rozdělené do dvou úrovní podle důležitosti:\n- OBDOBÍ = jeden segmentový přepínač nahoře (Týden / Měsíc / Celkem) — primární, vždy viditelný, jeden tap.\n- KATEGORIE = tiché horizontálně posuvné čipy hned pod hlavičkou, default \"Dohromady\". Sekundární, nenásilné.\n\nTím zmizí pocit \"dvou pásů pilulek nad sebou\": jeden je hlavní ovladač (segment), druhý je decentní upřesnění (čipy), a oboje je schované jen tam, kde to dává smysl — na žebříčku, ne na domovské.",
    "addZaznam": "Stálé centrální tlačítko \"+\" uprostřed spodní lišty (vyvýšené, akcentní — jako Apple \"+\"), dostupné ze všech tří tabů. Tap → vyjede zdola klidný sheet (bottom sheet, ne celá nová obrazovka):\n\nKrok 1: tři velké dlaždice — Cvik / Aktivita / Strečink (stejné barvy jako kroužky → vizuální spojitost s domovskou).\nKrok 2: výběr konkrétního pohybu (oblíbené nahoře) + množství (počet/čas/vzdálenost). Body se počítají živě a ukážou se velkým číslem (\"+35 b\") ještě před uložením — okamžitá odměna.\nUložit → sheet se zavře, vrátíš se na Dnešek a vidíš, jak se kroužek dotočí animací a body naskočí. Habit checkbox lze odškrtnout přímo z karty návyků na domovské, bez \"+\".",
    "gamifikace": "Zdrženlivá, \"prémiová\" gamifikace — odměna je v pohybu a jasnosti, ne v cinkajících odznacích:\n- KROUŽKY: hlavní denní rituál — zavřít všechny tři prstence. Plynulá animace dotočení při uložení záznamu.\n- STREAK: tichý počet dní v řadě (návyky/pohyb), jemné \"perfektní týden\" zvýraznění kroužkové mřížky, žádné agresivní \"neztrať streak!\" notifikace.\n- HEATMAPA na tabu Já: rostoucí pole teček = dlouhodobý vizuální dopamin (GitHub-style, ale jemné odstíny akcentní barvy).\n- ODZNAKY/REKORDY: sbírané tiše na profilu (osobní rekord v kliky, \"30 dní streak\"), oslaví se jednorázovou decentní animací při dosažení.\n- SOCIÁLNÍ TAH: živý proud na domovské + \"ranní souhrn\" (kdo včera vedl). Volitelná lehká reakce (palec/oheň) na záznam přítele — Duolingo-style živost bez chaosu.\n- TÝDENNÍ RESET: v neděli večer klidná \"uzávěrka týdne\" karta (kdo vyhrál týden), pak se týdenní žebříček nuluje → nový cíl, nová motivace.",
    "whyBetter": "Současné řešení mělo 4 taby (Přehled/Historie/Hráči/Návyky) + 2 pásy filtrů na žebříčku. Problémy: žebříček byl jeden ze čtyř \"rovnocenných\" tabů, návyky byly odtržené v rohu, historie a hráči zabíraly samostatné taby, a dvojitý pás filtrů zahlcoval i ty, kdo jen chtěli vidět dnešek.\n\nTato IA:\n- DÁVÁ DŮVOD OTEVŘÍT APP DENNĚ: domovská \"Dnešek\" je rituál (zavři kroužky), ne jen rozcestník — Duolingo síla domovské, Apple klid provedení.\n- REDUKUJE NA 3 TABY + centrální \"+\": Dnešek (já dnes + jemná soutěž), Žebříček (čistá soutěž s chytrými filtry), Já (osobní rozvoj + archiv). Méně tabů = jasnější mentální model.\n- SLUČUJE rozházené kusy: Historie + Hráči (resp. můj profil) + Návyky + Heatmapa → smysluplně do \"Já\" a \"Žebříček\" místo čtyř plochých seznamů.\n- ŘEŠÍ FILTRY ELEGANTNĚ: z domovské mizí úplně; na žebříčku hierarchie (segment Období + tiché čipy Kategorie) místo dvou stejně hlučných pásů.\n- SKLOUBUJE SOUTĚŽ A OSOBNÍ ROZVOJ: na domovské koexistují (kroužky = já, proužek = oni), ale do hloubky jsou oddělené (Žebříček vs. Já) → nepřebíjejí se.",
    "tradeoffs": "- Žebříček už není top-level \"první věc\" — je o jeden tap dál (proužek na domovské + vlastní tab). Pro hyper-kompetitivní partu to může působit jako mírné upozadění soutěže; mitigace = výrazný proužek \"já ±1\" a živý proud na domovské.\n- Tab \"Já\" sdružuje hodně (historie, návyky, rekordy, heatmapa) — hrozí přehlcení; vyžaduje pečlivou vnitřní hierarchii (návyky nahoře, archiv dole), jinak se z něj stane \"skládka\".\n- Kategorie jako posuvné čipy jsou méně viditelné než plný pás — uživatel je musí objevit; akceptovatelné, protože default \"Dohromady\" pokryje 80 % případů.\n- Tři kroužky pevně mapované na Cviky/Aktivity/Strečink vyžadují rozumné denní cíle pro každou kategorii; někdo dělá jen sílu a strečink kroužek nikdy nezavře → buď volitelné cíle, nebo \"obecný pohybový\" kroužek místo tří. Riziko, že rigidní 3 kroužky nesednou každému z party.\n- Prémiová zdrženlivost může pro některé být \"málo hravá\"; rovnováha s Duolingo živostí (proud, reakce, týdenní uzávěrka) je tu klíčová a je třeba ji odladit v praxi."
  },
  {
    "name": "DENNÍ RITUÁL — Domov jako tvůj denní krok",
    "philosophy": "Appka klade každý den jen jednu otázku: „Pohnul ses dnes?“ Domovská obrazovka je živý rituál — jeden prsten dne, série na očích, jedno hlavní tlačítko. Soutěž s partou není sekce, je to palivo.",
    "homeScreen": "HNED po otevření vidíš JEDEN velký „Prsten dne“ uprostřed (jako Apple aktivita, ale živý): dnešní body + animovaný stav „dnes ses už hnul / ještě ne“. Nad ním velký pruh SÉRIE s plamínkem a číslem (např. „17 dní v řadě“), který hoří jasně dokud dnešek nezapíšeš a po splnění se zklidní do zlaté. Pod prstenem řádek „Cesta dne“ — 3 dlaždice denního rituálu (Pohyb / Strečink / 1 návyk), které se po splnění rozsvítí a „cvaknou“ s micro-odměnou (haptika + konfety). Dole malá karta „Liga tento týden“ — tvoje pozice + 1 hráč nad a 1 pod tebou (mini napětí), bez plného žebříčku. Velké pevné tlačítko „+ Zapsat“ je ukotvené nad tab barem. Žádné dva pásy filtrů, žádná tabulka na úvod — jen rituál, série a jedna výzva. Ráno appka otevřená = „máš před sebou 3 kroky“, večer = „prsten zavřený, série pokračuje“.",
    "tabBar": [
      {
        "label": "Domov",
        "icon": "Živý prsten / plamínek (kruh dne)",
        "obsah": "Denní rituál: Prsten dne, série s plamínkem, Cesta dne (3 dlaždice Pohyb/Strečink/Návyk), mini-náhled ligy (ty +-1), kotevní tlačítko +Zapsat. Startovní obrazovka, místo denního návratu."
      },
      {
        "label": "Liga",
        "icon": "Pohár / odznak",
        "obsah": "Sociální tah: žebříček party jako týdenní LIGA (reset v neděli, vítěz dostane korunu/odznak na příští týden). Nahoře přepínač období jako velký SEGMENT (Týden default / Měsíc / Celkem). Pod žebříčkem feed party „co dnes dělali ostatní“ s reakcemi (👏) — sociální motor, který tě stáhne zpět do appky."
      },
      {
        "label": "Já",
        "icon": "Avatar / postava (osobní)",
        "obsah": "Osobní rozvoj: profil + maskot-avatar, který roste se sérií, habit tracker (denní/týdenní cíle, streaky návyků), roční heatmapa-kalendář pohybu, osobní statistiky a sbírka odznaků/trofejí. Tichá, prémiová Apple-Health část — kontrast k hlučné Lize."
      }
    ],
    "filtryReseni": "Dva pásy pilulek mizí úplně. OBDOBÍ (Týden/Měsíc/Celkem) řeším jedním velkým iOS-style SEGMENTED přepínačem nahoře v tabu Liga — defaultně „Týden“, protože liga je týdenní rituál. KATEGORIE (Cviky/Aktivity/Strečink) NEní druhý pás: žebříček zůstává defaultně „Dohromady“ a kategorie je dostupná jako vodorovně rolovatelný řádek karet/chipů těsně nad žebříčkem (Dohromady • Cviky • Aktivity • Strečink), kde každá karta ukazuje i mini-číslo. Místo dvou statických pásů tak má uživatel jeden hlavní přepínač času + jeden volitelný horizontální „pruh kategorií“, který se chová jako záložky, ne jako filtr-šum.",
    "addZaznam": "Přidání žije na Domově jako velké ukotvené tlačítko „+ Zapsat“ (ne plovoucí FAB schovaný v rohu — je to hlavní akce dne, tak je vizuálně dominantní). Po ťuknutí vyjede zdola půl-obrazovkový sheet se 3 velkými volbami: POHYB (cviky/aktivity), STREČINK, NÁVYK. Vybereš typ → rychlý zápis (počet/čas/zaškrtnutí) → potvrzení spustí okamžitou odměnu: prsten dne se dotočí, přičtou se body s animací „+X“, případně se rozsvítí dlaždice na Cestě dne a cvakne micro-konfeta. Zápis = dopamin, ne formulář.",
    "gamifikace": "Jádro je SÉRIE (streak) s plamínkem na Domově — den bez zápisu = plamínek dohořívá, je tu „záchrana série“ (1x týdně streak-freeze, jako Duo). Denní „Cesta dne“ = 3 micro-cíle, splnění každého dává šťavnatou odměnu (haptika, zvuk, konfety). Týdenní LIGA jako Duolingo ligy: každý týden reset, vítěz party dostává korunu/sezónní odznak a místo v „Síni slávy“. Maskot/avatar v tabu Já roste a mění výrazy podle série a aktivity (smutný když vynecháš, hrdý při rekordu). Sbírka ODZNAKŮ za milníky (100 kliků, 7denní série, první místo). Reakce v feedu (👏🔥) = sociální mikro-odměny mezi partou.",
    "whyBetter": "Současné řešení nutí uživatele rozmýšlet (4 taby + 2 pásy filtrů = rozhodovací zátěž hned na startu). Tady má appka jeden jasný úkol: otevřu → vidím prsten + sérii → zapíšu → dostanu odměnu. Tři taby místo čtyř (Přehled+Historie splynou do Domova/Já) snižují šum. Dvojitý filtr nahradí jeden segment + horizontální záložky, takže žebříček je čistý a klidný (Apple) a přitom liga je živá a soutěživá (Duolingo). Série + denní rituál vytvoří návyk návratu, který obyčejné taby nikdy nevybudovaly. Sociální feed dává „tah party“, který je v současné struktuře schovaný v tabu Hráči.",
    "tradeoffs": "Riziko: Domov je hodně našlapaný (prsten + série + 3 dlaždice + mini-liga) — musí být vizuálně přísně odlehčený, jinak ztratí Apple klid. Historie všech záznamů a plný žebříček se „schovají“ (Historie pod Já, plná liga v tabu Liga) — pokročilý uživatel chtějící hloubkové filtrování má o krok víc. Týdenní reset ligy může frustrovat ty, kdo chtějí jen „celkové“ pořadí (proto Celkem zůstává v segmentu). Gamifikace (maskot, konfety, plamínek) musí být zdrženlivá a vkusná, aby pro partu dospělých nepůsobila dětsky — jemná haptika a tlumené konfety místo křiklavých animací. Tři taby znamenají, že každý tab nese víc obsahu a musí být dobře vrstvený."
  },
  {
    "name": "ARÉNA — žebříček je domovská obrazovka",
    "philosophy": "Srdce appky je živá soutěž party: otevřu appku a okamžitě vidím, kde stojím vůči kámošům a co kdo právě dělá. Nechci zaostat — to je hlavní tah. Návyky jsou osobní palivo, které mě posouvá v žebříčku, ne samostatný svět.",
    "homeScreen": "Domovská = ŽEBŘÍČEK TÝDNE jako hero. Hned nahoře \"kde jsem já\" zvýrazněný řádek (např. \"3. místo, +40 bodů na druhého\"), pod tím podium top 3 a zbytek party. Nahoře jeden segmentovaný přepínač období (Týden je default). Pod žebříčkem plynule navazuje ŽIVÝ FEED: chronologicky \"Petr právě zaběhl 5 km (+50)\", \"Anna si odškrtla 30 dřepů\", reakce emoji (oheň, palec, smích) přímo v řádku. Cílem je, že po otevření za 3 vteřiny vím: jak jsem na tom + co se právě děje v partě. Žádné prázdné dashboardy — vždy je co číst a na co reagovat.",
    "tabBar": [
      {
        "label": "Aréna",
        "icon": "trofej / stupně vítězů",
        "obsah": "DOMOVSKÁ. Žebříček týdne (hero) + živý feed aktivity party s reakcemi. Přepínač období nahoře. Tady žiju 80 % času."
      },
      {
        "label": "Já",
        "icon": "silueta / kroužek pokroku",
        "obsah": "Můj profil + osobní návyky (habit tracker se streaky, denní/týdenní cíle) + moje statistiky a moje historie záznamů. Vše osobní pohromadě, rámované jako 'tvoje palivo do žebříčku'."
      },
      {
        "label": "+",
        "icon": "velké centrální plus",
        "obsah": "PŘIDAT ZÁZNAM. Centrální zvýrazněné tlačítko v tab baru (ne plovoucí). Otevře rychlý zapisovač: vyber typ (Cvik/Aktivita/Strečink) → zaznamenej → potvrzení s animací bodů a 'sdíleno do feedu'."
      },
      {
        "label": "Parta",
        "icon": "dvě/tři siluety",
        "obsah": "Hráči — karty/profily kámošů, jejich streaky, odznaky, osobní rekordy, porovnání 1:1 se mnou ('máš o 2 tréninky víc než já'). Síň slávy: vítězové minulých týdnů."
      }
    ],
    "filtryReseni": "Dva pásy pilulek nahradím jedním přepínačem + chytrým výchozím stavem. (1) OBDOBÍ: jediný segmentovaný přepínač nahoře v Aréně — Týden (default, kvůli rituálu a 'vítězi týdne') / Měsíc / Celkem. (2) KATEGORIE neřeším druhým pásem, ale jako swipovatelné karty žebříčku: výchozí je 'Dohromady', swipe doleva/doprava přepne na Cviky → Aktivity → Strečink (tečky/indikátor nahoře). Kategorie je tak gesto, ne další řádek pilulek — čisté, prémiové, jeden vizuální prvek místo dvou pásů.",
    "addZaznam": "Centrální '+' přímo v tab baru (vizuálně zvýrazněné, větší, barevné) — ne plovoucí FAB, aby působilo prémiově a bylo to jasné srdce akce. Klepnutí otevře bottom sheet: 3 velké dlaždice (Cvik / Aktivita / Strečink) → výběr konkrétní věci a počtu/času → potvrdit. Po uložení: krátká oslavná animace přičtených bodů + okamžité objevení záznamu ve feedu Arény ('sdíleno partě'). Zápis a sociální odměna se tak slijí do jednoho momentu.",
    "gamifikace": "Týdenní rituál (Duolingo styl): týden je hlavní cyklus — v neděli večer 'uzávěrka' a vyhlášení VÍTĚZE TÝDNE s konfetami a koruna na profilu vítěze do dalšího týdne. STREAK: dny po sobě se záznamem, viditelný v Aréně i na 'Já', varování 'streak v ohrožení' push v podvečer. ŽIVÝ FEED + reakce = sociální dopamin (oheň/palec na cizí výkony). Odznaky a osobní rekordy na profilech v Partě. Pohyb: počítadla bodů, které 'naskakují' s animací; podium se zvedá; streak plamínek. Lehké, ne křiklavé — animace slouží oslavě výkonu, ne dekorace.",
    "whyBetter": "Současné 4 taby roztříští pozornost a žebříček (skutečný motor) je schovaný v 'Přehledu' mezi heatmapou a posledními záznamy. Tady je žebříček SAMA domovská obrazovka — okamžitý sociální tah. Dva pásy filtrů (období + kategorie) sjednoceny do jednoho přepínače + swipe gesta = čistší a prémiovější. Feed je integrovaný pod žebříček, ne v samostatné 'Historii', takže soutěž a sociální dění žijí na jednom místě. Návyky nemizí, ale jsou správně zarámované jako osobní palivo pod 'Já', podřízené sociálnímu motoru — přesně dle filozofie. Pořád 4 taby, ale s jasnou hierarchií: Aréna > akce > já/parta.",
    "tradeoffs": "Riziko: kdo je soutěživě slabší (méně času, horší kondice) může být demotivovaný věčně posledním místem — proto nutné změkčit (osobní rekordy, 'nejvíc zlepšený', streak jako vlastní soutěž, ne jen absolutní body). Návyky jsou schované pod 'Já' — pro uživatele, kteří appku berou hlavně jako osobní tracker, je to méně prominentní (vědomá oběť ve prospěch social-first). Týdenní reset může frustrovat ty, co chtějí dlouhodobou kumulaci (řeší přepínač Celkem + Síň slávy). Swipe na kategorie je elegantní, ale méně objevitelný než viditelné pilulky — nutný jemný indikátor/onboarding tip. Feed u 7 lidí může být v klidných dnech řídký — řešit i 'milníky' a streak-události, aby feed nikdy nebyl prázdný."
  },
  {
    "name": "DVA TABY — \"Výzva\" a \"Já\" (jeden palec, jedna myšlenka na obrazovku)",
    "philosophy": "Appka má jen dvě duše — soutěž s partou a tvůj vlastní rozvoj — tak ať má jen dvě obrazovky. Žebříček je domov; všechno ostatní (období, kategorie, historie, profily) se rozbaluje z něj kontextově, ne jako stálé pásy filtrů.",
    "homeScreen": "Po otevření spadneš rovnou na ŽEBŘÍČEK party (tab \"Výzva\") — to je jádro celé appky a první věc, kterou chce každý vidět: \"kde jsem dnes proti ostatním\". Nahoře velký iOS titul \"Výzva\", pod ním jeden klidný řádek-segment se třemi stavy (Týden · Měsíc · Celkem) — defaultně TÝDEN, protože ten žene denní rituál. Pak inset-grouped karta se 7 hráči: pořadí, avatar, jméno, pod jménem živý mikro-řádek (🔥 streak, nebo \"+3 dnes\" když dnes přibyl záznam). #1 zlatě. Úplně nahoře nad kartou tenký \"živý pás\" — vodorovná stužka posledních 2-3 záznamů party (\"Martin · běh 5 km · teď\"), která dává sociální tah hned a nahrazuje samostatný tab Přehled. Tvůj vlastní řádek je jemně zvýrazněný (sticky když odscrolluješ), takže vždy vidíš sebe. Žádný druhý pás filtrů — kategorie se řeší jinak (viz filtryReseni).",
    "tabBar": [
      {
        "label": "Výzva",
        "icon": "Dva propletené prsteny / vlaječka cíle (sociální, soutěžní symbol) — vyplněný v zelené při aktivním stavu",
        "obsah": "Žebříček party (domov, default Týden). Klepnutí na hráče = jeho profilová karta odspodu (bottom sheet): jeho body v kategoriích, kalendář-heatmapa, streak, posledních pár záznamů. Tím zmizí samostatný tab Hráči. Pull-to-refresh oživí žebříček. Nahoře živý pás aktivity party = bývalý Přehled."
      },
      {
        "label": "Já",
        "icon": "Silueta postavy v prstenu / osobní 'aktivní' kroužek (Apple Fitness ring) — plní se podle dnešního pokroku",
        "obsah": "Tvůj osobní svět: nahoře dnešní rituál — uzavírací kroužek/ring dne (kolik z dnešních návyků + pohybu hotovo) a streak velký a hrdě. Pod tím NÁVYKY jako odškrtávací řádky (pít vodu, spát do 23:00) s týdenním cílem. Níž 'Moje čísla' — tvoje body, pořadí, osobní rekordy, a tvoje heatmapa. Úplně dole tichý vstup do celé tvé HISTORIE záznamů (filtrovatelné kontextově). Tím se sloučí Návyky + tvoje data + Historie do jednoho osobního prostoru."
      }
    ],
    "filtryReseni": "Zruším oba stálé pásy. (1) OBDOBÍ zůstává jako jediný klidný iOS segment nahoře na žebříčku (Týden/Měsíc/Celkem) — to je jediný stálý přepínač v celé appce, protože mění to hlavní číslo. (2) KATEGORIE (Dohromady/Cviky/Aktivity/Strečink) NENÍ stálý pás — vyřeším ji kontextově třemi triky: a) Žebříček defaultně ukazuje DOHROMADY a celkové body má každý jako velké číslo; pod číslem je nepatrný trojbarevný mikro-proužek (síla/kardio/strečink) à la Apple aktivita — vidíš složení bez přepínání. b) Kategorie se mění SWIPEM doleva/doprava přes kartu žebříčku (jako přepínání prstenů), s tečkovým indikátorem dole — pohyb a hravost zdarma, nula UI navíc. c) Případně klepnutí na samotný titul \"Výzva\" otevře malé kontextové menu kategorií. Takže místo dvou trvalých pásů: jeden segment + skrytý swipe + barevný mikro-proužek. Klid i hravost.",
    "addZaznam": "Centrální plovoucí \"+\" zůstává, ale povýší na hlavní rituální gesto — velké kulaté tlačítko v zelené, plovoucí nad oběma taby uprostřed dolního okraje (vždy po ruce palcem, nezávisle na tom, jestli jsem ve Výzvě nebo v Já). Klepnutí = bottom sheet 'Co jsi dělal?' se třemi velkými dlaždicemi (Síla / Pohyb / Strečink) → druhý krok výběr konkrétní věci + množství. Po uložení krátká odměnová animace (body vyletí, ring se dotočí, případně přeskočí streak) — to je ten Duolingo moment. Žádná samostatná 'přidat' obrazovka v navigaci; je to akce, ne místo.",
    "gamifikace": "Tři vrstvy, klidně ale živě: (1) STREAK — velký na \"Já\", a malý 🔥 u jména v žebříčku, takže streak je i sociální páka. (2) DENNÍ RING na \"Já\" (Apple Fitness duch) — uzavři dnešek (pohyb + návyky), s jemnou animací dotočení a haptikou při uzavření. (3) ODMĚNOVÝ MOMENT po každém záznamu — body vyletí nahoru do žebříčku, mikro-konfety jen u milníků (osobní rekord, posun v pořadí, kulatý streak 7/30). Pohyb je rezervovaný: swipe mezi kategoriemi, pull-to-refresh, dotočení ringu, vyletění bodů — nic nebliká samo od sebe, vše reaguje na dotek. Týdenní 'reset' v neděli večer = malé shrnutí ('Tento týden jsi 2. místo, +340 bodů') jako klidný ритуál, ne pop-up spam.",
    "whyBetter": "Ze 4 tabů + 2 pásů (≈6 trvalých navigačních prvků na jedné obrazovce) na 2 taby + 1 segment. Mapuje se přesně na dvě jediné motivace uživatele: 'jak na tom jsem vůči partě' (Výzva) a 'jak na tom jsem se sebou' (Já) — soutěž vs. osobní rozvoj jsou fyzicky oddělené, takže každá obrazovka má jeden jasný účel. Přehled a Hráči nebyly samostatné cíle, ale pohledy na žebříček → vtaženy dovnitř (živý pás + profil v bottom sheetu). Historie a osobní data nejsou veřejná soutěž → patří k 'Já'. Druhý pás filtrů (nejotravnější prvek) nahrazen swipem + barevným proužkem, což je zároveň prémiově klidné (žádný vizuální šum) i hravé (pohyb prstem). Méně rozhodování, víc jasnosti, palec dosáhne na vše.",
    "tradeoffs": "1) Kategorie skryté za swipem jsou méně objevné — nutný jemný onboarding/tečkový indikátor + barevný proužek jako nápověda, jinak je část uživatelů nenajde. 2) Dvě obrazovky neunesou vše donekonečna — 'Já' se může přeplnit (návyky + čísla + historie); řeší se vnořenými sheety, ale hrozí scroll-únava. 3) Žádný stálý přepínač kategorií = uživatel, který chce 'jen žebříček ve shybech', to má o gesto dál. 4) Žebříček jako tvrdý default může demotivovat ty na konci pořadí — proto streaky/osobní ring na 'Já' jako protiváha (každý někde vyhrává). 5) Sloučení Historie do 'Já' znamená, že prohlížení cizí historie žije jinde (v profilovém sheetu hráče) — dvě cesty k 'záznamům', které musí být konzistentní."
  }
]
```

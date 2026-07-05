# Dnešek — promyšlený obsah a logika (návrh)

Tady je doporučená, jedna promyšlená verze obrazovky Dnešek (i s úpravami pro ostatní taby).

---

# DNEŠEK — finální doporučení

## Hlavní princip (proč to celé funguje)

Dnešek se čte **shora dolů jako jedna věta**:
„Co mi dnes hrozí ztratit → kde dnes stojím → co mi zbývá udělat (a hned to udělám) → kde jsem v partě → co se právě stalo."

Pravidlo, které ti vyřeší zároveň **prázdnotu i přeplácanost**:
**Každý blok na Dnešku musí buď nabídnout AKCI (zapsat, odškrtnout, zareagovat), nebo nést NAPĚTÍ (série hoří, soused je 12 b přede mnou). Když blok jen ukazuje číslo „na koukání" → na Dnešek nepatří, jde do Party nebo do Já.**

To je celé jádro. Tvůj současný Dnešek působí prázdně ne proto, že je tam málo věcí, ale proto, že tam jsou jen **pasivní čísla bez akce**. A nelogicky proto, že prsten ukazoval „body z cíle", ale appka žádný reálný denní cíl nemá → číslo bez měřítka.

Celkem **5 bloků**, hodně bílého prostoru, jeden emeraldový akcent, tabulková čísla, žádné gradienty.

---

## Rozložení shora dolů

### 0) Hlavička (tenký řádek, „sticky")
**Co:** Vlevo `Dobré ráno, Marku` + datum (`Pátek 27. 6.`). Vpravo plovoucí emeraldové **„+"** (zápis: Cvik / Aktivita / Strečink / Lezení) a avatar (→ Já). Mezi tím kompaktní čip série s plamínkem: **🔥 17**. Plamínek **hoří jasně, dokud dnes nezapíšeš první pohyb**, po zápisu se zklidní do zlaté.

**Proč:** Série je nejsilnější emoční páka denního návratu a jediné číslo, které má **přirozené měřítko bez vymýšlení** („neztratit, co mám"). „Hořící" plamínek = jeden z hlavních důvodů appku dnes vůbec otevřít. Tenký řádek, ať neukradne prostor hrdinovi. „+" je jediné fixní místo zápisu v celé appce.

---

### 1) HRDINA: Dnešní prsten + akční pod-řádek
**Co:** Jeden velký prsten, uvnitř velké číslo = **dnešní body**. Po obvodu tenký **trojbarevný/čtyřbarevný oblouk** = složení dne (síla / kardio / strečink / lezení) — hned vidíš, ČÍM jsi body nasbíral. Pod číslem **měřítko z reálných dat**: `+35 vs. včera` nebo `do dnešního průměru (80 b) zbývá 20 b`. Pod prstenem **akční věta + 2 rychlé chipy**: `+ Cvik` / `+ Aktivita` (předvyplněný tvůj poslední/nejčastější typ).

**Proč:** Tohle je oprava obou Markových problémů najednou:
- **Nelogičnost** = prsten měl měřítko „cíl", který neexistuje. Řešení: měřítkem je **tvůj 7denní průměr / včerejšek** — data, která appka reálně má, je vždy férové (nikdy nedosažitelné ani triviální) a osobní.
- **Prázdnota** = prsten byl pasivní odznak. Teď je to **akční uzel**: chipy pod ním = zápis o krok rychleji než přes „+".
- **Jeden prsten místo tří kroužků**: kdo dělá jen sílu, vždy „zavře den" — barevný oblouk dá informaci o složení, aniž bys nutil tři samostatné cíle.

Empty-state (dnes 0 b): prsten prázdný, ale pod ním klidná výzva s měřítkem `Zatím nic. Tvůj průměr je 80 b.` — ne „nelogická nula".

---

### 2) AKČNÍ: Dnešní návyky — odškrtávací řádky
**Co:** 2–4 **dnešní** návyky (jen ty, co mají dnes padnout) jako klikací řádky: ikona + název + mikro-progress (`💧 Voda 1/2 l`, `😴 Spát do 23:00 ○`) + kroužek/checkbox. **Binární odškrtneš jedním tapem rovnou tady** (haptika), měřitelný otevře rychlý sheet. Nad seznamem mini-souhrn `Dnes: 2 ze 4`. Když je vše hotovo → sbalí se do klidného `Návyky dnes hotové ✓`.

**Proč:** Tohle je **největší jednotlivý lék na prázdnotu** a důvod, proč dnešní Dnešek působí nelogicky: **půlka denního rituálu (návyky) tam dnes vůbec není**, takže domovská nezrcadlí celý den. Je to nejakčnější blok — odškrtnutí je hotová věc za vteřinu a **důvod appku otevřít i ve dnech bez tréninku**. Patří hned pod hrdinu, protože „co mi dnes ještě zbývá" je druhá otázka po „jak na tom jsem". Denní odškrtávání se tím **stěhuje sem**; tab Návyky zůstává na správu a dlouhé trendy.

---

### 3) SOUTĚŽ: tvoje pozice v partě — já ±1 soused
**Co:** Tři řádky vycentrované **kolem tebe**: hráč nad tebou, **TY** (zvýrazněně), hráč pod tebou — vždy s **rozdílem v bodech**: `Martin +43 b` · **TY** · `Janča −12 b`. Nahoře tenký řádek lídra s 👑. Malý přepínač **Týden / Celkem**. Tap kdekoli → plný žebříček v Partě.

**Proč:** Soutěž je smysl appky, ale na Dnešku ji nepotřebuješ celou — potřebuješ vědět **koho dotahuju a kdo mě dohání**. Zobrazení **rozdílů** = akční napětí (`o 43 b přeskočím Martina` = jeden trénink), ne statický seznam. A hlavně: rámování „**já ±1 soused**" místo „jsi 7. ze 7" je rozdíl mezi **motivací a demotivací** — každý vidí dosažitelný cíl o kousek nad sebou, ne propast k vítězi. Proto je tahle sekce **pod** osobní částí: nejdřív „já", pak „oni".

> **Pozn. k „Souboji týdne":** Tři návrhy chtěly navíc samostatnou kartu 1:1 rival. **Nedávej ji** — duplikovala by „já ±1" (oboje říká „dotáhni souseda nade mnou"). Sloučeno do jednoho bloku: řádek nad tebou JE tvůj rival týdne. Méně bloků, stejné napětí.

---

### 4) DĚNÍ: živý proud party — poslední 2–3 + 1tap reakce
**Co:** 2–3 decentní řádky posledních záznamů přátel: `Petr · běh 5 km · +50 b · před 20 min` (avatar + barva hráče). Vpravo **1tap reakce** 💪🔥👏. Milníky zvýraznit jinou barvou (`🏅 Martin překonal rekord — 100 kliků`, `Tomáš tě právě předběhl`). Odkaz `Parta →` na plný proud. Když je ticho: místo prázdna ukázat milník/streak (`Anna má 30denní sérii`), **nikdy bílé „zatím nic"**.

**Proč:** Sociální tah = druhý důvod vracet se ZÍTRA (reagoval jsi → chceš vidět odezvu). **Reakce dělá z pasivního řádku akci** (proto to projde testem „akce nebo napětí"). Záměrně **poslední** a **jen 2–3 řádky** — je to „nice to know", ne tvoje akce; víc dění patří do Party. Fallback na milníky řeší reálné riziko u party 7 lidí: feed nesmí být nikdy mrtvý.

---

## Proč to drží logiku a je „bohaté, ale klidné"

- **Tok pozornosti = klesající „je to o mně" + klesající ovlivnitelnost:** série (neztratit) → můj stav → co mi zbývá (akce) → kde jsem v partě → co dělají ostatní. Nahoře vysoká interakce (zapíšu, odškrtnu), dole čtu a občas reaguju.
- **Ráno:** otevřu → „mám sérii, dnes 0 b, zbývají 4 návyky, jsem 3., Petr běhal" → jasný plán dne.
- **Večer:** zapíšu přes „+" → prsten se dotočí, body naskočí, návyk cvakne, posunu se na 2. → odměnový moment + uzavření dne.
- **Klidný den (necvičím):** stejně otevřu kvůli návykům a kontrole, jestli mě někdo nepřeskočil → retence drží i bez tréninku.
- **Bohaté, ale klidné:** 5 vrstev nese hodně informace (složení dne, trend vs. včera, série, rozdíly v žebříčku, dění), ale každá vrstva je jen 1 řádek/karta a **žádné dva bloky neopakují totéž číslo**.

## Co je akční (shrnutí)
1. „+" vpravo nahoře = zápis čehokoli.
2. Chipy pod prstenem = zápis posledního typu o krok rychleji.
3. Odškrtnutí návyku přímo v řádku (hlavní denní akce).
4. Reakce 💪🔥👏 na záznam přítele.
5. Tap na žebříček/dění → skok do Party.

---

## Čemu se vyhnout (tvrdá pravidla)
- **Žádné pasivní „jen-číslo" karty na Dnešku** (samostatná heatmapa, trend graf, celý žebříček 7 lidí, statistiky) → to vytváří prázdno; patří do Party/Já.
- **Žádný vymyšlený fixní cíl** (100 b/den) — měřítkem je vlastní průměr/včerejšek.
- **Žádné opakování stejného čísla** ve více kartách (celkové body / série patří primárně do Já; na Dnešku jen aktuální stav série u hlavičky).
- **Žádné generické motivační fráze** („Skvělá práce! 💪") — místo nich konkrétní akční věta z dat (`Zbývá 20 b do tvého průměru`, `o 43 b přeskočíš Martina`).
- **Žádné gradienty, neon, glassmorphism, maskoti, fake grafy.** Max 1 velký vizuál (prsten), zbytek textové řádky a malé dlaždice.
- **Prázdné stavy = výzva s měřítkem**, ne „0" nebo bílé místo. Feed = fallback na milníky.
- Tvrdý test na každý prvek: **„dá se s tím něco udělat, nebo nese napětí?"** Když ne → pryč z Dnešku.

---

# Krátce k ostatním tabům

**PARTA** (hub „vše o ostatních"): sem patří všechno pasivně-soutěžní, co jsme vyhodili z Dnešku — **plný žebříček** s filtry (Týden/Měsíc/Celkem + kategorie), **kalendář/heatmapa** party, **rekordy**, **statistiky**, **kompletní záznamy** ostatních, **karty/profily hráčů** (tap = bottom sheet), **týdenní uzávěrka** (vítěz týdne + reset, „Síň slávy") a **plný živý proud**. Důležité: do plného žebříčku přidej **stejný sloupec „rozdíl v bodech"** jako na Dnešku, ať je to konzistentní.

**NÁVYKY** (tab pro správu, ne pro denní rutinu): zakládání, editace, frekvence/cíle, **statistiky a dlouhé trendy** (roční mřížka, heatmapa návyků), posun po týdnech. **Klíčový přesun:** denní odškrtávání se stěhuje na Dnešek (sekce 2) — tady je člověk plánuje a kouká na trendy, ne odškrtává každý den.

**JÁ** (osobní identita + archiv, přísná hierarchie, ne skládka): profil, **osobní rekordy + odznaky** nahoře → **moje heatmapa** → **kompletní historie mých záznamů (s editací)** → nastavení (cíle, streak-freeze) → „jak se boduje". **Sem patří souhrn identity** — celkové body, „× vítěz týdne", série jako trofej. Na Dnešku se série ukazuje jen jako aktuální stav, **neopakovat celé skóre všude**.

**Jeden přesun navíc:** dnešní „kousek žebříčku" a „týdenní trend vedle prstenu" z původního Dnešku **ruším jako samostatné prvky** — trend je teď „+35 vs. včera" pod prstenem, žebříček je „já ±1 soused". Tím zmizí duplicita a Dnešek se zklidní.


# Příloha: všechny návrhy (JSON)

```json
[
  {
    "philosophy": "Dnešek = \"Co mám dnes udělat a jak na tom jsem\" — jeden živý DENÍK dne, ne vitrína statistik. Dnes musí umět dvě věci, které dnes neumí: (1) dát JASNÝ DŮVOD appku každý den otevřít (mám rozdělaný den, série visí na vlásku, soupeř mě těsně přeskočil) a (2) nabídnout AKCI přímo z domovské, ne jen čísla k prohlížení. Logika obrazovky čteš shora dolů jako větu: \"Tady jsem dnes → tohle mi do cíle zbývá udělat (a hned to zapíšu) → takhle si stojím proti partě → co se právě stalo.\" Apple Fitness princip: jeden hrdina (dnešní prsten), zbytek mu slouží a vede k akci. Klid + prostor, ale každá karta odpovídá na konkrétní otázku uživatele — nulová dekorace. Klíčový posun proti dnešku: prsten přestává být pasivní odznak a stává se akčním uzlem (pod ním \"zbývá X b\" + rychlé zapsání), návyky se na Dnešku objeví jako odškrtávací řádek (dnes na Dnešku vůbec nejsou → proto působí prázdně i nelogicky: chybí půlka denního rituálu), a \"Dění v partě\" se zúží na JEDEN soutěžně relevantní fakt (kdo mě ohrožuje / koho dotahuju), ne náhodné novinky.",
    "dnesekSections": [
      {
        "nazev": "Hlavička (datum + Dnešek + avatar + „+\")",
        "co": "Vlevo malé datum „Pátek 27. 6.\" a titulek „Dnešek\". Vpravo nahoře avatar (→ Já) a plovoucí emeraldové „+\" (→ add sheet Cvik/Aktivita/Strečink/Lezení). Toto je jediné fixní místo „+\" v celé appce.",
        "proc": "Kotva orientace (jaký je den, kde jsem) + primární akce appky vždy palcem dosažitelná vpravo nahoře. Drží se schváleného redesignu."
      },
      {
        "nazev": "HRDINA: Dnešní prsten + akční pod-řádek",
        "co": "Velký prsten = dnešní body z denního cíle (240 z 300 b), segmenty barevně dle typu (síla/kardio/strečink/lezení) — uživatel hned vidí ČÍM body nasbíral. POD prstem ne pasivní popisek, ale akční věta + 2 rychlá tlačítka: „Zbývá 60 b do cíle\" a chipy „+ Cvik“ / „+ Aktivita\" (poslední/nejčastější typ). Vedle prstenu kompaktně série 🔥 17 (s mikro-stavem „dnes ✓/–\") a dnešní počet záznamů.",
        "proc": "Odpověď na první otázku „jak na tom dnes jsem\" + okamžitě „co s tím udělat\". Tohle řeší Markovo „prázdno\": prstu dáme práci (akci), ne jen číslo. Barevné segmenty = informačně bohaté bez přidání karty. Jeden hrdina = Apple klid."
      },
      {
        "nazev": "Dnešní návyky (odškrtávací řádek)",
        "co": "2–4 dnešní návyky jako klikací řádky s kroužkem (💧 Pít vodu 🔥17 ✓ / 😴 Spát do 23:00 ○ / 📖 Číst ○) + mikro-progress „2 ze 3 hotovo\". Měřitelný návyk otevře rychlý zápis (sheet), binární se odškrtne přímo. Žádné statistiky tady — jen dnešek.",
        "proc": "NEJVĚTŠÍ příčina, proč Dnešek působí prázdně a nelogicky: půlka denního rituálu (návyky) tam vůbec není, takže „domovská\" nezrcadlí celý den. Tohle je nejakčnější blok — odškrtnutí je hotová věc během 1 s a důvod appku otevřít i ve dnech bez tréninku. Patří hned pod hrdinu, protože je to „co mi dnes ještě zbývá\" stejně jako body."
      },
      {
        "nazev": "Tvůj týden (3 kompaktní dlaždice)",
        "co": "Body za týden + trend (505 ▲12 %), počet tréninků (6), tvoje aktuální pořadí (3.). Tabular čísla, jemné dlaždice.",
        "proc": "Most od „dnes\" k „jak mi jde delší trend\" a k soutěži. Trend (▲/▼) dává dnešku PŘÍBĚH (zlepšuju se / polevuju) — to je důvod pokračovat. Pořadí „3.\" zde slouží jako přirozený přechod do žebříčku níž."
      },
      {
        "nazev": "Žebříček — kontextový výřez (ne celý)",
        "co": "3 řádky vycentrované KOLEM TEBE: hráč nad tebou, ty (zvýrazněně), hráč pod tebou — s ROZDÍLEM v bodech („Martin +43 b\", „Natálka −35 b\"). Nahoře řádek lídra s 👑. Odkaz „Parta →\" na plný žebříček.",
        "proc": "Soutěž je smysl appky, ale na Dnešku nepotřebuju celých 7 lidí — potřebuju vědět KOHO dotahuju a kdo mě dohání. Zobrazení rozdílů = akční napětí („o 43 b přeskočím Martina\") místo statického seznamu. Plný žebříček + filtry (období/kategorie) zůstává v Partě."
      },
      {
        "nazev": "Jedno dění v partě (soutěžně relevantní)",
        "co": "JEDEN řádek, vybraný chytře dle priority: někdo tě právě přeskočil / někdo překonal rekord / někdo má dnes velký výkon. Např. „🏅 Martin překonal rekord — 100 kliků · před 2 h\". Klik → jeho karta v Partě.",
        "proc": "Sociální tah + FOMO = druhý důvod otevřít denně. Ale dnešní 2–3 náhodné novinky působí jako výplň; redukce na JEDEN relevantní fakt drží klid a zvyšuje úder. Víc dění patří do Party. Tohle je záměrně poslední — uzavírá obrazovku, nepřetahuje pozornost z mého dne."
      }
    ],
    "logika": "Tok pozornosti = jedna souvislá věta odshora dolů: „TOHLE jsem dnes nasbíral (prsten) → TOHLE mi do cíle/dne zbývá a hned to udělám (akční chipy + návyky) → TAKHLE mi to jde v čase (týden) → TAKHLE stojím proti partě (žebříček kolem mě) → TOHLE se právě stalo (1 dění).“ Nahoře osobní a akční (vysoká frekvence interakce: zapíšu, odškrtnu), dole sociální a kontextové (čtu, občas prokliknu). Pro každodenní použití party 7 lidí to znamená: ráno/večer otevřu → vidím rozdělaný den (prsten neúplný, návyky neodškrtnuté) → během pár sekund něco zapíšu/odškrtnu → mrknu, jestli mě někdo přeskočil → zavřu. Žádné scrollování za informacemi, které nezměním. Informačně bohaté (prsten-segmenty, trend, rozdíly v žebříčku, série, dění), ale klidné, protože každý prvek má právě jednu úlohu a žádné dva neopakují totéž.",
    "akcni": "Z Dnešku jde rovnou: (1) zapsat trénink přes „+\\\" vpravo nahoře NEBO přes rychlé chipy pod prstenem („+ Cvik\\\"/„+ Aktivita\\\" s předvyplněným posledním typem — o krok rychleji než přes „+\\\"); (2) odškrtnout binární návyk jedním klikem přímo v řádku; (3) zapsat hodnotu měřitelného návyku (sklenice vody) přes rychlý sheet; (4) proklik „Parta →\\\" na plný žebříček nebo klik na soupeře v mém výřezu → jeho karta; (5) klik na dění → karta hráče. Princip: nejčastější denní akce (zápis pohybu + odškrtnutí návyku) jsou hotové bez opuštění domovské.",
    "ostatniTaby": "Parta: nechat jako hub „vše o ostatních\\\" (plný žebříček s filtry období/kategorie, kalendář-heatmap, statistiky, Rekordy, Záznamy, karty hráčů) — Dnešek z něj jen ukazuje výřez, neduplikuje. Doplnit do plného žebříčku tentýž „rozdíl v bodech\\\" sloupec, ať je konzistentní s Dneškem. Návyky: ponechat detailní tab (Dnes + Statistiky + tvorba), ale počítat s tím, že DENNÍ odškrtávání teď žije i na Dnešku — tab Návyky je pro správu, plánování a dlouhé trendy (roční mřížka), ne pro každodenní rutinu. Já: beze změny strukturálně (profil, moje záznamy+edit, rekordy/odznaky, nastavení, „jak se boduje\\\"). Drobnost: „série 🔥\\\" a „celkové body / × vítěz\\\" patří primárně na kartu Já (souhrn identity), na Dnešku jen aktuální stav série u prstenu — neopakovat všude celé skóre.",
    "cemuSeVyhnout": "Vyhnout se: (1) opakování těch samých čísel ve více kartách (dnes je série/celkové body i v hero kartě i jinde — každý údaj má být na obrazovce jednou, na svém logickém místě); (2) statickému plnému žebříčku 5–7 lidí na Dnešku — to je úkol Party, na domovské stačí výřez kolem mě s rozdíly; (3) náhodným „novinkám z party\\\" jako výplni — jen JEDEN soutěžně relevantní fakt; (4) generickým motivačním frázím bez dat („Skvělá práce! 💪\\\") — místo toho konkrétní akční věta z reálných čísel („Zbývá 60 b do cíle\\\", „o 43 b přeskočíš Martina\\\"); (5) gradientům, neon záři, dribbble-glassmorphism dekoraci a víc než jednomu hrdinovi na obrazovku; (6) prázdnému prstenu bez akce — prsten MUSÍ nabídnout, co s ním (chipy/zbývá). Naopak NEpřeplácat: max ~5 bloků, hodně bílého prostoru, jemné stíny, tabular čísla; když uživatel nemá návyky ani trénink, ukázat klidný empty-state s jedinou výzvou (zapsat první pohyb), ne 5 prázdných karet."
  },
  {
    "philosophy": "test",
    "dnesekSections": [
      {
        "nazev": "a",
        "co": "b",
        "proc": "c"
      }
    ],
    "logika": "test",
    "akcni": "test",
    "ostatniTaby": "test",
    "cemuSeVyhnout": "test"
  },
  {
    "philosophy": "Dnešek = jeden klidný svislý scroll, který za 3 vteřiny zodpoví tři otázky v přesně tomto pořadí důležitosti: (1) \"Co mám dnes ještě udělat?\" (akce — můj prsten + Cesta dne), (2) \"Kde stojím vůči partě a hýbe se to?\" (soutěž jako tah, ne tlak — Souboj týdne + můj řádek ±1), (3) \"Co se právě děje a na co reagovat?\" (živý proud). Logika je řetěz JÁ → MY → ONI: nejdřív moje akce (jediné, co můžu hned ovlivnit), pak osobní soutěž na mé úrovni (každý má někoho vedle sebe, ne jen věčného vítěze nahoře), pak sociální jiskra. Soutěž je rámovaná jako \"dohnat jednoho člověka přede mnou\", nikdy jako \"jsem poslední ze sedmi\" — to je rozdíl mezi motivací a demotivací. Prázdnota současného Dnešku vzniká tím, že ukazuje jen statický stav (prsten + kousek žebříčku) bez akce a bez napětí; vyřeším to tím, že každá sekce buď nabízí akci, nebo živé napětí (kdo mě právě předběhl, kolik mi chybí na rivala). Žádná sekce není dekorace.",
    "dnesekSections": [
      {
        "nazev": "Hlavička: pozdrav + datum + série (tenký řádek)",
        "co": "Vlevo 'Dobré ráno, Marku' + dnešní datum. Vpravo kompaktní čip série s plamínkem: '🔥 17 dní'. Plamínek hoří jasně, dokud dnes nezapíšeš; po prvním dnešním záznamu se zklidní do zlaté. '+' je vpravo nahoře (globálně, dle redesignu).",
        "proc": "Série je nejsilnější denní páka (Duolingo princip), ale nesmí ukrást hlavní prostor prstenu — proto tenký řádek nahoře, ne velká karta. computeStreak už existuje včetně 'grace day' (dnes ještě nezapsáno = série drží do konce dne), takže plamínek může legitimně signalizovat 'série v ohrožení do půlnoci' bez lhaní. Pozdrav dle denní doby dělá z appky rituál, ne tabulku."
      },
      {
        "nazev": "HERO: jeden velký prsten dne + dnešní body + delta vs. včera",
        "co": "Jeden velký prsten = celkový denní bodový cíl. Uvnitř velké číslo dnešních bodů (např. '180'), pod ním malý šedý delta '+40 vs. včera' nebo 'o 20 míň než včera'. Po obvodu prstenu tenký trojbarevný oblouček (síla/kardio/strečink) = složení dne, ne tři samostatné kroužky. Pod prstenem dvě mikro-čísla: 'týden 1240 b' a 'do cíle dne zbývá 70 b'.",
        "proc": "Oprava největší slabiny konceptu A (tři rigidní kroužky frustrovaly toho, kdo dělá jen sílu) — jeden prsten zavře každý. Data jsou triviálně k dispozici: pointsForDay už existuje v heatmapě, kategorie se dělí přes isStretchActivity. Delta vs. včera dává dni smysl ('lepším se / polevuji') a je to levný, ale silný motivační signál. 'Zbývá X b do cíle' je akční rámec — konkrétní cíl, ne jen stav. Hero pozice, protože to je jediná věc, kterou uživatel přímo ovládá."
      },
      {
        "nazev": "Cesta dne: 3 akční dlaždice (Pohyb · Strečink · 1 návyk)",
        "co": "Tři malé dlaždice pod prstenem: 'Zapsat pohyb', 'Strečink', a dnešní nejbližší nesplněný návyk (vytažený z habit_logs, např. 'Voda 1/2 l'). Splněné = zelené s fajfkou a jemnou haptikou; nesplněné = vybídka s tapem, který otevře rovnou zápis dané kategorie. Návyk lze odškrtnout přímo zde bez '+'.",
        "proc": "Toto je hlavní lék na 'prázdnotu': dává Dnešku KONKRÉTNÍ akce na první obrazovku, ne jen pasivní čísla. Spojuje tři duše appky (pohyb + strečink + návyky) do jednoho denního rituálu se splnitelnými mikro-cíli (Duolingo dopamin). Návyk je chytře jen JEDEN (nejbližší nesplněný), aby se Dnešek nezahltil celým trackerem — ten zůstává v tabu Návyky. Každá dlaždice = jeden tap k akci, což odpovídá zadání 'co může uživatel rovnou udělat'."
      },
      {
        "nazev": "Souboj týdne: 1:1 rival na mé úrovni",
        "co": "Kompaktní karta: 'Souboj týdne — ty 230 · Petr 245'. Mini progress ukazuje rozdíl ('chybí 15 b'). Rival = automaticky přiřazený hráč s nejbližším týdenním skóre nade mnou (nebo pode mnou, pokud jsem první). Tap = otevře porovnání 1:1. Reset v neděli, v pondělí nový rival.",
        "proc": "Klíčová sociální mechanika: řeší největší slabinu VŠECH soutěžních konceptů — že 'věční poslední se vzdají'. Absolutní žebříček motivuje jen top 2-3; souboj na vlastní úrovni dá KAŽDÉMU dohnatelný cíl (15 b = jeden trénink). Soutěž jako tah, ne tlak. Data jsou hotová: týdenní žebříček s pozicí už počítá renderLeaderboardTotal s period='week'; rival = soused v seřazeném poli. Je nad obecným žebříčkem schválně — osobní, akční napětí je silnější motivátor než anonymní tabulka."
      },
      {
        "nazev": "Můj řádek v žebříčku: já ±1 (komprimovaný proužek)",
        "co": "Tři řádky: hráč nade mnou, JÁ (zvýrazněný), hráč pode mnou — s body a odstupem ('Janča 218 · TY 230 · Tomáš 240'). Malý segment Týden/Celkem přepíná kontext. Tap kdekoli = celý žebříček v tabu Parta.",
        "proc": "Soutěž je přítomná na první pohled (kompetitivní parta to chce), ale klidná a nedemotivující — vidím sebe a bezprostřední sousedy, ne propast k vítězi. Doplňuje Souboj týdne o širší kontext bez duplicity (souboj = jeden konkrétní cíl, žebříček ±1 = orientace). Plný žebříček je o tap dál v Partě, takže Dnešek zůstává klidný. Data hotová z renderLeaderboardTotal."
      },
      {
        "nazev": "Živý proud: poslední 3-4 záznamy přátel + 1-tap reakce",
        "co": "Decentní řádky: 'Petr · běh 5 km · +50 b · před 20 min' s avatarem a barvou hráče. Vpravo 1-tap reakce (💪🔥👏). Zvýraznit milníky ('Anna překonala osobní rekord!', 'Tomáš tě právě předběhl') jinou barvou, aby proud nebyl prázdný ani v klidných dnech.",
        "proc": "Sociální tah a důvod vracet se ('co dělali ostatní'). renderRecent už sbírá záznamy napříč hráči s časem a body. Reakce 1 tapem jsou ve Fázi 2 backlogu — sem patří přirozeně. Milníkové události (PR z computePersonalRecords, předběhnutí, kulatý streak) řeší problém řídkého feedu u party 7 lidí: i v den bez tréninků je co číst. Dole schválně — je to 'nice to know', ne akce; klidný konec scrollu."
      }
    ],
    "logika": "Tok pozornosti shora dolů kopíruje klesající ovlivnitelnost a rostoucí pasivitu: prsten + Cesta dne (můžu hned udělat) → Souboj + žebříček ±1 (můžu ovlivnit dnešní akcí, vidím proč) → proud (jen čtu/reaguji). Denní použití: RÁNO appku otevřu, vidím prázdný prsten + 3 kroky Cesty dne + 'na rivala mi chybí 15 b' → mám jasný plán dne. VEČER po tréninku zapíšu přes '+', prsten se dotočí, body naskočí, Cesta dne cvakne, posunu se v souboji → odměnový moment + důvod zavřít den. V KLIDNÝ den (necvičím) appku stejně otevřu kvůli živému proudu a kontrole, jestli mě někdo nepředběhl v souboji — tah party drží retenci i bez mé aktivity. Vše je informačně bohaté (delta, odstup, rival, milníky, série), ale klidné: jeden hero prsten + krátké textové řádky, žádné soupeřící velké bloky.",
    "akcni": "Pět akčních bodů přímo z Dneška, žádné prokliky do hloubky: (1) '+' vpravo nahoře = zapsat jakýkoli pohyb; (2) tři dlaždice Cesty dne = tap otevře rovnou zápis dané kategorie (Pohyb/Strečink) nebo odškrtne návyk in-place; (3) 'do cíle dne zbývá 70 b' = konkrétní akční cíl pod prstenem; (4) Souboj týdne 'chybí 15 b' = jasné, dohnatelné číslo (jeden trénink); (5) 1-tap reakce v živém proudu = sociální akce bez psaní. Každá akce má okamžitou vizuální odměnu (prsten se dotočí, body naskočí, dlaždice cvakne, posun v souboji).",
    "ostatniTaby": "PARTA: sem patří plný žebříček (z 'já ±1' proužku), kalendář/heatmapa všech (renderHeatmap), rekordy a profily hráčů (computePersonalRecords, openPlayerEntriesModal), Síň slávy vítězů týdnů. Přidat: záložku/segment 'co dělali ostatní' = plný živý proud (Dnešek ukazuje jen 3-4). NÁVYKY: zůstává plný tracker (renderNavyky, týdenní strip, statistiky) — na Dnešek se promítá jen JEDEN nejbližší nesplněný návyk v Cestě dne, zbytek tady. JÁ: osobní heatmapa, MOJE rekordy, odznaky, kompletní historie mých záznamů, nastavení/cíle prstenu. Doporučení k přesunu: současný 'kousek žebříčku' a 'týdenní trend' z Dneška se ruší jako samostatné prvky — trend je teď delta pod prstenem + týdenní souboj, žebříček je 'já ±1'. Drž v Já přísnou hierarchii (rekordy nahoře → heatmapa → archiv), ať není skládka.",
    "cemuSeVyhnout": "Vyhnout se: (1) DUPLICITĚ čísel — týdenní body ať jsou jen na jednom místě (mikro-číslo pod prstenem), ne třikrát; Souboj a žebříček ±1 nesmí říkat totéž (souboj = 1 cíl, žebříček = orientace). (2) PRÁZDNÝM stavům bez akce — když nemám záznam, prsten ukáže 'začni dnešní pohyb' s tapem, ne jen '0'; když je proud prázdný, vyplnit milníky/streaky, nikdy bílé místo s 'zatím nic'. (3) DEMOTIVACI absolutním žebříčkem — proto NIKDY ne 'jsi 7. ze 7' jako hero; vždy rámovat jako odstup k JEDNOMU sousedovi. (4) GENERICKÝM výplním — žádné prázdné 'motivační citáty', fake grafy, dekorativní ikony bez funkce, ani 'AI dribbble' gradientové karty. (5) PŘEPLÁCANOSTI — max jeden velký vizuální prvek (prsten); vše ostatní textové řádky a malé dlaždice. (6) Celému habit trackeru na Dnešku — jen 1 návyk, zbytek do tabu Návyky, jinak se Dnešek zahltí."
  },
  {
    "philosophy": "Dnešek = jedna otázka „pohnul ses dnes a kde stojím v partě?\" zodpovězená do 2 vteřin, plus 1-2 věci, co můžu HNED udělat. Hierarchie shora dolů kopíruje denní cyklus: nejdřív JÁ DNES (stav + co dotáhnout), pak SOUTĚŽ (proč pokračovat), nakonec DĚNÍ (sociální tah zpět zítra). Není to dashboard ani rozcestník — je to akční rituál. Pocit PRÁZDNA nevzniká z mála prvků, ale z prvků BEZ akce a BEZ napětí — lék není přidat karty, ale dát každému prvku akci (odškrtnout, dotáhnout, zareagovat) a vztah (vůči cíli / vůči jednomu konkrétnímu člověku). Pocit NELOGIČNOSTI vzniká z prstenu, který ukazoval „body z cíle\", ale appka žádný reálný denní cíl nemá → číslo bez měřítka. Řešení: dát prstenu měřítko, které data MAJÍ (vlastní průměr / včerejšek / série), ne vymyšlený fixní cíl.",
    "dnesekSections": [
      {
        "nazev": "0) Sticky hlavička: pozdrav + datum + série s plamínkem",
        "co": "Jeden tenký řádek nad scrollem. Vlevo: „Dobré ráno, Marku\" + datum. Vpravo: plamínek + číslo série („17\"). Plamínek hoří jasně dokud dnes nezapíšeš první pohyb, po zápisu se zklidní do zlaté. Tap = co je série + stav streak-freeze. „+\" zůstává úplně vpravo nahoře.",
        "proc": "Série je nejsilnější páka denního návratu a JEDINÉ číslo s jasným měřítkem bez vymýšlení cílů („neztratit, co mám\"). Ztráta série je hlavní emoční důvod appku dnes otevřít, proto patří nejvýš. Sticky = plamínek je v očích jen dokud nedojdeš k Partě."
      },
      {
        "nazev": "1) HERO: Dnešní stav — jeden prsten + dnešní body S MĚŘÍTKEM",
        "co": "Velký prsten, uvnitř velké číslo = dnešní body. Po obvodu tenký trojbarevný oblouk = složení (síla/kardio/strečink/lezení). POD číslem malý kontext, který dává měřítko: „+35 vs. včera\" nebo „dnešní průměr party: 80\". ŽÁDNÝ vymyšlený fixní cíl 100/den — měřítkem je tvůj 7denní průměr a včerejšek. Když dnes 0 → prsten prázdný, ale ne „nelogicky\": pod ním stojí „Zatím nic. Tvůj průměr je 80 b.\" jako jemná výzva.",
        "proc": "Oprava jádra problému: prsten BEZ měřítka = nelogické číslo. Vlastní průměr/včerejšek je měřítko, které data reálně mají, je vždy férové (nikdy nedosažitelné ani triviální) a osobní. Jeden prsten místo tří řeší, že kdo dělá jen sílu, nikdy nezavře tři kroužky. Hero nahoře, protože „jak jsem na tom dnes\" je první otázka po otevření."
      },
      {
        "nazev": "2) AKČNÍ: Dnešní návyky — odškrtávací řádky přímo na Dnešku",
        "co": "Kompaktní seznam DNEŠNÍCH návyků (jen ty, co mají dnes padnout) jako odškrtávací řádky: název + malý progress („Voda 1/2 l\") + checkbox/krok. Odškrtnout jde rovnou tady, bez přepínání na tab Návyky, s haptikou. Nad seznamem mini-souhrn „Dnes: 2/4 návyky\". Když je vše hotovo → sbalí se do klidného „Návyky dnes hotové ✓\".",
        "proc": "TOHLE je největší zdroj denní akce a hlavní lék na „prázdno\" — místo pasivních čísel dáváš věci, co lze HNED udělat jedním tapem. Návyky jsou denní rituál par excellence; za tabem je člověk neuvidí a nevyplní. Patří hned pod stav, protože „co mi dnes zbývá\" je druhá otázka po „jak na tom jsem\". Akce = dopamin = důvod otevřít denně."
      },
      {
        "nazev": "3) SOUTĚŽ kompaktně: tvoje pozice ±1 soused (já v kontextu party)",
        "co": "JEDEN klidný řádek/karta: „3. místo — 40 b za Petrem, 12 b před Jančou\" (jen soused nad a pod tebou, period = Týden). Volitelně mini-páska „Souboj týdne\": jeden přidělený rival s podobným skóre („Ty 230 — Petr 245\"). Tap na celé = otevře tab Parta s plným žebříčkem.",
        "proc": "Soutěž je druhá duše appky, ale na Dnešku patří jako NAPĚTÍ, ne tabulka — celý žebříček má vlastní tab (Parta). „Já ±1\" dává okamžitý tah bez demotivace (vidíš dosažitelný cíl, ne propast nad sebou). Rival řeší věčně poslední — každý má někoho na své úrovni. Je pod osobní částí: nejdřív „já\", pak „oni\"; výš by to přebíjelo osobní rituál a demotivovalo slabší."
      },
      {
        "nazev": "4) DĚNÍ: živý proud party — poslední 3-4 záznamy + 1tap reakce",
        "co": "Decentní seznam posledních 3-4 záznamů přátel: „Petr · běh 5 km · +50 b · před 20 min\" s avatarem a 1tap reakcí (💪🔥👏). Žádný nekonečný feed — pár řádků + „Zobrazit vše\" → záznamy v Partě. Když je ticho (klidný den u 7 lidí): místo prázdna ukázat milník/streak event („Anna má 30denní sérii\") nebo „Dnes zatím nikdo — buď první\".",
        "proc": "Sociální tah, který tě stáhne zpět ZÍTRA (reagoval jsi → chceš vidět reakci). Patří dolů: je to „nice to know + zapojit se\", ne akce na tobě. Reakce dělá z pasivního řádku akci (lék na prázdno). Fallback na milníky řeší reálné riziko u party 7 lidí — feed nesmí být nikdy prázdný, jinak Dnešek zase působí mrtvě."
      }
    ],
    "logika": "Tok pozornosti = denní cyklus a klesající „je to o mně\": (0) série = neztratit → (1) jak jsem na tom dnes → (2) co mi dnes zbývá udělat → (3) kde stojím v partě → (4) co dělají ostatní. První tři vrstvy (série, stav, návyky) jsou čistě JÁ a obsahují akce; pak teprve soutěž a sociální dění. Ráno appka řekne „máš sérii, dnes 0 b, zbývají 4 návyky, jsi 3., Petr běhal\" → jasný plán. Večer „série drží, prsten plný, návyky ✓, posunul ses na 2.\" → uzavření dne. Každá sekce má buď akci (odškrtni návyk, reaguj, zapiš přes +) nebo napětí (série hoří, soused je 12 b před tebou) — nic není jen dekorace. Informačně bohaté (5 vrstev), ale klidné: každá vrstva je 1 řádek/karta, hodně bílého prostoru, jeden emeraldový akcent.",
    "akcni": "Z Dnešku jde rovnou udělat: (1) odškrtnout dnešní návyk přímo v sekci 2 (jeden tap, haptika, bez přepínání tabu) — hlavní denní akce; (2) zapsat pohyb přes „+\" vpravo nahoře → po uložení se prsten dotočí a body naskočí (odměnový moment přímo na Dnešku); (3) zareagovat 💪🔥👏 na záznam přítele v živém proudu; (4) tapnout na soubojový/žebříčkový řádek → skok do Party. Pravidlo: každá sekce Dnešku musí umožnit akci NEBO nést napětí. Pasivní „jen číslo\" karty (samostatná heatmapa, statistiky, celý žebříček) na Dnešek NEPATŘÍ — patří do Parta/Já.",
    "ostatniTaby": "PARTA: sem patří VŠE pasivně-soutěžní vyhozené z Dnešku — plný žebříček (segment Týden/Měsíc/Celkem + kategorie přes swipe), kalendář/heatmapa party, rekordy, statistiky, kompletní záznamy ostatních, profily hráčů (tap = bottom sheet) a týdenní „uzávěrka\" (vítěz týdne + reset). NÁVYKY: zůstává jako plný tab pro SPRÁVU (zakládání, editace, frekvence, statistiky/heatmapa návyků, posun po týdnech). Klíč: DENNÍ odškrtávání se přesouvá na Dnešek (sekce 2); tab Návyky je pro setup a dlouhodobý pohled, ne pro každodenní rutinu. JÁ: osobní rozvoj a archiv — osobní rekordy, odznaky, moje heatmapa, moje kompletní historie, nastavení, streak-freeze, (budoucí) návod/tipy a calorie tracker. Držet přísnou hierarchii (rekordy → archiv → nastavení), ať to není skládka. Přesuny: dnešní habit-check z Návyků → Dnešek; „já ±1\" výřez žebříčku na Dnešku, celek v Partě.",
    "cemuSeVyhnout": "PRÁZDNOTA: nedávat na Dnešek pasivní „jen čísla\" (samostatná heatmapa, trend graf, celý žebříček, statistiky) — to vytvářelo prázdno, protože jsou to data ke koukání, ne akce; patří do Parta/Já. Prázdné stavy řešit výzvou s měřítkem („Tvůj průměr je 80 b\"), ne prázdným prstenem bez kontextu; feed party fallbackem na milníky, ať není mrtvý. PŘEPLÁCANOST: max ~5 vrstev, každá 1 řádek/karta; ne tři prsteny vedle sebe, ne dva pásy filtrů na Dnešku (Dnešek je vždy „dnes\", filtry žijí v Partě), ne nekonečný feed. KLIŠÉ A VÝPLŇ: žádné „motivační citáty dne\", žádné dekorativní ilustrace/maskot u party dospělých, žádné fake gradienty a „AI dribbble\" stíny, žádný vymyšlený fixní denní cíl 100/den (nelogický — měřítkem je vlastní průměr). Tvrdý test na každý prvek: „dá se s tím něco udělat, nebo nese napětí?\" Když ne → pryč z Dnešku."
  }
]
```

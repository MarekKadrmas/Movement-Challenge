# Detailní obrazovky — kritický průchod (prototyp)

✅ = ready, 🔧 = doladit. Žádná obrazovka není zatím ready — všech 17 potřebuje doladit. Řadím od nejdůležitějších (zápisový tok, který lidi použijí každý den) po okrajové.

## Zápis pohybu (denní jádro)

**addsheet — panel „Co jsi dělal?"** 🔧
- Přebarvit 4 syté dlaždice do systémové palety (jemné pastelové karty + barevná ikona), zelený „Cvik" oddělit od emeraldového akcentu appky, ať nesplývají.
- Spodní řada dlaždic (Strečink, Lezení) se schová za plovoucí lištu — zvednout panel nad lištu nebo lištu při otevření skrýt, jinak jsou 2 ze 4 akcí napůl neviditelné.
- Přidat X na zavření (teď jde zavřít jen gestem, není to poznat).

**formcvik — Nový záznam (cvik)** 🔧
- Chybí 4. cvik **Dipy** (appka má Shyby/Dřep/Kliky/Dipy) — doplnit.
- Chybí pole **Datum** (default „Dnes") — bez něj nejde zapsat zpětně a datum picker nemá odkud vyskočit.
- Domockovat režim **„Série"** (seznam sad + „Přidat sadu") — teď nejde posoudit hlavní funkci.
- Přidat X / „Zrušit" do hlavičky (platí pro všechny formuláře).

**formlez — Nový záznam (lezení)** 🔧
- Přidat **„+ Přidat cestu"** a mazání řádku — teď nejde zapsat víc než napevno vyplněné cesty.
- Vyjasnit sloupec **Font/V** (je to volba stupnice? udělat z něj přepínač) — teď matoucí.
- Chybí **Datum** (stejně jako u cviku) + popisek „spočítáno živě" u „+85 b" (konzistence s formcvik).

**datum — Datum záznamu** 🔧
- Kalendář ukazuje jen **jeden týden** místo celého měsíce — nejde vybrat starší den = blokuje zpětný zápis. Zobrazit celý měsíc.
- **Zašedit budoucí dny** (nejdou vybrat).
- Vizuálně oddělit „dnes" (rámeček) od „vybráno" (emeraldová výplň), ať má tlačítko „Dnes" smysl.

## Návyky (druhé jádro)

**tvorba — Nový návyk** 🔧
- Chybí **typ návyku „Splnit ✓ / Změřit #"** — bez něj nejde vytvořit měřitelný návyk (např. „Pít 8 sklenic"), přitom appka je jinde předpokládá. Zásadní díra.
- **„Jak často?"** je jen kosmetika — u „Vybrané" chybí volič dnů Po–Ne, u „Týdně" chybí „kolikrát týdně". Data pro „3× týdně" nemají odkud vzniknout.
- „Platí od–do" schovat pod „Pokročilé" (90 % lidí chce „od dneška, bez konce").
- Přidat zpět/zavřít + živý náhled řádku návyku.

**zapis — panel „Kolik sklenic vody?"** 🔧
- **Sjednotit jednotku:** panel se ptá na „sklenice/8", ale návyk se jmenuje „Pít 2 l vody" (litry) — přímý rozpor, uživatel neví co zapisuje.
- Nahradit nativní **posuvník** vlastním stepperem `[–] 6 [+]` s emeraldovým progressem (přesnější na mobilu, drží styl).
- Přidat rychlé **„+1"** a zavření panelu.
- Oslavný stav při splnění cíle (8/8).

**statistiky — Návyky › Statistiky** 🔧
- Přidat **souhrn nahoře** (nejdelší série, úspěšnost %, aktivních dní) — teď statistika bez čísel.
- **Přepínač Týden/Měsíc/Rok nic nedělá** — zprovoznit, nebo odstranit.
- Přidat **legendu** k mřížce (co znamená vybarvený čtvereček) + proklik na detail návyku.
- Sladit počet návyků se záložkou Dnes (5, ne 3) + prázdný stav.

## Profily, rekordy, přehledy

**profil (karta hráče)** 🔧
- **Dipy** se objeví jen tady (v rozpadu cviků), jinde v appce nejsou — sjednotit sadu cviků napříč (buď Dipy všude, nebo pryč).
- U **cizího profilu** skrýt „Upravit" a „Historie úprav" (proč můžu editovat cizí rekordy?) + nahoře nezobrazovat můj avatar a „+".
- Zrušit duplicitu jména (nadpis „Martin" + karta „Martin").
- U „2. místo" doplnit období (za týden? celkem?).

**rekordy (maximálky + rekordy party)** 🔧
- **Zvýraznit můj řádek** v tabulce (jinde v žebříčcích „ty" vždy svítí — tady chybí).
- Doplnit **jednotky** (Dřep kg, Boulder Font/V) + legendu „zeleně = nejlepší v partě".
- „Jak se boduje" udělat jako **klikací řádek se šipkou ›** (teď vypadá jako popisek, ne akce).
- K rekordům party přidat datum + proklik na den/hráče.

**rokparty (Rok party)** 🔧
- **Graf „Body v čase" má 5 čar bez legendy** — nepoznáš kdo je kdo. Přidat legendu (tečky se jmény) nebo highlight jen mě + průměr.
- Sladit **text vs. vizuál**: caption říká „čtvereček", ale kreslí se proužky.
- Nadpisy sekcí jsou napevno „2026 / celý rok", ale nahoře je přepínač Týden/Měsíc — navázat nadpisy na zvolené období.
- Vysvětlit kryptické „série party 🔥 12" a „nejakt. den Út".

## Historie a detaily dne

**zaznamy — „Záznamy" (historie party)** 🔧
- Přidat **souhrn nad seznamem** („N záznamů · X b", reaguje na filtr) — jako má „Moje záznamy".
- **Nastavený filtr vizuálně odlišit** (zelená pilulka) + „Zrušit filtry"; sjednotit ikonu ▾ vs ×.
- Denní součet u nadpisu dne + prázdný stav filtru („žádné záznamy").
- V hlavičce nahradit „+" a avatar **zpětnou šipkou** (přidávat záznam sem nepatří).

**historie — „Moje záznamy" (historie hráče)** 🔧
- Doplnit **editační sheet pro ✏️** (předvyplněný formulář + „Smazat" + undo) — teď tužka nikam nevede.
- **Řádky/den proklikatelné na detail dne** + denní součet u nadpisu dne.
- Prázdný stav + „zpět" do „Já".
- Sjednotit **formát data** (Dnes/Včera + „Pátek 27. 6.") napříč obrazovkami.

**den — detail dne hráče** 🔧
- Přidat **zpět/zavřít** (teď se sem proklikáš z kalendáře a není cesta ven).
- U **cizího hráče skrýt tužku ✏️** (editace cizích záznamů) — read-only.
- Vrátit řádkům **typový podtitul** (cvik/aktivita) + barvu ikony podle kategorie (běh není „cvik").
- Prázdný stav dne bez záznamů.

## Onboarding (jednorázový, ale první dojem)

**login — Přihlášení** 🔧
- Přidat **chybový stav** (špatné heslo) a **odesílání** (tlačítko disabled + „Přihlašuji…") — u přihlášení nutné.
- Snížit prioritu registrace: primární je „Přihlásit se", „Zapomněl jsi heslo?" pod pole, registrace až dole.
- „Zůstat přihlášen" (denní mobilní použití = jinak velké tření).
- Oko u hesla řešit ikonou ve fieldu, ne mezerami.

**claim — Vyber profil** 🔧
- Předělat výběr hráče na **karty s avatarem** (kolečko + iniciály jako všude jinde) — teď jen textové pilulky, neškáluje na 9–10 lidí.
- **Nikoho nepředvybírat** (teď je „Mára" zeleně = riziko potvrdit cizí profil); tlačítko disabled dokud není vybráno + kód.
- Přidat mikrocopy **odkud kód vzít** + stav „profil už obsazený" a „nejsem tu / jsem nový".

**uprava — „Úprava profilu"** 🔧
- Chybí **Jméno + Avatar/Barva** (profil je jinde zobrazuje, tady nejdou změnit) — doplnit nahoru.
- Chybí **Max kliky** (jinde se sledují) — doplnit do maxim; oddělit „Míry" (privátní) od „Maximálky (ovlivňují body)".
- U „Max boulder" udělat z Font/V **přepínač** místo textu.
- Zpět/zavřít + „Zahodit neuložené změny?".

**bodovani — „Jak se boduje"** 🔧
- Chybí kategorie **LEZENÍ** — přitom dává nejvíc bodů (boulder V6 = +95). Věcná díra, doplnit 5. kartu.
- Vysvětlení je vágní („20/40 b") — přidat **konkrétní číselné příklady** (Kliky 50× → +35 b, Běh 5 km → +48 b, Boulder V6 → +95 b) + ikonu/barvu kategorie.
- Oddělit **„Série 🔥"** od kategorií (je to bonus, ne typ zápisu).
- Opravit přebývající `</div>` v markupu.

---

## Nejdřív bych řešil tohle (priorita napříč)

1. **Datum ve formulářích + funkční kalendář** — teď nejde zapsat pohyb zpětně (kalendář ukazuje jen týden, formuláře nemají pole Datum). Blokuje reálné použití appky.
2. **Rozpor jednotek u návyků** (tvorba „litry" vs zápis „sklenice") + chybějící typ „Změřit #" — celý měřitelný návyk momentálně nefunguje konzistentně.
3. **Barvy a spodní řada v addsheet** — první obrazovka zápisu, kterou lidi vidí denně; teď vypadá lacině a 2 ze 4 akcí jsou schované za lištou.
4. **Zavírací/zpět afordance všude** — formuláře, panely i detaily dne nemají X/zpět. Systémový nedostatek přes všechny obrazovky.
5. **Práva u cizích profilů/dnů** — tužka „Upravit" u cizích záznamů (profil, den) = matoucí a nebezpečné; skrýt pro read-only.
6. **Dipy a jednotky konzistentně** — buď doplnit Dipy všude, nebo nikde; doplnit kg/Font-V do rekordů; sladit sadu cviků napříč (formcvik, profil, rekordy, bodovani).


# Příloha (JSON)

```json
[
  {
    "nazev": "addsheet — spodní panel \"Co jsi dělal?\"",
    "verdikt": "needs-work",
    "problemy": [
      "Chybí zavírací afordance panelu. Je tu jen drag handle (proužek), ale žádné X ani viditelný gesture hint. Na prototypu není jasné, jak panel zavřít bez výběru.",
      "Ve screenshotu jsou vidět jen 2 dlaždice (Cvik, Aktivita); spodní řada (Strečink, Lezení) je překrytá plovoucí lištou. V markupu existují, ale při reálné výšce sheetu se spodní řada tluče se spodní navigací = riziko, že 2 ze 4 hlavních akcí jsou napůl schované.",
      "Barvy dlaždic (#34C759 zelená Cvik, #0A84FF modrá, #FF9F0A oranžová, #8B6FE0 fialová) NEJSOU emeraldová paleta systému (#0FA968). Zelený Cvik navíc splývá s emeraldovým akcentem appky = ztrácí se rozlišení \"akční akcent\" vs. \"kategorie Cvik\".",
      "4 syté plné barvy vedle sebe působí lacině/pestře oproti čisté světlé estetice hlavních tabů (jemné karty, jeden akcent). Je to jediné místo se 4 fullcolor bloky.",
      "Chybí titulek kontextu data — sheet neukazuje, ke kterému dni se zápis vztahuje (na rozdíl od formulářů, kam patří výběr data)."
    ],
    "opravy": [
      "Přidej explicitní zavírací prvek (X vpravo nahoře v hlavičce sheetu) vedle drag handle — nespoléhej jen na gesto.",
      "Zvyš z-index / spodní padding sheetu tak, aby spodní řada dlaždic byla celá nad plovoucí lištou, nebo lištu při otevřeném sheetu skryj/ztlum.",
      "Sjednoť barevnost do systému: buď jemné pastelové karty s barevnou ikonou + tmavým textem (jako .fav řádky v Záznamech: barva22 pozadí + sytá ikona), nebo 4 tlumené kategorie a akcent nech jen pro CTA. Cvik dej jinou barvu než emeraldový akcent, aby se nepletl.",
      "Zvaž zmenší kompaktnější dlaždice (2×2 mřížka jde udělat nižší), aby se vešly celé bez kolize s lištou."
    ]
  },
  {
    "nazev": "formcvik — Nový záznam (cvik)",
    "verdikt": "needs-work",
    "problemy": [
      "FUNKČNĚ chybí Dipy. Brief říká reálná appka má Shyby/Dřep/Kliky/Dipy, mockup nabízí jen Shyby/Kliky/Dřep. Chybí čtvrtý cvik.",
      "FUNKČNĚ chybí výběr data záznamu. Brief výslovně říká, že appka má výběr data (obrazovka datum existuje samostatně), ale ve formuláři cviku není žádné pole/tlačítko \"Datum\", takže datum obrazovka nemá odkud být vyvolána. Uživatel nemá jak zapsat zpětně.",
      "Mód \"Série\" je v přepínači, ale prototyp neukazuje, jak série vypadá (víc řádků sada×opakování×váha, přidání sady). Chybí druhý stav = nelze posoudit klíčovou funkci. V \"Jedna sada\" jsou jen Opakování + Váha.",
      "Chybí zavírací/zpět afordance. Formulář je celoobrazovkový, ale nemá X ani \"Zrušit\" ani hlavičku s návratem — nekonzistentní očekávání proti hlavním tabům, které hlavičku mají.",
      "Pole (Opakování 50, Váha 0 kg) jsou statické divy .inp bez naznačení, že jsou editovatelná (žádný stepper +/−, žádný kurzor/caret hint). Pro rychlý zápis by pomohly steppery nebo číselník.",
      "Duplicitní/matoucí návěští: nahoře je řádek typů s aktivním \"💪 Cvik\" a hned pod ním label \"Cvik\" pro výběr konkrétního cviku. Dvakrát slovo Cvik ve dvou různých významech = tření.",
      "\"Váha 0 kg\" jako placeholder u cviku typu Kliky/Shyby je nejasná — u tělesných cviků váha často není relevantní (nebo je to přídavná zátěž?). Chybí vysvětlení, co 0 kg znamená.",
      "Chybí chybový/validační stav (co když je Opakování prázdné) a stav po odeslání (loading/success)."
    ],
    "opravy": [
      "Přidej Dipy jako čtvrtý cvik do řady (Shyby/Dřep/Kliky/Dipy — pozor i na pořadí dle reálné appky).",
      "Přidej řádek/pole \"Datum\" (default Dnes) hned pod typ nebo nad Zapsat, které otevře obrazovku datum. Bez toho je datum picker nedostupný.",
      "Domockuj stav \"Série\": seznam sad (1: 12×, 2: 10×, …), tlačítko \"+ Přidat sadu\", ať jde posoudit hlavní režim.",
      "Přidej do hlavičky formuláře X nebo \"Zrušit\" (vlevo) a nech titul \"Nový záznam\" — sjednoť se všemi form obrazovkami (formlez, tvorba, uprava mají stejný problém).",
      "U číselných polí přidej steppery +/− nebo aspoň vizuál editovatelného inputu (caret, jemný focus rámeček), aby to nevypadalo jako read-only.",
      "Přejmenuj label výběru cviku z \"Cvik\" na \"Který cvik\" nebo skryj (dlaždice jsou samovysvětlující), ať se neopakuje se záhlavím typu.",
      "U tělesných cviků označ váhu jako \"Přídavná zátěž\" a skryj/zneaktivni, pokud se nepočítá."
    ]
  },
  {
    "nazev": "formlez — Nový záznam (lezení)",
    "verdikt": "needs-work",
    "problemy": [
      "Cesty jsou předvyplněné statické řádky (#1·V4 Font/V, #2·V5 Font/V) bez akce \"Přidat cestu\" / smazat. Není jasné, jak přidat 3. cestu nebo řádek odebrat = chybí klíčová funkce zápisu více cest.",
      "Pravý sloupec \"Font/V\" je nejasný — vypadá jako label škály, ale je ve stylu inputu. Není zřejmé, jestli se tam vybírá stupnice (Font vs. V/US) nebo je to jen popisek. Matoucí.",
      "Chybí výběr data záznamu (stejně jako u cviku) — datum obrazovka nemá odkud být vyvolána.",
      "Chybí počet pokusů / styl (flash / RP / TR / OS) — u lezení běžné a pravděpodobně ovlivňuje body; brief zmiňuje živý výpočet, ale vstupy pro něj jsou chudé (jen obtížnost).",
      "Živý výpočet \"+85 b\" nemá popisek \"spočítáno živě\", který má formcvik → nekonzistence mezi dvěma sourozeneckými formuláři.",
      "Chybí zavírací/zpět afordance (stejné jako formcvik).",
      "Chybí prázdný stav (žádná cesta zatím) a chybový/success stav."
    ],
    "opravy": [
      "Přidej tlačítko \"+ Přidat cestu\" pod seznam a swipe/ikonu smazání u řádku. Ukaž aspoň prázdný řádek jako výzvu k přidání.",
      "Vyjasni pravý sloupec: pokud je to volba stupnice, udělej z něj segment/přepínač (Font | V) buď globálně pro celou relaci, ne u každé cesty zvlášť; jinak popisek zmenši/přesuň.",
      "Přidej pole \"Datum\" napojené na obrazovku datum.",
      "Zvaž pole styl/pokusy per cesta (flash/RP), pokud ovlivňuje body — jinak doplň vysvětlení, z čeho se +85 b počítá.",
      "Doplň pod +85 b stejný popisek \"spočítáno živě\" jako u formcvik, kvůli konzistenci.",
      "Přidej X / \"Zrušit\" do hlavičky (sjednotit se všemi formuláři)."
    ]
  },
  {
    "nazev": "datum — Datum záznamu",
    "verdikt": "needs-work",
    "problemy": [
      "Kalendář ukazuje jen JEDEN týden (řádek 23–29), ne měsíc. Titulek říká \"Červen 2026\" a jsou tu šipky ‹ › na přepínání měsíců, ale mřížka má jediný řádek → uživatel nemůže vybrat jiný den měsíce než tento týden. To je funkční blocker pro zpětný zápis (např. z minulého týdne).",
      "Nejasné, jestli ‹ › listuje měsíce (dle titulku) nebo týdny (dle jednořádkové mřížky) — rozpor mezi hlavičkou (měsíc) a obsahem (týden).",
      "Chybí zamezení výběru budoucích dní (do 27. jde vpravo 28, 29 = budoucnost). Pro zápis pohybu do budoucna nedává smysl; chybí disabled stav budoucích dat.",
      "Tlačítko \"Dnes\" a vybraný den 27 jsou ta samá věc (dnes je Pá 27.), takže na prototypu není poznat, co \"Dnes\" dělá navíc oproti tomu, že 27 už je vybrané.",
      "Není označeno, které dny už mají záznam (u habit/deníku obvyklé) — drobný, ale užitečný kontext chybí.",
      "Obrazovka je samostatná, ale ve formulářích na ni není odkaz (viz výše) — takže v prototypu je nedostupná / nezřejmé, jak se sem člověk dostane a kam se vrátí."
    ],
    "opravy": [
      "Zobraz plnou měsíční mřížku (5–6 řádků) — teď je to jen jeden týden. Buď to udělej měsíční, nebo změň titulek na týdenní rozsah, ať hlavička odpovídá obsahu.",
      "Ujednoť navigaci: ‹ › nech listovat měsíce a ukaž celý měsíc; dnešek zvýrazni rámečkem a vybraný den výplní (dva odlišné stavy).",
      "Zašeduj (disabled) budoucí dny, aby nešly vybrat.",
      "Rozliš vizuálně \"dnes\" (rámeček/tečka) od \"vybráno\" (emeraldová výplň); pak dává tlačítko Dnes smysl jako skok.",
      "Zvaž tečku/značku u dní, které už mají zápis.",
      "Napoj obrazovku na pole Datum ve formcvik/formlez a ukaž návrat (tlačítko Hotovo je OK, ale musí být odkud vyvoláno)."
    ]
  },
  {
    "nazev": "tvorba — Nový návyk (formulář)",
    "verdikt": "needs-work",
    "problemy": [
      "FUNKČNĚ CHYBÍ typ návyku: reálná appka umí MĚŘITELNÉ návyky (jednotka + cíl, např. sklenice/8, minuty/20), ale formulář nabízí jen ANO/NE návyk. Chybí přepínač 'Splnit / Měřit' a při 'Měřit' pole Jednotka + Denní cíl. Bez toho nejde vytvořit 'Pít 8 sklenic', přitom zápis (S.zapis) i dnešní taby ('Pít 2 l vody', 'Číst 20 min') měřitelné návyky předpokládají — vzájemný rozpor.",
      "FUNKČNĚ CHYBÍ dynamika u 'Jak často?': u 'Vybrané' se nezobrazí výběr dnů (Po–Ne), u 'Týdně' se nezobrazí počet za týden (např. 3× týdně). Segment je jen kosmetický, přitom dnešní tab návyků už zobrazuje '3× týdně · splněno 1/3' — data pro to musí odněkud vzniknout.",
      "TŘENÍ: 'Platí od – do' řeší 90 % uživatelů 'od dneška, bez konce' — je to zbytečně nahoře a přidává kognitivní zátěž. Většina habit trackerů to schovává za 'Pokročilé'.",
      "CHYBÍ cesta ven: formulář nemá zpět/zavřít ani Zrušit. Uživatel se z rozdělané tvorby nedostane bez ztráty (nekonzistence s bottom-sheety, které mají handle).",
      "NEKONZISTENCE ikon: emoji nabídka (💧🏃😴📖) je jen 4 pevné volby bez možnosti 'více' — reálně bude ikon víc; navíc pravidlo projektu říká, že emoji budou nahrazeny vlastními ikonami, takže výběr musí počítat s galerií, ne 4 fixními.",
      "CHYBÍ stav: žádná validace prázdného názvu, žádný disabled stav submitu, žádný náhled jak návyk bude vypadat v seznamu (ikona+barva+název pohromadě)."
    ],
    "opravy": [
      "Přidat hned pod Název přepínač typu: [Splnit ✓] / [Změřit #]. Při 'Změřit' odkrýt řádek Jednotka (sklenice/min/km/…) + Denní cíl (číslo). Tím se sjednotí s S.zapis a s dnešními taby.",
      "Udělat segment 'Jak často?' funkční: 'Vybrané' → pod ním týdenní volič dnů (chipy Po–Ne, stejný styl jako .wks); 'Týdně' → stepper 'Kolikrát týdně: [–] 3 [+]'.",
      "Sbalit 'Platí od – do' pod řádek 'Pokročilé (datum, připomínka) ›'; default 'od dneška, bez konce' napsat jako placeholder.",
      "Přidat handle/šipku zpět + text 'Zrušit' vlevo nahoře (konzistence s ostatními detaily); u editace existujícího návyku přidat 'Smazat návyk'.",
      "Doplnit živý náhled řádku návyku nad submit (jako v S.navyky .hbm), ať uživatel vidí výsledek. Emoji řádek zakončit dlaždicí '＋ více', počítat s pozdější ikonovou galerií.",
      "Zvážit volitelnou 'Připomínku' (čas) — u streak-appky se streakem 🔥 to snižuje třeni v udržení série."
    ]
  },
  {
    "nazev": "zapis — bottom sheet 'Kolik sklenic vody?'",
    "verdikt": "needs-work",
    "problemy": [
      "NEKONZISTENCE jednotek: sheet se ptá na 'sklenice' a 'cíl 8', ale tentýž návyk je v tabu Návyky pojmenován 'Pít 2 l vody' (litry). Uživatel neví, jestli zapisuje sklenice nebo litry — přímý rozpor mezi tvorbou/seznamem a zápisem.",
      "TŘENÍ/nejasnost posuvníku: hodnota '6' je holé číslo bez jednotky ('6 sklenic'), posuvník nemá stupnici ani značky, value='75' (%) neodpovídá zobrazené 6/8 — vizuálně matoucí. Trefit přesně 6 z 8 tažením je na mobilu nepřesné.",
      "NEKONZISTENCE vzhledu: '<input type=\"range\">' je nativní prohlížečový prvek — šedý, hranatý, mimo čistý světlý styl s emeraldovým akcentem a zaoblením. Trčí ze systému.",
      "CHYBÍ akce: sheet nelze zavřít/zrušit (jen 'Uložit'), chybí rychlé +1 (nejčastější akce u vody je 'přidal jsem jednu sklenici'), chybí 'Splnit cíl' zkratka.",
      "CHYBÍ stav: žádný stav při dosažení/překročení cíle (8/8 → oslavný moment, který projekt jinde slibuje — konfety, dotočení prstenu), žádný loading/uložení feedback.",
      "KOMPAKTNOST: sheet je poloprázdný — hodně místa, málo obsahu; velké číslo je fajn, ale chybí kontext (kolik zbývá do cíle, dnešní série)."
    ],
    "opravy": [
      "Sjednotit jednotku s definicí návyku (jednotka+cíl z tvorby). Titulek dynamicky: 'Pít vodu' + pod ním '6 / 8 sklenic'.",
      "Nahradit nativní range vlastním stepperem [–] 6 [+] a pod ním jemný progress k cíli (emeraldový fill). Stepper = přesné + rychlé na mobilu; případně ponechat i tažení, ale s custom stylem a značkami.",
      "Přidat prominentní '＋1 sklenice' jako primární rychlou akci a sekundární 'Uložit'. Umožnit zavření (tap na dim / handle / 'Zrušit').",
      "Přidat oslavný stav při 8/8 (mikroanimace + haptika) — konzistence se slíbeným odměnovým momentem.",
      "Doplnit malý kontext: 'Zbývá 2' nebo 'Dnešní cíl splněn 🔥' po dosažení."
    ]
  },
  {
    "nazev": "statistiky — tab Návyky › Statistiky (roční mřížky)",
    "verdikt": "needs-work",
    "problemy": [
      "FUNKČNĚ CHYBÍ souhrn: žádné agregované statistiky nahoře (nejlepší série, celková úspěšnost %, aktivních dní) — přitom dnešní tab i sekce 'Já'/'Parta' souhrnné dlaždice (.stat2/.sgrid) běžně mají. Habit-statistika bez čísel úspěšnosti je nekompletní.",
      "NEJASNOST mřížky: chybí legenda/vysvětlení co znamená vybarvený čtvereček (den splněno? intenzita u měřitelných?) a jaká je časová osa. Na jiné mřížce v appce (rok party) legenda '1 čtvereček = 1 týden' JE — tady chybí → nekonzistence.",
      "PŘEPÍNAČ Týden/Měsíc/Rok bez efektu: mřížka vypadá pořád jako roční ('98×' za rok), přepnutí na Týden/Měsíc by mělo měnit granularitu i čísla. Momentálně jsou to jen tři neaktivní taby → uživatel čeká změnu, která nepřijde.",
      "CHYBÍ interakce/detail: klik na konkrétní návyk by měl vést na jeho detail (série, historie, editace, smazání). Statistika je 'slepá ulička' bez prokliku.",
      "CHYBÍ prázdný stav: nový uživatel bez návyků/dat uvidí prázdné mřížky bez vysvětlení ('Zatím žádná data — vytvoř první návyk').",
      "KONZISTENCE počtu návyků: dnešní tab Návyky ukazuje 5 návyků, statistiky jen 3 (Pít vodu/Číst/Spát) — chybí Strečink a Běh; není jasné, zda se ANO/NE i měřitelné návyky zobrazují stejně."
    ],
    "opravy": [
      "Nad mřížky přidat pás souhrnu (.stat2 styl): 'nejdelší série', 'úspěšnost %', 'aktivních dní' — sjednotit s ostatními taby.",
      "Přidat legendu pod mřížky (jako u rokparty): 'tmavší = splněno / vyšší hodnota', popsat osu času; u měřitelných rozlišit intenzitu odstínem.",
      "Zprovoznit Týden/Měsíc/Rok: měnit granularitu buněk a přepočítat čísla (např. '× za týden'), jinak přepínač odstranit.",
      "Každý řádek návyku udělat klikatelný → detail návyku (série, historie zápisů, upravit, smazat). Tím vznikne chybějící 'návyk detail' obrazovka.",
      "Doplnit prázdný stav a sladit seznam se všemi návyky z tabu Dnes (5, ne 3), včetně týdenních ('Běh 3× týdně')."
    ]
  },
  {
    "nazev": "profil (karta hráče)",
    "verdikt": "needs-work",
    "problemy": [
      "Duplicita jména: nav titul 'Martin' + hned pod ním pcard znovu 'Martin'. Zabírá místo, nic nepřidává.",
      "Nekonzistence datové sady: horní 'Statistiky' ukazují max shyby/dřep/kliky/boulder, ale rozpad ve žlutém info řádku je 'Shyby 2 340 · Dřep 1 210 · Kliky 5 680 · Dipy 890' — objeví se Dipy, které nikde jinde v appce nejsou (ani v maximálkách, ani ve formuláři cviku jsou jen Shyby/Kliky/Dřep). Buď doplnit Dipy všude, nebo je odsud vyhodit.",
      "Chybí interakce směrem k ostatním: u cizího profilu není žádná akce typu 'porovnat se mnou', reakce/pošťouchnutí (na Dnešek/Partě reakce 💪🔥👏 jsou, tady kontext mizí). Profil působí jen jako read-only zeď čísel.",
      "'✏️ Upravit' + '🕓 Historie úprav' na CIZÍM profilu (Martin) vyvolává otázku práv — proč můžu editovat cizí rekordy? Buď to skrýt pro cizí profil a nechat jen na 'Já', nebo jasně označit admin-only.",
      "Chybí prázdný stav: nový/neaktivní hráč bez rekordů a bez série — všechny dlaždice by zely 0 / '—' bez vysvětlení.",
      "'2. místo' v pcard — není jasné za jaké období (týden? celkem?). Na Partě se místo řídí přepínačem období; tady je fixně bez kontextu.",
      "Nav avatar vpravo je 'MÁ' (moje) i na cizím profilu — spolu s '＋' to mate: jsem na Martinově profilu, ale nahoře svítí moje iniciály a přidávací tlačítko."
    ],
    "opravy": [
      "Zrušit duplicitu: buď nechat velkou pcard bez nav-titulu, nebo nav-titul se jménem + drobnější pcard bez opakování jména (jen avatar + metariky).",
      "Sjednotit sadu cviků: rozpad 'Za celou dobu' udělat ze stejných disciplín jako maximálky (Shyby/Dřep/Kliky/Boulder), nebo přidat Dipy i do maximálek a formuláře.",
      "Přidat u cizího profilu lehký akční řádek: '⚡ Porovnat se mnou' + rychlá reakce; edit/historii schovat jen pro vlastní profil / admina.",
      "Do pcard doplnit u '2. místo' období ('2. z 7 · celkem') ať je jednoznačné.",
      "Na cizím profilu nezobrazovat můj avatar a '＋' vpravo nahoře; místo toho zpět/šipka nebo prázdno."
    ]
  },
  {
    "nazev": "rekordy (maximálky všech + rekordy party)",
    "verdikt": "needs-work",
    "problemy": [
      "Tabulka maximálek nemá zvýrazněný MŮJ řádek (Mára). Na všech žebříčcích (Dnešek/Parta) je 'ty' vždy zvýrazněné (.lr.me) — tady konzistence chybí, hůř se hledám.",
      "Chybí jednotky/legenda: 'Dřep 140' bez kg (jinde v appce '120 kg'), 'Boulder V6' bez škály (Font/V). Zelené 'nej' buňky nemají vysvětlení co znamenají (nejlepší v partě).",
      "'Jak se bodují cviky' je jen šedý info box s textem 'Klepni — Wilks, objem, úroveň + příklady.' — nevypadá klikatelně (žádná šipka ›, není to řádek jako ostatní odkazy). Působí jako popisek, ne jako akce.",
      "Sekce 'Rekordy party · nej výkony' míchá metriky bez období/kontextu — 'Nejvíc shybů za den 32' vs 'Nejdelší série 24 dní' vs 'Nejtěžší boulder V7'; chybí datum kdy padl a proklik na ten den/hráče.",
      "Chybí řazení / filtr tabulky (podle disciplíny) a chybí prázdný stav (nikdo ještě nezadal boulder → celý sloupec '—').",
      "Kotva bodů (kg u dřepu) chybí i v 'nej výkony' — nekonzistentní s formulářem, kde váha existuje."
    ],
    "opravy": [
      "Zvýraznit řádek přihlášeného hráče (světle zelené pozadí jako .lr.me) a případně ho ukotvit/nascrollovat.",
      "Doplnit jednotky do hlaviček nebo buněk (Dřep kg, Boulder Font/V) a přidat drobnou legendu 'zeleně = nejlepší v partě'.",
      "'Jak se boduje' přepnout na standardní klikací řádek s ikonou 🧮 a šipkou › (jako na tabu Já), ať je vzhled i afordance konzistentní.",
      "K rekordům party přidat datum + proklik na den/hráče; volitelně malý avatar u jména.",
      "Přidat tap na hlavičku sloupce = seřadit, a definovat prázdný stav buňky ('—')."
    ]
  },
  {
    "nazev": "rokparty (Rok party)",
    "verdikt": "needs-work",
    "problemy": [
      "Přepínač Týden/Měsíc/Rok je nahoře, ale není zřejmé, že přepíná i statistiky a kalendáře pod ním — a nadpisy sekcí jsou natvrdo '· 2026' a 'celý rok', takže při volbě Týden/Měsíc vzniká rozpor (obrazovka se jmenuje 'Rok party', ale má i Týden/Měsíc).",
      "Nesoulad slovník vs. vizuál: caption říká '1 čtvereček = 1 týden', ale prvky se renderují jako tenké svislé PROUŽKY, ne čtverečky. Buď opravit text ('proužek'), nebo změnit tvar na čtverečky (a sjednotit s heatmapou aktivity party na tabu Parta, která má jiný styl buněk).",
      "Graf 'Body v čase' má 5 čar bez legendy (které barvě patří který hráč), bez os, bez hodnot a bez interakce. Jediný popisek je 'silná zelená = ty' — zbylé 4 čáry jsou neidentifikovatelné.",
      "'nejakt. den = Út' je kryptické — bez jednotky/kontextu (nejaktivnější den v týdnu? podle čeho — počet záznamů? bodů?).",
      "'série party 🔥 12' není vysvětlené — co je série PARTY (den, kdy zapsal aspoň někdo? všichni?). Riziko neporozumění.",
      "Chybí prázdný/nízkodatový stav (začátek roku → kalendáře skoro prázdné, graf krátký) a chybí volba metriky grafu (body vs. aktivní dny).",
      "Tab bar zvýrazňuje 2. ikonu (Parta/graf) — ověřit, že 'Rok party' opravdu patří pod Partu a ne pod samostatnou sekci; jinak je zvýraznění matoucí."
    ],
    "opravy": [
      "Nadpisy sekcí navázat na zvolené období (proměnná místo natvrdo '2026'/'celý rok'); zvážit přejmenování obrazovky na neutrální 'Přehled party' když nabízí i Týden/Měsíc.",
      "Sjednotit tvar buněk kalendáře na čtverečky a text captionu s realitou; sladit styl s heatmapou na Partě.",
      "Do grafu přidat legendu barev = hráči (malé tečky se jmény) nebo highlight jen mě + průměr party; přidat popisky os (měsíce, body).",
      "Rozepsat kryptické statistiky: 'nejakt. den' → 'nejaktivnější den · Út (ø 6 záznamů)', a tooltip/podtitul co je 'série party'.",
      "Doplnit prázdný stav a přepínač metriky grafu (Body / Aktivní dny)."
    ]
  },
  {
    "nazev": "den (detail dne hráče – proklik z kalendáře)",
    "verdikt": "needs-work",
    "problemy": [
      "Chybí navigace zpět a kontext — otevře se jako plná obrazovka bez šipky zpět / zavření (dostal jsem se sem klikem na čtvereček, není cesta ven).",
      "Řádky mají editační tužku ✏️ i u CIZÍHO hráče (Martin) — stejný problém s právy jako u profilu; buď skrýt pro cizí den, nebo admin-only.",
      "Chybí typové štítky (cvik/aktivita) které jsou jinde v seznamech (small popisek) — tady je jen 'Kliky 60×' / 'Běh 4 km' bez kategorie, což je nekonzistentní se záznamovými řádky na Dnešek/Parta/Já.",
      "Chybí prázdný stav pro den bez záznamů (kliknu na prázdný/šedý čtvereček → co se ukáže?)."
    ],
    "opravy": [
      "Přidat hlavičku s šipkou zpět / zavřít (nebo řešit jako bottom sheet konzistentně s ostatními detaily).",
      "Editaci (✏️) povolit jen na vlastních záznamech; u cizího dne read-only.",
      "Doplnit typový popisek pod název (cvik/aktivita/…) jako v ostatních seznamech.",
      "Definovat prázdný stav 'Žádný pohyb tento den' pro kliknutí na prázdný čtvereček."
    ]
  },
  {
    "nazev": "zaznamy — „Záznamy\" (celá historie party)",
    "verdikt": "needs-work",
    "problemy": [
      "Chybí prázdný a loading stav: při zvolení filtru (např. Hráč: Tomáš + Typ: Lezení + Období: Týden), který nic nevrátí, není definováno co se zobrazí. U historie to nastane běžně.",
      "Chybí souhrn nad seznamem. Sesterská obrazovka „Moje záznamy\" (historie) má hlavičku „34 záznamů · 1 245 b\" — tady u party ekvivalent úplně chybí, takže při filtrování hráče/typu uživatel nevidí kolik toho je a za kolik bodů. Nekonzistence dvou skoro identických seznamů.",
      "Dny nemají denní součet. Detail dne (den) hlásí „Celkem +92 b\" u každého dne, ale v seznamu Záznamy je den jen textový nadpis bez bodů — nejde porovnat produktivní dny.",
      "Řádky nejsou proklikávací na detail dne. den je v mapě dostupný jen přes „Čtvereček v kalendáři\" v Partě; z tohoto chronologického seznamu se logicky čeká tapnutí na den/řádek, ale žádná afordance (šipka ›, hover) tu není.",
      "Hlavička přes navhdr('Záznamy') nese ＋ (přidat) a avatar MÁ. Na read-only přehledu historie CELÉ party je tlačítko „přidat záznam\" matoucí (přidávám za sebe uprostřed cizí historie?) a chybí návratová šipka zpět do Party.",
      "Filtr-pilulky nemají stav „aktivní/změněný\" ani reset. Když jsou 3 filtry aktivní, vypadají stejně jako výchozí (Všichni/Vše/Týden) — chybí barevné odlišení nastaveného filtru a „Zrušit filtry\". Symbol .cx je jen ▾ (rozbalit), ne × (smazat), přestože název sekce sliboval „×\".",
      "Duplicita s home/parta: úplně stejné řádky (Martin běh 6 km +48, Péťa boulder V6 +95) jsou i na Partě v sekci „Naposledy\". Bez rozdílu v hustotě/informacích působí obrazovka jako pouhé zopakování."
    ],
    "opravy": [
      "Přidat prázdný stav („Pro tento filtr nejsou žádné záznamy\" + tlačítko „Zrušit filtry\") a jednoduchý skeleton při načítání dní.",
      "Přidat souhrnný řádek nad seznam ve stejném stylu jako historie: „N záznamů · X b\", reagující na filtry (např. „12 záznamů · 640 b · tento týden\").",
      "K nadpisu každého dne doplnit denní součet vpravo (např. „Pátek 27. 6. · +178 b\"), sjednotit s obrazovkou den.",
      "Buď udělat den/řádky tapatelné (šipka › na dni → otevře den detail), nebo v mapě jasně říct, že Záznamy jsou plochý read-only feed.",
      "V hlavičce tohoto pod-seznamu nahradit ＋ a avatar zpětnou šipkou (‹ Parta); ＋ patří jen na hlavní taby.",
      "Nastavený filtr vizuálně zvýraznit (zelená pilulka jako .filt b.on) a zobrazit „Zrušit filtry\" jen když je aktivní; sjednotit ikonu ▾ vs × dle skutečné funkce."
    ]
  },
  {
    "nazev": "historie — „Moje záznamy\" (celá historie hráče)",
    "verdikt": "needs-work",
    "problemy": [
      "Chybí prázdný/loading/chybový stav (např. filtr Období: Květen + Typ: Lezení bez záznamů → nedefinováno).",
      "Dny nemají denní součet (na rozdíl od den, kde je „Celkem +92 b\"). U vlastní historie by souhrn na den pomohl.",
      "Řádky nejsou proklikávací na detail dne. den existuje, ale z „Moje záznamy\" na něj nevede cesta — přitom právě odsud dává detail dne největší smysl. Zůstává dostupný jen přes party kalendář.",
      "Editace: tužtička ✏️ u každého řádku otevírá zřejmě editační formulář, ale ten mezi proklikávacími obrazovkami není (na rozdíl od formcvik pro NOVÝ záznam). Chybí i mazání záznamu a potvrzení/undo po smazání.",
      "Souhrn „34 záznamů · 1 245 b\" je vázaný na filtr „Období: Červen\" — není jasné, jestli číslo reaguje na filtr Typ. Chybí i rozpad podle kategorií (kolik cviky/aktivity/strečink/lezení).",
      "Hlavička navhdr('Moje záznamy') nese ＋ a avatar; chybí návratová šipka zpět do „Já\". ＋ tu má smysl (přidávám si vlastní), ale bez „zpět\" se z pod-obrazovky špatně vrací.",
      "Nekonzistence formátu data dne: tady „Dnes · pá 27. 6.\" a „Čtvrtek 26. 6.\", na obrazovce den „středa 25. 6.\", na Partě „Pátek 27. 6.\" — sjednotit velikost písmen dne a formát (Dnes/Včera vs plný název)."
    ],
    "opravy": [
      "Doplnit prázdný stav („Za zvolené období tu nic není\" + reset filtrů) a skeleton při načítání / „Načíst starší\".",
      "K nadpisu dne přidat denní součet vpravo (sjednotit s den) a udělat den tapatelný na detail dne.",
      "Doplnit editační bottom-sheet/obrazovku pro ✏️ (předvyplněný formcvik s hodnotami + „Smazat záznam\" + živý přepočet bodů) a undo toast po smazání.",
      "Souhrn navázat na oba filtry a rozšířit o mini-rozpad kategorií (např. malé pilulky 💪12 · 🏃6 · 🧘4 · 🧗2) nebo řádek pod souhrnem.",
      "V hlavičce doplnit ‹ zpět (do Já); ＋ ponechat.",
      "Sjednotit formát data dne napříč zaznamy/historie/den (Dnes/Včera + „Pátek 27. 6.\", konzistentní velká písmena)."
    ]
  },
  {
    "nazev": "den — detail jednoho dne hráče (Martin · středa 25. 6.)",
    "verdikt": "needs-work",
    "problemy": [
      "Chybí návratová šipka / zavření. Hlavička je jen textová (authh), bez ‹ zpět ani × — u drill-down detailu je návrat povinný, jinak je uživatel zaseknutý.",
      "Řádky ztratily typový podtitul. Na všech ostatních seznamech (zaznamy, historie, parta, ja) má řádek small popisek kategorie („cvik\"/„aktivita\"/„lezení\"). Tady „Kliky 60×\" a „Běh 4 km\" nemají žádný, takže mizí info o typu — nekonzistence a ztráta dat.",
      "Editace bez cíle: ✏️ u řádků nikam nevede (editační obrazovka v prototypu chybí, viz historie). Chybí i smazat/přidat záznam přímo do tohoto dne.",
      "Ikony u řádků jsou nesourodé s kategorií: „Běh 4 km\" (aktivita) má zelený běžecký emoji na zeleném (cvik) pozadí #2FB170 — jinde má běh modré/červené pozadí. Barva pozadí neodpovídá typu záznamu.",
      "Chybí kontext čí den to je vůči přihlášenému. Otevírá se z Party (cizí hráč Martin) — pak by editace ✏️ NEMĚLA být dostupná (edituju cizí záznamy?). Buď skrýt tužtičky u cizího hráče, nebo to není můj den.",
      "Chybí prázdný stav (den bez záznamů) a jakákoli navigace na sousední dny (‹ předchozí / další ›), přestože se sem chodí z kalendáře/heatmapy kde má přeskakování dnů smysl."
    ],
    "opravy": [
      "Přidat hlavičku s ‹ zpět (nebo × zavřít) — ideálně navhdr styl s malým datem jako podnadpis, konzistentní s ostatními.",
      "Vrátit řádkům typový podtitul (small „cvik\"/„aktivita\") a barvu pozadí ikony podle kategorie (aktivita/běh ne na zelené „cvik\" ploše).",
      "Zpřístupnit ✏️ do editačního sheetu (předvyplněno + smazat + přepočet) a doplnit „＋ Přidat záznam do tohoto dne\" — ale jen pro vlastní den.",
      "U cizího hráče skrýt tužtičky (read-only) a případně zobrazit jen prohlížení; u vlastního povolit editaci.",
      "Přidat prázdný stav dne a volitelně navigaci ‹ / › mezi dny, protože vstup je z heatmapy/kalendáře.",
      "Zvážit zobrazení denní série/rekordu (např. „🔥 den v řadě\" nebo „nový rekord\") pro konzistenci s odměnovým jazykem appky."
    ]
  },
  {
    "nazev": "login — Přihlášení",
    "verdikt": "needs-work",
    "problemy": [
      "Chybí interaktivní stavy pro prototyp: žádný focus na poli, žádný chybový stav (špatné heslo / neexistující e-mail), žádný loading/disabled stav tlačítka 'Přihlásit se' po odeslání. U auth obrazovky je chybový stav klíčový — bez něj se nedá posoudit reálné tření.",
      "Slabá hierarchie dvou spodních odkazů: 'Nemáš účet? Zaregistrovat se' (zelené tučné) a 'Zapomněl(a) jsi heslo?' (šedé) jsou opticky skoro stejně velké a stojí těsně nad sebou → dvě konkurenční akce bez jasné priority. Zelená tučná registrace navíc opticky přebíjí i to, že primární akce je přihlášení.",
      "Oko u hesla (👁) je zarovnané tabulátory/mezerami ('Heslo  …👁') místo skutečného pravého zarovnání ve fieldu — na jiné šířce/lokalizaci to rozjede. Není vizuálně zřejmé, že jde o klikací toggle.",
      "Chybí volba 'zůstat přihlášený' / persistence session — u party appky, kam lidi chodí denně z mobilu, je opětovné logování velké tření (funkčně chybí oproti reálné appce).",
      "Podnadpis 'Přihlas se e-mailem a heslem' je redundantní k nadpisu 'Přihlášení' a k polím — nenese žádnou novou informaci (zbytečný řádek, dá se využít líp).",
      "Není jasné, co se stane po 'Zaregistrovat se' — v tomto onboardingu je registrace přímo napojená na claim profilu (párovací kód), ale login to nenaznačuje; hrozí, že nový hráč nepochopí tok."
    ],
    "opravy": [
      "Doplnit do prototypu aspoň 2 varianty stavu: (a) chybový (červený rámeček pole + krátká hláška pod polem, např. 'Nesprávný e-mail nebo heslo'), (b) odesílání (tlačítko disabled + spinner/'Přihlašuji…'). Konzistentně použít --green pro fokus rámeček polí.",
      "Snížit prioritu registrace: primární je Přihlásit se. 'Zapomněl(a) jsi heslo?' dát jako drobný odkaz hned pod pole hesla (vpravo), a 'Nemáš účet? Zaregistrovat se' nechat dole jako jediný sekundární odkaz — ať spolu dvě zelené akce nesoupeří.",
      "Řešit oko jako ikonu absolutně pozicovanou vpravo ve fieldu (ne mezerami), s viditelným toggle stavem (přeškrtnuté/plné oko).",
      "Přidat volbu 'Zůstat přihlášen(a)' (default zapnuto) nebo aspoň v poznámce potvrdit, že session drží dlouho.",
      "Podnadpis buď zrušit, nebo nahradit užitečnou informací (např. 'Přihlaš se do party Movement Challenge').",
      "Doladit tok registrace: buď 'Zaregistrovat se' → rovnou claim/párovací kód, nebo krátce naznačit ('účet dostaneš od správce party')."
    ]
  },
  {
    "nazev": "claim — Vyber profil",
    "verdikt": "needs-work",
    "problemy": [
      "NEŠKÁLUJE na cíl 9–10 lidí: profily jsou inline chipy (Mára / Péťa / Martin) vycentrované v jednom řádku. U 7→10 hráčů se to zalomí do neuspořádaného bloku a bude to vypadat lacině. Navíc 'Který hráč jsi?' ukazuje jen 3 z party — chybí zbytek nebo scroll/mřížka.",
      "NEKONZISTENCE s celou appkou: všude jinde má hráč barevný avatar-kolečko s iniciálami (lc/lr .lav, .pcard .pav, .frow .fav). Tady jsou hráči jen textové pilulky bez avataru → nevypadá to jako 'výběr osoby' a tříští to vizuální jazyk systému.",
      "Zadání zdvojuje mentální model na jedné obrazovce (vyber dlaždici + napiš kód) bez vysvětlení vztahu: uživatel neví, proč musí obojí, ani odkud párovací kód vezme. Chybí mikrocopy typu 'Kód dostaneš od správce party' / 'Kód máš v pozvánce'.",
      "Chybí klíčové stavy prototypu: chybový stav při špatném kódu, stav 'tento profil už si někdo zabral' (u sdílené party zásadní edge-case), a stav 'můj profil tu není / jsem nový' (úniková cesta).",
      "Podnadpis 'Zadej párovací kód' je nadbytečný, protože placeholder v poli říká totéž ('Párovací kód') — dva stejné texty nad sebou (kompaktnost).",
      "Není zřejmé, zda je předvybraný 'Mára' záměr (zelený = vybraný) nebo default — u výběru vlastní identity je nebezpečné mít někoho předvybraného (riziko omylem potvrdit cizí profil).",
      "Chybí návaznost/zpět: z 'Vyber profil' není cesta zpět na login ani indikace, že jsem přihlášen jako nový účet, který se teď páruje."
    ],
    "opravy": [
      "Předělat výběr hráče na svislý seznam nebo 2sloupcovou mřížku karet s AVATAREM (kolečko s iniciálami + barva, stejně jako .lav/.pav v systému) → konzistentní, škáluje na 10 lidí, vypadá jako 'vyber osobu'. Zvolený stav = zelený rámeček/haléček na avataru, ne plná zelená pilulka.",
      "Nepředvybírat žádný profil (žádné .on defaultně); tlačítko 'Potvrdit a vstoupit' nechat disabled, dokud není vybraný profil A vyplněný kód → jasné, bezpečné, minimální tření.",
      "Zrušit duplicitní podnadpis 'Zadej párovací kód' (placeholder stačí) a místo něj dát vysvětlující mikrocopy odkud kód je: 'Párovací kód ti dá správce party.'",
      "Doplnit do prototypu chybový stav kódu (červená hláška 'Kód nesedí k tomuto profilu') a stav zabraného profilu (šedá dlaždice + štítek 'už obsazeno').",
      "Přidat úníkovou cestu dole: odkaz 'Nejsem tu / jsem nový hráč' nebo 'Poprosit správce o profil' + odkaz 'Zpět na přihlášení'.",
      "Zvážit, zda vůbec potřeba dvoukrokově (dlaždice + kód): pokud kód jednoznačně identifikuje hráče, stačil by jen kód a profil se dopočítá — méně tření. Když dlaždice zůstane, jasně komunikovat 'vyber sebe → potvrď kódem'."
    ]
  },
  {
    "nazev": "uprava — „Úprava profilu\"",
    "verdikt": "needs-work",
    "problemy": [
      "Chybí zásadní pole oproti reálné appce: JMÉNO a AVATAR/BARVA. Přitom karta profilu v tabu „Já\" (S.ja) i karty hráčů (S.profil) jméno i barevný monogram zobrazují — nejde je zde změnit, takže obrazovka neumí to, co profil evidentně má.",
      "Chybí „Max kliky\". Appka kliky sleduje všude jinde jako maximálku (S.profil: „110 max kliky\", S.rekordy sloupec „Kliky\") — v editaci maxim ale kliky nejsou, takže sadu maxim nelze udržet kompletní. Nekonzistence datového modelu.",
      "Chybí admin volby zmíněné v zadání (správa hráčů / párovací kódy / role). Pro partu 7→10 lidí je to reálná funkce, tady úplně chybí a není jasné, kde jinde by byla.",
      "Pole nejsou skutečné inputy — jsou to statické .inp divy bez viditelného typu klávesnice/jednotky jako editovatelného prvku. U „Max boulder V6 (Font)\" navíc není jasné, jak se mění stupnice (Font vs V) — vypadá to jako text, ne jako výběr. Tření: uživatel neví, co je klikací.",
      "Žádné rozlišení „osobní míry“ (váha/výška – privátní) vs „maximálky“ (ovlivňují body a jsou veřejné v rekordech). Uživatel netuší, že změna maxim mu přepočítá bodování — chybí mikrocopy/upozornění.",
      "Chybí stavy: žádný disabled/aktivní stav tlačítka „Uložit změny\" (kdy je co změněno), žádné potvrzení po uložení, žádný validační/chybový stav (např. záporná/nesmyslná hodnota), žádný loading.",
      "Chybí navigace zpět/zavřít — obrazovka má jen levý nadpis, žádný back/×. (Platí i pro ostatní sub-formuláře, ale u editace, ze které se dá „utéct“ bez uložení, chybí i ochrana proti ztrátě změn.)"
    ],
    "opravy": [
      "Přidat nahoru sekci identity: pole Jméno (text input) + volba Avatar/Barva (řada barevných koleček .colors, přesně jak v S.tvorba u návyků — drží konzistenci) s živým náhledem monogramu.",
      "Doplnit „Max kliky\" do mřížky maxim, aby seděla se S.profil/S.rekordy (shyby, dřep, kliky, boulder). Uspořádat maximálky do jedné vizuální skupiny s nadpisem „Maximálky (ovlivňují body)\".",
      "Rozdělit formulář do 2 sekcí přes .sl oddělovače: „Míry\" (váha/výška) a „Maximálky\" — a k maximálkám přidat jednořádkové mikrocopy .info: „Podle maxim se přepočítá tvoje bodování.\"",
      "U „Max boulder\" udělat z Font/V přepínač (segment .seg nebo .pickrow, stejně jako u S.formlez „Boulder/Lano\") místo textu, ať je zřejmé, že jde o volbu stupnice.",
      "Přidat viditelně editovatelný vzhled polí + jednotky jako suffix v inputu; tlačítko „Uložit změny\" zšednout, dokud není změna, a po uložení ukázat krátké potvrzení (toast/haptika — konzistentní s odměnovým momentem).",
      "Přidat back/zavřít (šipka vlevo v hlavičce) a dialog „Zahodit neuložené změny?\" při odchodu.",
      "Admin: pokud je uživatel správce, přidat na konec sekci „Správa party\" (odkaz na hráče, párovací kódy) — nebo explicitně přesunout jinam a tady jen odkaz, ať zadání sedí."
    ]
  },
  {
    "nazev": "bodovani — „Jak se boduje\"",
    "verdikt": "needs-work",
    "problemy": [
      "Chybí kategorie LEZENÍ. Appka má 4 typy zápisu (Cvik/Aktivita/Strečink/Lezení — viz S.addsheet a pickery ve formulářích) a lezení dává nejvíc bodů (S.parta: boulder V6 = +95). Tady jsou jen Cviky/Aktivity/Strečink/Série — lezení, největší bodová položka, úplně chybí. To je věcná díra a nekonzistence se systémem.",
      "„Série\" je zamíchaná mezi typy zápisu, ačkoli to není kategorie zápisu, ale bonusový mechanismus. Míchá dvě různé věci do jednoho seznamu — mírně matoucí hierarchie.",
      "Vysvětlení je velmi vágní a nedává skutečnou představu: „dle úrovně 1–5\", „20/40 b\", „za dny v řadě roste bonus\" — bez tabulky/příkladů si uživatel body nedopočítá. Přitom S.rekordy slibuje „Klepni — Wilks, objem, úroveň + příklady\", takže očekávání je nastaveno výš, než tato obrazovka plní. Nekonzistence očekávání.",
      "Čtyři skoro identické .info karty působí monotónně a nejsou samovysvětlující na první pohled — chybí ikona/nadpis kategorie a barevné odlišení, které appka jinde běžně používá (barvy typů: Cvik zelená, Aktivita modrá, Strečink oranžová, Lezení fialová).",
      "Žádný odkaz na hlubší detail/příklady ani vazba zpět na formulář zápisu (kde se body počítají „živě\") — informace je slepá ulička.",
      "Trailing </div> navíc v šabloně (řetězec končí ...roste bonus.</div></div> — jeden div přebývá vůči otevřeným), drobný, ale reálný bug v markupu."
    ],
    "opravy": [
      "Přidat 5. kartu LEZENÍ (boulder/lano, dle obtížnosti) — a obecně srovnat set kategorií 1:1 s typy zápisu v S.addsheet, ať to sedí.",
      "Oddělit „Série 🔥\" od kategorií: dát ji pod vlastní pod-nadpis .sl „Bonusy\" nebo jako odlišenou kartu, aby bylo jasné, že to není typ zápisu.",
      "Do každé karty přidat ikonu + barvu kategorie (stejná paleta jako .fav/.addt) a jeden konkrétní číselný příklad (např. „Kliky 50× při maxu 100 → +35 b\", „Běh 5 km → +48 b\", „Boulder V6 → +95 b\") — čísla vzít z reálných příkladů, které už v prototypu jsou.",
      "Zvážit rozbalovací detail (Wilks/objem/úroveň), aby obrazovka splnila slib z S.rekordy; minimálně přidat řádek „Body vidíš živě při zápisu\" jako vazbu na formulář.",
      "Opravit přebývající </div> na konci šablony S.bodovani."
    ]
  }
]
```

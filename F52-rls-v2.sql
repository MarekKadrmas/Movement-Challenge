-- Fáze 0 / M3 — RLS v2 (OPRAVA prvního běhu)
-- Problém: původní tabulky (players, cviky, aktivity, player_history, chat_messages, chat_reactions)
-- měly STARÉ povolovací politiky, které se s novými OR-ují → anon pořád četl i zapisoval.
-- Tahle v2 SMAŽE VŠECHNY existující politiky na našich tabulkách a vytvoří jen ty správné.
-- Bezpečné spustit i opakovaně. NEJDŘÍV TEST, PROD až na pokyn.

-- 1) Pomocné funkce (idempotentní). SECURITY DEFINER → obchází RLS uvnitř (žádná rekurze).
create or replace function public.current_player_id()
returns uuid language sql stable security definer set search_path = public, pg_temp as $$
  select id from public.players where auth_user_id = auth.uid()
$$;

create or replace function public.current_is_admin()
returns boolean language sql stable security definer set search_path = public, pg_temp as $$
  select coalesce((select is_admin from public.players where auth_user_id = auth.uid()), false)
$$;

-- 2) Smaž VŠECHNY existující politiky na našich tabulkách (ať nezůstane žádná stará povolovací).
do $$
declare r record;
begin
  for r in
    select policyname, tablename from pg_policies
    where schemaname = 'public'
      and tablename = any(array['players','cviky','aktivity','player_history','chat_messages','chat_reactions','habits','habit_logs'])
  loop
    execute format('drop policy if exists %I on public.%I;', r.policyname, r.tablename);
  end loop;
end $$;

-- 3) Datové tabulky: zapni RLS + správné politiky (čtení přihlášený, zápis jen vlastní/admin).
do $$
declare t text;
begin
  foreach t in array array['cviky','aktivity','player_history','chat_messages','chat_reactions','habits','habit_logs']
  loop
    execute format('alter table public.%I enable row level security;', t);
    execute format('create policy %I on public.%I for select to authenticated using (true);', t||'_sel', t);
    execute format('create policy %I on public.%I for insert to authenticated with check (player_id = public.current_player_id() or public.current_is_admin());', t||'_ins', t);
    execute format('create policy %I on public.%I for update to authenticated using (player_id = public.current_player_id() or public.current_is_admin()) with check (player_id = public.current_player_id() or public.current_is_admin());', t||'_upd', t);
    execute format('create policy %I on public.%I for delete to authenticated using (player_id = public.current_player_id() or public.current_is_admin());', t||'_del', t);
  end loop;
end $$;

-- 4) players: čtení přihlášený; úprava jen svého profilu/admin; CLAIM volného profilu na sebe (jen když sám profil nemá); insert/delete jen admin.
alter table public.players enable row level security;

create policy players_sel on public.players for select to authenticated using (true);

create policy players_upd on public.players for update to authenticated
  using (
    id = public.current_player_id()
    or public.current_is_admin()
    or (auth_user_id is null and public.current_player_id() is null)
  )
  with check (
    id = public.current_player_id()
    or public.current_is_admin()
    or auth_user_id = auth.uid()
  );

create policy players_ins on public.players for insert to authenticated with check (public.current_is_admin());
create policy players_del on public.players for delete to authenticated using (public.current_is_admin());

-- 5) KONTROLA (poslední SELECT se ukáže ve výsledku — pošli mi ho):
select tablename, cmd, policyname, roles
from pg_policies
where schemaname = 'public'
  and tablename = any(array['players','cviky','aktivity','player_history','chat_messages','chat_reactions','habits','habit_logs'])
order by tablename, cmd;


-- ============================================================================
-- ROLLBACK (vypne RLS na všech tabulkách):
-- do $$ declare t text; begin
--   foreach t in array array['players','cviky','aktivity','player_history','chat_messages','chat_reactions','habits','habit_logs']
--   loop execute format('alter table public.%I disable row level security;', t); end loop;
-- end $$;

-- Fáze 0 / M3 — Row Level Security (RLS)
-- Model: PŘIHLÁŠENÝ vidí vše (sdílená výzva mezi hráči). ZAPISOVAT smí jen SVOJE řádky
--        (player_id = můj profil), ADMIN smí vše. ANONYMNÍ (nepřihlášený) = nic (vyžadujeme login).
-- Vlastnictví řádku: players.auth_user_id = auth.uid().
-- Spustit v Supabase SQL editoru: NEJDŘÍV TEST (po záloze!). PROD až na výslovný pokyn.

-- 1) Pomocné funkce. SECURITY DEFINER → uvnitř obcházejí RLS, takže nehrozí rekurze v politikách nad players.
create or replace function public.current_player_id()
returns uuid language sql stable security definer set search_path = public, pg_temp as $$
  select id from public.players where auth_user_id = auth.uid()
$$;

create or replace function public.current_is_admin()
returns boolean language sql stable security definer set search_path = public, pg_temp as $$
  select coalesce((select is_admin from public.players where auth_user_id = auth.uid()), false)
$$;

-- 2) Datové tabulky: čtení pro přihlášené, zápis jen vlastních řádků (nebo admin).
do $$
declare t text;
begin
  foreach t in array array['cviky','aktivity','player_history','chat_messages','chat_reactions','habits','habit_logs']
  loop
    execute format('alter table public.%I enable row level security;', t);
    execute format('drop policy if exists %I on public.%I;', t||'_sel', t);
    execute format('create policy %I on public.%I for select to authenticated using (true);', t||'_sel', t);
    execute format('drop policy if exists %I on public.%I;', t||'_ins', t);
    execute format('create policy %I on public.%I for insert to authenticated with check (player_id = public.current_player_id() or public.current_is_admin());', t||'_ins', t);
    execute format('drop policy if exists %I on public.%I;', t||'_upd', t);
    execute format('create policy %I on public.%I for update to authenticated using (player_id = public.current_player_id() or public.current_is_admin()) with check (player_id = public.current_player_id() or public.current_is_admin());', t||'_upd', t);
    execute format('drop policy if exists %I on public.%I;', t||'_del', t);
    execute format('create policy %I on public.%I for delete to authenticated using (player_id = public.current_player_id() or public.current_is_admin());', t||'_del', t);
  end loop;
end $$;

-- 3) players: čtení pro přihlášené; úprava jen svého profilu (nebo admin);
--    CLAIM = přihlášený si smí přiřadit VOLNÝ profil (auth_user_id IS NULL) na sebe, jen pokud sám ještě profil nemá;
--    insert/delete jen admin.
alter table public.players enable row level security;

drop policy if exists players_sel on public.players;
create policy players_sel on public.players for select to authenticated using (true);

drop policy if exists players_upd on public.players;
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

drop policy if exists players_ins on public.players;
create policy players_ins on public.players for insert to authenticated with check (public.current_is_admin());

drop policy if exists players_del on public.players;
create policy players_del on public.players for delete to authenticated using (public.current_is_admin());

-- Kontrola (mělo by vrátit rowsecurity = true u všech):
-- SELECT relname, relrowsecurity FROM pg_class
-- WHERE relname IN ('players','cviky','aktivity','player_history','chat_messages','chat_reactions','habits','habit_logs');


-- ============================================================================
-- ROLLBACK (kdyby appka po zapnutí zlobila) — vypne RLS na všech tabulkách:
-- ============================================================================
-- do $$ declare t text; begin
--   foreach t in array array['players','cviky','aktivity','player_history','chat_messages','chat_reactions','habits','habit_logs']
--   loop execute format('alter table public.%I disable row level security;', t); end loop;
-- end $$;

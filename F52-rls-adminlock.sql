-- Fáze 0 / M3 — zámek na is_admin (uzavření díry: povýšení sebe sama na admina)
-- Bez tohoto si přihlášený uživatel může na SVÉM profilu nastavit is_admin=true a stát se adminem.
-- Trigger: změnit is_admin smí jen ten, kdo UŽ adminem JE (current_is_admin()).
-- Spustit v Supabase SQL editoru: NEJDŘÍV TEST, PROD až na pokyn. Bezpečné spustit opakovaně.

create or replace function public.guard_player_admin()
returns trigger language plpgsql security definer set search_path = public, pg_temp as $$
begin
  if new.is_admin is distinct from old.is_admin and not public.current_is_admin() then
    raise exception 'Only an admin can change is_admin';
  end if;
  return new;
end $$;

drop trigger if exists players_guard_admin on public.players;
create trigger players_guard_admin
  before update on public.players
  for each row execute function public.guard_player_admin();

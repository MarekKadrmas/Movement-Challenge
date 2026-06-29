-- Fáze 0 / M3 — RLS HARDENING (SQL-only nálezy z auditu)
-- Pokrývá: C1 (is_admin lock) + H3 (claim/odpojení vazby) + M1 (aktivni) + M2 (audit log actor)
--          + M4 (unique auth_user_id + LIMIT 1) + M6/L5 (limity hodnot) + L1/L2 (created_at/datum).
-- NAHRAZUJE F52-rls-adminlock.sql (obsahuje širší guard trigger). Bezpečné spustit i opakovaně.
-- NEJDŘÍV TEST, PROD až na výslovný pokyn. Rollback dole.

-- 1) M4: jeden účet = max jeden profil + LIMIT 1 v pomocné funkci
create unique index if not exists players_auth_user_id_uniq
  on public.players (auth_user_id) where auth_user_id is not null;

create or replace function public.current_player_id()
returns uuid language sql stable security definer set search_path = public, pg_temp as $$
  select id from public.players where auth_user_id = auth.uid() limit 1
$$;

-- 2) C1 + H3 + M1: guard na profilu. Non-admin nesmí měnit is_admin, aktivni ani vazbu účtu
--    (auth_user_id smí jen při claimu volného profilu na SEBE: null -> auth.uid()).
create or replace function public.guard_player_protected()
returns trigger language plpgsql security definer set search_path = public, pg_temp as $$
begin
  -- Důvěryhodný backend (SQL konzole / service_role = auth.uid() IS NULL) nebo admin smí vše.
  -- Anonymní API uživatel se sem nedostane (RLS players_upd je jen to authenticated).
  if auth.uid() is null or public.current_is_admin() then
    return new;
  end if;
  if new.is_admin is distinct from old.is_admin then
    raise exception 'Změnu is_admin smí provést jen admin';
  end if;
  if new.aktivni is distinct from old.aktivni then
    raise exception 'Změnu aktivni smí provést jen admin';
  end if;
  if new.auth_user_id is distinct from old.auth_user_id
     and not (old.auth_user_id is null and new.auth_user_id = auth.uid()) then
    raise exception 'Vazbu účtu (auth_user_id) nelze měnit';
  end if;
  return new;
end $$;
drop trigger if exists players_guard_admin on public.players;  -- starší užší verze (adminlock)
drop trigger if exists players_guard on public.players;
create trigger players_guard
  before update on public.players
  for each row execute function public.guard_player_protected();

-- 3) M2: audit log — KDO změnu provedl vždy dosadí databáze (proti falšování)
create or replace function public.force_history_actor()
returns trigger language plpgsql security definer set search_path = public, pg_temp as $$
begin
  new.changed_by_player_id := public.current_player_id();
  return new;
end $$;
drop trigger if exists player_history_actor on public.player_history;
create trigger player_history_actor
  before insert on public.player_history
  for each row execute function public.force_history_actor();

-- 4) L1 + L2: created_at je vždy serverový čas (na update neměnné), datum nesmí být v budoucnu
create or replace function public.guard_entry_dates()
returns trigger language plpgsql security definer set search_path = public, pg_temp as $$
begin
  if tg_op = 'INSERT' then
    new.created_at := now();
  else
    new.created_at := old.created_at;
  end if;
  if new.datum is not null and new.datum > current_date then
    raise exception 'Datum nesmí být v budoucnosti';
  end if;
  return new;
end $$;
drop trigger if exists cviky_dates on public.cviky;
create trigger cviky_dates before insert or update on public.cviky
  for each row execute function public.guard_entry_dates();
drop trigger if exists aktivity_dates on public.aktivity;
create trigger aktivity_dates before insert or update on public.aktivity
  for each row execute function public.guard_entry_dates();
drop trigger if exists habit_logs_dates on public.habit_logs;
create trigger habit_logs_dates before insert or update on public.habit_logs
  for each row execute function public.guard_entry_dates();

-- 5) M6 + L5: rozumné limity hodnot (proti záporným/extrémním číslům přes přímé API).
--    Volné meze, aby prošla existující data; tvrdou anti-cheat ochranu skóre řeší serverový přepočet bodů (H2, samostatně).
alter table public.cviky drop constraint if exists cviky_sane;
alter table public.cviky add constraint cviky_sane check (
  (opakovani   is null or (opakovani   >= 0 and opakovani   <= 100000)) and
  (pridana_vaha is null or (pridana_vaha >= 0 and pridana_vaha <= 1000)) and
  (body        is null or (body        >= 0 and body        <= 100000))
);
alter table public.aktivity drop constraint if exists aktivity_sane;
alter table public.aktivity add constraint aktivity_sane check (
  (km     is null or (km     >= 0 and km     <= 5000)) and
  (body   is null or (body   >= 0 and body   <= 100000)) and
  (uroven is null or (uroven between 0 and 10))
);

-- 6) KONTROLA (poslední SELECT se ukáže ve výsledku — pošli mi ho):
select tgname, tgrelid::regclass as tabulka
from pg_trigger
where not tgisinternal
  and tgrelid::regclass::text in ('players','player_history','cviky','aktivity','habit_logs')
order by tabulka, tgname;


-- ============================================================================
-- ROLLBACK (kdyby něco zlobilo):
-- drop trigger if exists players_guard on public.players;
-- drop trigger if exists player_history_actor on public.player_history;
-- drop trigger if exists cviky_dates on public.cviky;
-- drop trigger if exists aktivity_dates on public.aktivity;
-- drop trigger if exists habit_logs_dates on public.habit_logs;
-- alter table public.cviky drop constraint if exists cviky_sane;
-- alter table public.aktivity drop constraint if exists aktivity_sane;

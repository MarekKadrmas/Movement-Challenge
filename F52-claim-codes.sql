-- Fáze 0 / M3 — H4: claim profilu na párovací kód
-- Cíl: aby si profil kamaráda nemohl zabrat cizí. Claim půjde JEN přes funkci, která ověří
-- tajný kód; přímý PATCH claim se zakáže. Kód je tajný (NEčte se přes API, není v grantu sloupců).
-- Spustit: NEJDŘÍV TEST, PROD až na pokyn. Bezpečné spustit opakovaně.

-- 1) tajný sloupec s kódem (NEpřidáváme ho do SELECT grantu z H5 → nikdo ho nepřečte přes API)
alter table public.players add column if not exists claim_code text;

-- 2) serverová funkce pro claim: ověří přihlášení, že účet ještě nemá profil, že profil je volný a kód sedí
create or replace function public.claim_profile(p_player_id uuid, p_code text)
returns void language plpgsql security definer set search_path = public, pg_temp as $$
declare v_email text;
begin
  if auth.uid() is null then
    raise exception 'Musíš být přihlášený.';
  end if;
  if public.current_player_id() is not null then
    raise exception 'Tvůj účet už má přiřazený profil.';
  end if;
  if not exists (
    select 1 from public.players
    where id = p_player_id and auth_user_id is null
      and claim_code is not null and claim_code = p_code
  ) then
    raise exception 'Profil není volný nebo je špatný párovací kód.';
  end if;
  select email into v_email from auth.users where id = auth.uid();
  update public.players set auth_user_id = auth.uid(), email = v_email where id = p_player_id;
end $$;
grant execute on function public.claim_profile(uuid, text) to authenticated;

-- 3) zakázat přímý PATCH claim: z players_upd odebrat větev pro volné profily (claim teď jen přes funkci výše)
drop policy if exists players_upd on public.players;
create policy players_upd on public.players for update to authenticated
  using (id = public.current_player_id() or public.current_is_admin())
  with check (id = public.current_player_id() or public.current_is_admin());

-- 4) NASTAV PÁROVACÍ KÓDY (klidně si je změň; každému kamarádovi pošli jen jeho):
update public.players set claim_code = 'mara-7K2Q'    where jmeno = 'Mára';
update public.players set claim_code = 'peta-4R9X'     where jmeno = 'Péťa';
update public.players set claim_code = 'natalka-3M8L'  where jmeno = 'Natálka';
update public.players set claim_code = 'martin-6B1V'   where jmeno = 'Martin';
update public.players set claim_code = 'kata-9T5P'     where jmeno = 'Káťa';
update public.players set claim_code = 'mata-2H7D'     where jmeno = 'Máťa';
update public.players set claim_code = 'lukas-8C4N'    where jmeno = 'Lukáš';

-- KONTROLA (kdo má nastavený kód):
select jmeno, (claim_code is not null) as ma_kod, (auth_user_id is not null) as obsazeny
from public.players order by created_at;


-- ============================================================================
-- ROLLBACK (vrátí přímý claim a zruší kódy):
-- drop policy if exists players_upd on public.players;
-- create policy players_upd on public.players for update to authenticated
--   using (id = public.current_player_id() or public.current_is_admin() or (auth_user_id is null and public.current_player_id() is null))
--   with check (id = public.current_player_id() or public.current_is_admin() or auth_user_id = auth.uid());
-- drop function if exists public.claim_profile(uuid, text);

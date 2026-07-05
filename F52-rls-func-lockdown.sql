-- Fáze 0 / hardening — zámek na SECURITY DEFINER funkce (řeší 13 warningů v Security Advisoru)
-- Problém: naše SECURITY DEFINER funkce jdou spustit i anonymem / veřejností. Není to akutní díra
-- (helpery vrací jen tvoje vlastní id/admin, trigger funkce mimo trigger stejně nefungují), ale je to
-- zbytečná plocha k útoku. Tenhle skript to zamkne:
--   - trigger funkce (návratový typ trigger) → NIKDO je nesmí volat přímo (triggery fungují dál).
--   - ostatní (RLS helpery current_*, RPC claim_profile) → smí jen PŘIHLÁŠENÝ (RLS a claim je potřebují).
-- Idempotentní, bezpečné spustit opakovaně. NEJDŘÍV TEST, PROD až na výslovný pokyn.

do $$
declare f record;
begin
  for f in
    select p.oid,
           p.proname,
           pg_get_function_identity_arguments(p.oid) as args,
           t.typname                                  as rettype
    from pg_proc p
    join pg_namespace n on n.oid = p.pronamespace
    join pg_type t      on t.oid = p.prorettype
    where n.nspname = 'public'
      and p.prosecdef = true                 -- jen SECURITY DEFINER funkce
  loop
    -- 1) odeber spuštění všem (public zahrnuje i anon/authenticated)
    execute format('revoke execute on function public.%I(%s) from public, anon, authenticated;',
                   f.proname, f.args);

    -- 2) trigger funkce (rettype = trigger) necháme BEZ execute — volá je jen trigger, ne uživatel.
    --    Ostatní (helpery pro RLS + RPC) potřebuje přihlášený uživatel → vrať jen jemu.
    if f.rettype <> 'trigger' then
      execute format('grant execute on function public.%I(%s) to authenticated;', f.proname, f.args);
    end if;
  end loop;
end $$;

-- KONTROLA — vypíše SECURITY DEFINER funkce a kdo je smí spustit (pošli mi to):
select p.proname                                   as funkce,
       t.typname                                   as navrat,
       coalesce(
         (select string_agg(a.rolname, ', ')
          from aclexplode(p.proacl) ax
          join pg_roles a on a.oid = ax.grantee
          where ax.privilege_type = 'EXECUTE'),
         '(nikdo / jen owner)')                    as smi_spustit
from pg_proc p
join pg_namespace n on n.oid = p.pronamespace
join pg_type t      on t.oid = p.prorettype
where n.nspname = 'public' and p.prosecdef = true
order by p.proname;

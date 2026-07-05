-- DIAGNOSTIKA RLS — vypíše VŠECHNY tabulky v public schématu: má zapnuté RLS? kolik má politik?
-- Spustit v Supabase SQL editoru na TEST projektu (dslutpijlwmyftztyfva). POUZE ČTE, nic nemění.
-- Řádky s rls_zapnuto = false  →  přesně ty tabulky, na které Supabase křičí.

select
  c.relname                                                                          as tabulka,
  c.relrowsecurity                                                                   as rls_zapnuto,
  (select count(*) from pg_policies p where p.schemaname = 'public' and p.tablename = c.relname) as pocet_politik
from pg_class c
join pg_namespace n on n.oid = c.relnamespace
where n.nspname = 'public'
  and c.relkind = 'r'          -- jen běžné tabulky
order by c.relrowsecurity asc, c.relname;   -- nechráněné (false) nahoře

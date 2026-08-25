-- Nahrazení návyku (NAVYKY-NAVRH.md §13)
-- Spustit v Supabase SQL editoru. NEJDŘÍV na TEST projektu, po záloze. PROD až po odsouhlasení.
--
-- Princip: když v pondělí přečtu jen 10 z 20 minut a ve středu přečtu 40, můžu chybějící
-- pondělní část dohnat ze středečního přebytku. Do logu se zapíše, KOLIK bylo nahrazeno —
-- `hodnota` zůstává tím, co jsem ten den reálně udělal, takže se přebytek nedá utratit dvakrát.

-- 1) Kolik jednotek daného dne pochází z nahrazení (0 = běžně splněno)
ALTER TABLE habit_logs
  ADD COLUMN IF NOT EXISTS nahrazeno numeric NOT NULL DEFAULT 0;

-- 2) Nahradit nejde záporně
ALTER TABLE habit_logs
  DROP CONSTRAINT IF EXISTS habit_logs_nahrazeno_nezaporne;
ALTER TABLE habit_logs
  ADD CONSTRAINT habit_logs_nahrazeno_nezaporne CHECK (nahrazeno >= 0);

-- 3) Kontrola po spuštění — musí vrátit sloupec `nahrazeno`, typ numeric, default 0
SELECT column_name, data_type, column_default, is_nullable
FROM information_schema.columns
WHERE table_name = 'habit_logs' AND column_name = 'nahrazeno';

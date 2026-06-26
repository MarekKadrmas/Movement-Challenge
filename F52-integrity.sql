-- Fáze 0 / Krok 1: datová integrita (bezpečné, nezávisí na přihlášení)
-- Spustit v Supabase SQL editoru. NEJDŘÍV na TEST projektu, po záloze. PROD až po odsouhlasení.

-- 1) Odstranit případné duplicitní denní logy (dvojklik / souběh ze dvou zařízení) — nechat nejnovější (nejvyšší id)
DELETE FROM habit_logs a
USING habit_logs b
WHERE a.habit_id = b.habit_id
  AND a.player_id = b.player_id
  AND a.datum = b.datum
  AND a.id < b.id;

-- 2) Unikátní index: maximálně 1 log na (návyk, hráč, den)
CREATE UNIQUE INDEX IF NOT EXISTS habit_logs_unique_day
  ON habit_logs (habit_id, player_id, datum);

-- 3) Konzervativní kontrola: hodnota nesmí být záporná (NULL = splněno bez hodnoty, povoleno)
ALTER TABLE habit_logs DROP CONSTRAINT IF EXISTS habit_logs_hodnota_nonneg;
ALTER TABLE habit_logs ADD  CONSTRAINT habit_logs_hodnota_nonneg CHECK (hodnota IS NULL OR hodnota >= 0);

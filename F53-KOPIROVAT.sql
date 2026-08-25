ALTER TABLE habit_logs
  ADD COLUMN IF NOT EXISTS nahrazeno numeric NOT NULL DEFAULT 0;

ALTER TABLE habit_logs
  DROP CONSTRAINT IF EXISTS habit_logs_nahrazeno_nezaporne;

ALTER TABLE habit_logs
  ADD CONSTRAINT habit_logs_nahrazeno_nezaporne CHECK (nahrazeno >= 0);

SELECT column_name, data_type, column_default, is_nullable
FROM information_schema.columns
WHERE table_name = 'habit_logs' AND column_name = 'nahrazeno';

-- Fáze 0 / Krok 2 — M1: základ pro přihlášení (e-mail + heslo přes Supabase Auth)
-- Spustit v Supabase SQL editoru. NEJDŘÍV na TEST projektu, po záloze. PROD až po odsouhlasení.

-- napojení hráče na účet v Supabase Auth (auth.users)
ALTER TABLE players ADD COLUMN IF NOT EXISTS auth_user_id uuid REFERENCES auth.users(id) ON DELETE SET NULL;
ALTER TABLE players ADD COLUMN IF NOT EXISTS email text;

-- jeden účet = max jeden hráč
CREATE UNIQUE INDEX IF NOT EXISTS players_auth_user_id_key
  ON players (auth_user_id) WHERE auth_user_id IS NOT NULL;

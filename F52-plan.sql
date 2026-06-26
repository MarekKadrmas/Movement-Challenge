-- F52 plánování návyků: datum začátku (zacatek) + volitelný konec (konec)
-- Spustit v Supabase SQL editoru. Nejdřív na TEST projektu, na PROD až po odsouhlasení.

ALTER TABLE habits ADD COLUMN IF NOT EXISTS zacatek date;
ALTER TABLE habits ADD COLUMN IF NOT EXISTS konec   date;

-- existující návyky: začátek = den vytvoření, konec prázdný (běží napořád)
UPDATE habits SET zacatek = created_at::date WHERE zacatek IS NULL;

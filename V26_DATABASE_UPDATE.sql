-- Optional per-product external link. Existing products remain unchanged.
ALTER TABLE public.med_products ADD COLUMN IF NOT EXISTS button_text text NOT NULL DEFAULT '';
ALTER TABLE public.med_products ADD COLUMN IF NOT EXISTS button_url text NOT NULL DEFAULT '';
NOTIFY pgrst, 'reload schema';

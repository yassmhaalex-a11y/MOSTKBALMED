ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS brand_name text NOT NULL DEFAULT 'MOSTKBALMED';
NOTIFY pgrst, 'reload schema';

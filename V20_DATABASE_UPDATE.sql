ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS hero_image text DEFAULT '';
NOTIFY pgrst, 'reload schema';

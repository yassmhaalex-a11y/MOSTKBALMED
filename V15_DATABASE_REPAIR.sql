-- MOSTKBALMED V15: Non-destructive repair for public website settings.
-- Run in the SAME Supabase project configured in config.js.
CREATE TABLE IF NOT EXISTS public.med_settings (
 id integer PRIMARY KEY DEFAULT 1 CHECK (id = 1),
 about_title text DEFAULT 'About Us', about_text text DEFAULT '',
 contact_title text DEFAULT 'Contact Us', contact_text text DEFAULT '',
 whatsapp text DEFAULT '', phone text DEFAULT '',
 maintenance_image text DEFAULT ''
);
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS maintenance_image text DEFAULT '';
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS whatsapp text DEFAULT '';
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS phone text DEFAULT '';
ALTER TABLE public.med_settings ENABLE ROW LEVEL SECURITY;
GRANT SELECT ON public.med_settings TO anon, authenticated;
GRANT INSERT, UPDATE ON public.med_settings TO authenticated;
DROP POLICY IF EXISTS med_settings_public_read ON public.med_settings;
CREATE POLICY med_settings_public_read ON public.med_settings FOR SELECT TO anon, authenticated USING (true);
INSERT INTO public.med_settings (id) VALUES (1) ON CONFLICT (id) DO NOTHING;
NOTIFY pgrst, 'reload schema';
-- Diagnostic: this should return one row, with your image URL and contact numbers.
SELECT id, maintenance_image, whatsapp, phone FROM public.med_settings WHERE id = 1;

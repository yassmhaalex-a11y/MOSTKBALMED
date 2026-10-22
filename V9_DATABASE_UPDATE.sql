-- MOSTKBALMED V9: run once in existing Supabase SQL Editor.
-- Non-destructive: preserves existing products, admins, images and settings.
ALTER TABLE public.med_products ADD COLUMN IF NOT EXISTS images jsonb NOT NULL DEFAULT '[]'::jsonb;
ALTER TABLE public.med_products ALTER COLUMN category DROP NOT NULL;
CREATE TABLE IF NOT EXISTS public.med_settings (
 id integer PRIMARY KEY DEFAULT 1 CHECK (id = 1),
 about_title text NOT NULL DEFAULT 'About Us',
 about_text text NOT NULL DEFAULT '',
 about_image text NOT NULL DEFAULT '',
 about_overlay text NOT NULL DEFAULT 'MOSTKBALMED',
 contact_title text NOT NULL DEFAULT 'Contact Us',
 contact_text text NOT NULL DEFAULT '',
 whatsapp text NOT NULL DEFAULT '',
 phone text NOT NULL DEFAULT ''
);
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS maintenance_image text NOT NULL DEFAULT '';
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS equipment_image text NOT NULL DEFAULT '';
ALTER TABLE public.med_settings ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS med_settings_public_read ON public.med_settings;
CREATE POLICY med_settings_public_read ON public.med_settings FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS med_settings_admin_insert ON public.med_settings;
CREATE POLICY med_settings_admin_insert ON public.med_settings FOR INSERT TO authenticated WITH CHECK (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id = auth.uid()));
DROP POLICY IF EXISTS med_settings_admin_update ON public.med_settings;
CREATE POLICY med_settings_admin_update ON public.med_settings FOR UPDATE TO authenticated USING (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id = auth.uid())) WITH CHECK (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id = auth.uid()));
INSERT INTO public.med_settings (id) VALUES (1) ON CONFLICT (id) DO NOTHING;
-- Ask PostgREST to refresh its column cache immediately.
NOTIFY pgrst, 'reload schema';

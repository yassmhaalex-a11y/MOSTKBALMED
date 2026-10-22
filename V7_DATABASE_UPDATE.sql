-- MOSTKBALMED V7 migration. Run in the existing MOSTKBALMED Supabase SQL Editor.
-- No product rows are deleted. Categories become optional, and old categories remain stored.
ALTER TABLE public.med_products ALTER COLUMN category DROP NOT NULL;

CREATE TABLE IF NOT EXISTS public.med_settings (
 id INTEGER PRIMARY KEY DEFAULT 1 CHECK (id = 1),
 about_title TEXT NOT NULL DEFAULT 'About Us',
 about_text TEXT NOT NULL DEFAULT 'Learn more about our medical equipment and supplies.',
 about_image TEXT NOT NULL DEFAULT '',
 about_overlay TEXT NOT NULL DEFAULT 'MOSTKBALMED',
 contact_title TEXT NOT NULL DEFAULT 'Contact Us',
 contact_text TEXT NOT NULL DEFAULT 'Contact our team for product information.',
 whatsapp TEXT NOT NULL DEFAULT '',
 phone TEXT NOT NULL DEFAULT ''
);
ALTER TABLE public.med_settings ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "med_settings_public_read" ON public.med_settings;
CREATE POLICY "med_settings_public_read" ON public.med_settings FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "med_settings_admin_insert" ON public.med_settings;
CREATE POLICY "med_settings_admin_insert" ON public.med_settings FOR INSERT TO authenticated WITH CHECK (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id = (SELECT auth.uid())));
DROP POLICY IF EXISTS "med_settings_admin_update" ON public.med_settings;
CREATE POLICY "med_settings_admin_update" ON public.med_settings FOR UPDATE TO authenticated USING (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id = (SELECT auth.uid()))) WITH CHECK (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id = (SELECT auth.uid())));
INSERT INTO public.med_settings(id) VALUES (1) ON CONFLICT (id) DO NOTHING;

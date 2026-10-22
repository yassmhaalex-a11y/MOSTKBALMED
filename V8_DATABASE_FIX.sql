-- MOSTKBALMED V8: run in your EXISTING Supabase project, SQL Editor.
-- Safe to rerun; keeps existing products, images, categories, and accounts.

ALTER TABLE public.med_products ALTER COLUMN category DROP NOT NULL;
ALTER TABLE public.med_products ADD COLUMN IF NOT EXISTS images JSONB NOT NULL DEFAULT '[]'::jsonb;

CREATE TABLE IF NOT EXISTS public.med_settings (
 id INTEGER PRIMARY KEY DEFAULT 1 CHECK (id=1),
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
DROP POLICY IF EXISTS med_settings_public_read ON public.med_settings;
CREATE POLICY med_settings_public_read ON public.med_settings FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS med_settings_admin_insert ON public.med_settings;
CREATE POLICY med_settings_admin_insert ON public.med_settings FOR INSERT TO authenticated WITH CHECK (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id=auth.uid()));
DROP POLICY IF EXISTS med_settings_admin_update ON public.med_settings;
CREATE POLICY med_settings_admin_update ON public.med_settings FOR UPDATE TO authenticated USING (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id=auth.uid())) WITH CHECK (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id=auth.uid()));
INSERT INTO public.med_settings (id) VALUES (1) ON CONFLICT (id) DO NOTHING;

INSERT INTO storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
VALUES ('med-images','med-images',true,5242880,ARRAY['image/jpeg','image/png','image/webp'])
ON CONFLICT (id) DO UPDATE SET public=true,file_size_limit=5242880,allowed_mime_types=EXCLUDED.allowed_mime_types;
DROP POLICY IF EXISTS med_images_admin_insert ON storage.objects;
CREATE POLICY med_images_admin_insert ON storage.objects FOR INSERT TO authenticated
WITH CHECK (bucket_id='med-images' AND EXISTS (SELECT 1 FROM public.med_admins WHERE user_id=auth.uid()));
DROP POLICY IF EXISTS med_images_public_read ON storage.objects;
CREATE POLICY med_images_public_read ON storage.objects FOR SELECT TO anon,authenticated USING (bucket_id='med-images');

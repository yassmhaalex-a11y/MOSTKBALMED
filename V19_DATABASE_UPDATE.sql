-- MOSTKBALMED V19 - non-destructive migration. Run AFTER V18 updates.
CREATE EXTENSION IF NOT EXISTS pgcrypto;
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS brand_subtitle text DEFAULT 'MEDICAL EQUIPMENT & SUPPLIES';
UPDATE public.med_settings SET brand_subtitle=COALESCE(brand_subtitle,'MEDICAL EQUIPMENT & SUPPLIES') WHERE id=1;
CREATE TABLE IF NOT EXISTS public.med_catalog_categories (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 name text NOT NULL,
 description text NOT NULL DEFAULT '',
 image text NOT NULL DEFAULT '',
 active boolean NOT NULL DEFAULT true,
 created_at timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.med_products ADD COLUMN IF NOT EXISTS category_id uuid;
ALTER TABLE public.med_products ALTER COLUMN category DROP NOT NULL;
ALTER TABLE public.med_products DROP CONSTRAINT IF EXISTS med_products_category_id_fkey;
ALTER TABLE public.med_products ADD CONSTRAINT med_products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.med_catalog_categories(id) ON DELETE RESTRICT;
-- Existing products remain intact and uncategorized until assigned via Admin > Products.
ALTER TABLE public.med_catalog_categories ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS med_catalog_categories_public_read ON public.med_catalog_categories;
CREATE POLICY med_catalog_categories_public_read ON public.med_catalog_categories FOR SELECT TO anon,authenticated USING (active=true);
DROP POLICY IF EXISTS med_catalog_categories_admin_read ON public.med_catalog_categories;
CREATE POLICY med_catalog_categories_admin_read ON public.med_catalog_categories FOR SELECT TO authenticated USING (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id=auth.uid()));
DROP POLICY IF EXISTS med_catalog_categories_admin_insert ON public.med_catalog_categories;
CREATE POLICY med_catalog_categories_admin_insert ON public.med_catalog_categories FOR INSERT TO authenticated WITH CHECK (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id=auth.uid()));
DROP POLICY IF EXISTS med_catalog_categories_admin_update ON public.med_catalog_categories;
CREATE POLICY med_catalog_categories_admin_update ON public.med_catalog_categories FOR UPDATE TO authenticated USING (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id=auth.uid())) WITH CHECK (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id=auth.uid()));
DROP POLICY IF EXISTS med_catalog_categories_admin_delete ON public.med_catalog_categories;
CREATE POLICY med_catalog_categories_admin_delete ON public.med_catalog_categories FOR DELETE TO authenticated USING (EXISTS (SELECT 1 FROM public.med_admins WHERE user_id=auth.uid()));
GRANT SELECT ON public.med_catalog_categories TO anon;
GRANT SELECT,INSERT,UPDATE,DELETE ON public.med_catalog_categories TO authenticated;
GRANT SELECT ON public.med_settings TO anon;
NOTIFY pgrst, 'reload schema';

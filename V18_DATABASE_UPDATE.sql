-- MOSTKBALMED V18: safe, non-destructive website content fields
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS hero_eyebrow text DEFAULT 'WELCOME TO MOSTKBALMED';
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS hero_title text DEFAULT E'Medical equipment.\nTrusted information.';
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS hero_description text DEFAULT 'Explore medical equipment and supplies in one organized catalog. View product details and specifications with ease.';
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS hero_button_text text DEFAULT 'Explore Products';
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS maintenance_button_label text DEFAULT 'قسم الصيانة';
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS maintenance_whatsapp text DEFAULT '';
ALTER TABLE public.med_settings ADD COLUMN IF NOT EXISTS maintenance_enabled boolean DEFAULT false;
UPDATE public.med_settings SET hero_eyebrow=COALESCE(hero_eyebrow,'WELCOME TO MOSTKBALMED'),hero_title=COALESCE(hero_title,E'Medical equipment.\nTrusted information.'),hero_description=COALESCE(hero_description,'Explore medical equipment and supplies in one organized catalog. View product details and specifications with ease.'),hero_button_text=COALESCE(hero_button_text,'Explore Products'),maintenance_button_label=COALESCE(maintenance_button_label,'قسم الصيانة'),maintenance_enabled=COALESCE(maintenance_enabled,false) WHERE id=1;
NOTIFY pgrst, 'reload schema';

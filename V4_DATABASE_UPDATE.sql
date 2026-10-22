-- Run once in the EXISTING MOSTKBALMED Supabase SQL Editor.
-- Does not delete or reset existing products.
ALTER TABLE public.med_products
ADD COLUMN IF NOT EXISTS images JSONB NOT NULL DEFAULT '[]'::jsonb;

UPDATE public.med_products
SET images = jsonb_build_array(image)
WHERE (images IS NULL OR images = '[]'::jsonb)
  AND image IS NOT NULL AND image <> '';

# MOSTKBALMED V9 — FIXED

## Install in this order
1. In the **existing** MOSTKBALMED Supabase project, open SQL Editor > New Query.
2. Paste the **entire** `V9_DATABASE_UPDATE.sql` and click Run. It adds `med_products.images`, allows products without a category, creates/updates settings, and refreshes the API schema cache. **It does not delete products.**
3. Wait ~10 seconds. If a column-cache error persists, reload the SQL Editor and rerun the migration, then redeploy.
4. Upload the V9 files into the root of the existing GitHub repository, replacing old files; Vercel redeploys automatically.
5. Visit `/admin.html`, sign in, add a product, and test the success/error toast. In Website Content, set the maintenance and equipment images and click Save Website Content.
6. Check the home page navigation: hover over الصيانة or التجهيزات to see the configured image; moving the pointer away hides it. Keyboard focus also shows it.

## Important
- Keep your existing `config.js` public URL and **publishable** key. Do not put a service-role or secret key in this file.
- Website Content changes are saved in `public.med_settings` in Supabase; products in `public.med_products`.
- Images are uploaded to the public `med-images` storage bucket. Do not upload sensitive/private photos.
- This release does not change your admin user or remove data.

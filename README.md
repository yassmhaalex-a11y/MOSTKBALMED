# MOSTKBALMED V19 — Categories + Editable Brand Subtitle

1. Back up your Supabase project (database) before updating.
2. Run `V19_DATABASE_UPDATE.sql` in the SAME Supabase project (after the V18 migrations). Do not run older setup files again.
3. Upload **all** files to the GitHub repository root, replacing old files. Wait for Vercel Ready.
4. In Admin > Homepage, change the small subtitle under MOSTKBALMED and save.
5. In Admin > Categories, add a category with name, description, and image; save it.
6. In Admin > Products, edit existing products and select a category, then save. New products also require a category.
7. Homepage shows categories only. Click one to see its products and search within it.

Existing products are **not deleted**. They are not displayed until assigned to a category. Contact buttons, service hover, About and other settings remain as before.

If categories fail to load, check the SQL and Supabase RLS policies. For image upload, the existing `med-images` bucket and upload policy must still work.

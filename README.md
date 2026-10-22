# MOSTKBALMED V2 — Medical Catalog + Admin

## Installation
1. Create a **new** Supabase project, separate from Flash Store.
2. In Supabase SQL Editor run `supabase_setup.sql` once.
3. Authentication > Users > Add user: create your own admin email/password (do not share the password). Copy its UUID.
4. SQL Editor: `insert into public.med_admins(user_id) values ('YOUR-ADMIN-USER-UUID');`
5. Project Settings > API Keys: copy the project URL and the **publishable/anon** key into `config.js`. NEVER use service_role or secret keys in browser files.
6. Upload all V2 files to the root of your GitHub repository (replace V1 files), then wait for Vercel deployment.
7. Open `/admin.html`, sign in and create categories before products. Upload product images or provide public image URLs.

Public catalog is at `/`. Prices, checkout and orders do not exist. The V1 demo products are displayed only until `config.js` is configured. Once configured, the site displays products from Supabase.

Security: RLS restricts writes to explicitly listed admins. Uploaded images are public. Do not upload confidential files. Category deletion is blocked if products still reference it.

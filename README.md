# MOSTKBALMED V3 — Medical Catalog (See Only)

New in V3: product cards show only product name and category; View Details opens `product.html?id=...` with a rotating MOSTKBALMED loading animation, full description and specifications. No prices or checkout.

## Deploy
Upload all files from this ZIP to the root of your existing GitHub MOSTKBALMED repository, replacing existing files. Vercel redeploys automatically. Keep `config.js` pointing to the same Supabase project.

## Database
Uses existing `med_products`, `med_categories`, `med_admins` and `med-images` from V2. No new SQL needed. Existing admin panel is unchanged.

## Important
The Supabase publishable key is public by design. Never add a service role or secret key to frontend code.

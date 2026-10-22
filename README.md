# MOSTKBALMED V4 — Multiple Product Images

## Important: Database first
Open the existing MOSTKBALMED Supabase project → SQL Editor → New query. Run `V4_DATABASE_UPDATE.sql`. This preserves existing products and copies each existing cover image into the new image gallery. Do NOT rerun the V2 setup or create a new Supabase project.

## Deploy
Upload all site files to the ROOT of the existing GitHub repository, replacing older versions; Vercel redeploys. `config.js` contains a publishable client key, not a secret. Never commit a secret or service_role key.

## Admin
Open `/admin.html`, edit or create a product. You can upload multiple JPG/PNG/WebP files (up to 5 MB EACH), paste multiple image URLs (one per line), remove old images, and choose a cover. Save product to apply changes. The cover image is the first image. Images already uploaded to Storage are not physically deleted when removed from a product.

## Catalog
Product cards show only the cover; product details include gallery thumbnails and previous/next navigation, plus the existing loading animation. No prices or checkout.


## V5 - Official logo
- Added supplied AL-MOSTKBAL For Import & Export logo to all page headers and home hero.
- Added logo-derived favicon and logo animation on product details loader.
- Preserved V4 Supabase integration, multi-image galleries, admin panel and catalog-only flow.
- Upload all files (including `logo.jpg` and `favicon.png`) to repository root. No new SQL needed.


## V6 — Empty starter catalog
- Removed the six example products and four example categories from the local `products.js` file.
- Removed references to `products.js` from the public pages.
- Catalog now shows only categories and products returned by your Supabase project.
- If you previously saved example products/categories into Supabase, delete those specific records from the admin panel separately. This ZIP does NOT delete database records.
- Keep your existing `config.js` public Supabase URL and publishable key; never put secret keys in it.

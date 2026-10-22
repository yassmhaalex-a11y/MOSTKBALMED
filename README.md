# MOSTKBALMED — V1

Medical equipment and supplies **catalog-only** website. No prices, carts, purchases, payments, or orders.

## Files
- `index.html` — website layout
- `style.css` — blue-and-white responsive design
- `products.js` — sample categories and products
- `app.js` — category filters, search, and product details

## Edit catalog
Open `products.js` and replace the **demo** categories and products with your actual items. To add images, create an `images` folder and reference files with paths such as `images/monitor.jpg`. Do not publish unverified medical specifications.

## GitHub upload
1. Open your new MOSTKBALMED repository.
2. Choose **Add file → Upload files**.
3. Extract the ZIP and upload **the files inside** the `MOSTKBALMED_V1` folder to the repository root (not the folder itself).
4. Commit changes.

## Vercel
Import the repository at https://vercel.com/new . Choose **Other** framework preset if asked, leave build command blank, and deploy. `index.html` must be in the repository root.

## Important
This V1 is a static catalog prototype with sample products, not a production database or admin panel. A secure admin dashboard will need authentication and a separate Supabase project. Do not put Supabase service-role keys in frontend JavaScript.

# MOSTKBALMED V7 — catalog only

New features: products without categories, multi-row grid, About image with hover overlay, WhatsApp and landline contact buttons, and editable About/Contact content in admin.

## Install
1. In the EXISTING MOSTKBALMED Supabase project, run `V7_DATABASE_UPDATE.sql` in SQL Editor. It does not delete any products or categories.
2. Upload all V7 site files to the ROOT of the existing GitHub repository, replacing earlier versions. Remove obsolete `products.js` if it remains.
3. Vercel will redeploy. Open `/admin.html` and edit Products or Website Content.
4. Set WhatsApp as an international phone number with country code (example: 2010XXXXXXXX). Set landline with area/country code. The phone button works on devices/apps that support `tel:` links.

Note: `config.js` contains only the public Supabase publishable key, not a service-role key. Do not upload secrets.

Existing products remain. Existing category values may remain in the database, but are not used by V7. About image can be uploaded into existing `med-images` bucket. If SQL previously changed `features` to JSONB, the product editor still saves a JSON-compatible array.

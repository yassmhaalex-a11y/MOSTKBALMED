MOSTKBALMED V15 — Settings / Hover / Contact repair

1. Run V15_DATABASE_REPAIR.sql in Supabase SQL Editor (same project as config.js). It preserves data.
2. The SELECT result must contain a non-empty maintenance_image URL and WhatsApp/phone numbers. If empty, open Admin, upload the service image, enter both numbers, click Save This Page.
3. Upload ALL website files to GitHub root; wait for Vercel Ready; hard refresh Ctrl+Shift+R.
4. Hover over الصيانة والتجهيزات beside About Us.
5. If settings still fail, the site now shows an error instead of silently failing.

Changes: independent public settings fetch (no longer blocked by product loading), checks settings public visibility after admin save, safe WhatsApp/phone links, hover image and clear error hints.
NOTE: Actual live Supabase connectivity cannot be tested from this offline build.

V16: Restored WhatsApp logo and phone handset icon in Contact Us buttons. No database migration required.

# MOSTKBALMED V8 FIXED

Fixes: product save diagnostics, database category constraint migration, reliable About/Contact settings persistence, and public API requests using Supabase publishable keys. WhatsApp and Call buttons activate after you enter numbers in Admin > Website Content and save. Phone links require a phone/dialer app (desktop browsers may not have one).

## Install
1. Open your existing MOSTKBALMED Supabase project > SQL Editor > New query. Run `V8_DATABASE_FIX.sql` in the SQL Editor (not an AI SQL generator). No products or accounts are deleted.
2. In Admin > Website Content, enter WhatsApp number in international digits, e.g. 2010XXXXXXXX (no leading + needed). Enter landline e.g. +203XXXXXXX. Click Save Website Content and refresh to confirm persistence.
3. Upload ALL V8 files to the ROOT of the GitHub repo, overwriting existing files. Vercel will redeploy.
4. Sign in to /admin.html, add a product. If image upload fails, read the red error message at the top.

The site's public `config.js` uses a publishable key only; never place a service role key in it. Existing data remains in Supabase.

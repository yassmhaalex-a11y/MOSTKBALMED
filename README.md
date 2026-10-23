MOSTKBALMED V17 — Contact buttons visibility fix.

Root cause: index.html had hidden attributes on both contact anchors; app.js set href but did not remove hidden. Both buttons are now visible even when contact settings are missing. Links become active when valid WhatsApp and landline numbers are saved in Supabase Admin Contact Us. No SQL changes. Other features retained from V16.

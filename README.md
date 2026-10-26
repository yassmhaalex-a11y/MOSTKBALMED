MOSTKBALMED V22 — Adaptive Homepage Hero Image Frame

The homepage hero image is no longer cropped or forced into a circle. Its border adapts to the natural aspect ratio of the uploaded image (within responsive maximum dimensions).

Upload all files to the GitHub repository root, replacing existing files. No new SQL migration is needed. Other features are unchanged from V21.

V23: Homepage category cards are centered and slightly larger. Two categories appear side by side, centered on desktop, and stack on small screens. No database migration required.


## V24 — Adaptive Category Image Frame
Homepage category photos use their natural aspect ratio at full card width. No fixed-height letterboxing or cropping. Category layout stays centered as in V23. No database migration required.

V25: Homepage category titles centered in their cards. No database migration required.


## V26 - Product link button
Run V26_DATABASE_UPDATE.sql in Supabase SQL Editor before uploading site files. Admin > Products > Add/Edit: fill Button text and Button link (both optional). A safe external link appears immediately below the product description. Existing products remain unchanged.

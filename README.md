# Life Scrapbook — Cloud Sync edition

This version is ready for GitHub Pages / `journal.summerbeshore.com` and adds optional private cloud sync through Supabase.

## GitHub update
Upload these files to the **main** branch at the repository root. Existing files with the same names should be replaced/updated:
- `index.html`
- `manifest.webmanifest`
- `sw.js`
- `icon-192.png`
- `icon-512.png`
- `README.md`
- `supabase-setup.sql`

GitHub Pages remains: **main** + **/(root)**.

## Free cloud sync setup
1. Create a free Supabase project.
2. In Supabase, open **SQL Editor**, paste `supabase-setup.sql`, and run it once.
3. In Supabase project settings/API, copy the **Project URL** and **anon/public/publishable key**. Never use the `service_role` key in the browser app.
4. Open Life Scrapbook -> **Cloud Sync** and paste the URL + public key.
5. Create an account/sign in inside Life Scrapbook.
6. Press **Sync now**.

## Storage model
- Browser IndexedDB remains the local/offline copy.
- Text, metadata, social comments and layout data sync through private Postgres rows protected by Row Level Security.
- Media files sync through a private `scrapbook-media` Storage bucket.
- Deletions are stored as tombstones so an older device should not recreate deleted entries.

## Privacy
The GitHub source code is public, but scrapbook content is not written to the GitHub repository. The Supabase SQL enables Row Level Security so an authenticated user can only access rows/files under their own user ID.

## Backups
Cloud sync is not a substitute for backups. Use **Import / Backup -> Export backup** periodically.

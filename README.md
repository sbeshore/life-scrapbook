# Life Scrapbook — GitHub Pages package

## Upload
1. Extract `life-scrapbook-github-ready.zip`.
2. In GitHub, open the `life-scrapbook` repository and choose **Add file → Upload files**.
3. Drag in the **extracted files**. Do not upload the ZIP as one file; GitHub Pages does not unpack it.
4. Commit to `main`.
5. Go to **Settings → Pages → Build and deployment → Deploy from a branch**. Choose `main` and `/ (root)`, then Save.
6. Once the GitHub Pages URL works, set the custom domain to `journal.summerbeshore.com`.

## Important
- Source code can be public; journal entries/photos are stored in browser IndexedDB and are not committed to GitHub.
- Do **not** upload exported scrapbook backup JSON files to the public repository.
- Use **Export Backup** regularly until cloud sync is added.
- Direct PDF download uses the html2pdf.js CDN. **Print / Save PDF** remains the fallback.

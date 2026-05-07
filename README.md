# max-lu-site

Source for [max-lu.com](https://max-lu.com) — personal site and product pages.

## Structure

```
.
├── index.html                          # max-lu.com landing
├── styles.css                          # shared styles
└── products/
    └── qualanalyzer/
        ├── index.html                  # /products/qualanalyzer/
        └── privacy.html                # /products/qualanalyzer/privacy.html
```

## Adding a new product page

1. Create `products/<slug>/index.html` (copy an existing one as a template)
2. Add a card link to it from the root `index.html`
3. Commit and push — Cloudflare Pages auto-deploys

## Local preview

Any static server works:

```bash
python3 -m http.server 8000
# or
npx serve .
```

## Hosting

Deployed via Cloudflare Pages, connected to this GitHub repo. Pushes to `main` deploy automatically.

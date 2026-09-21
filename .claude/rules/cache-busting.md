# Cache busting `?v=N`

Avant de committer une modif de `assets/style.css` ou du logo (`assets/erepublik.jpg`) :

- [ ] Incrémenter `?v=N` sur **toutes** les références dans `index.html` (link stylesheet, favicon, og:image, img src) — pas seulement une.
- [ ] Ajouter une ligne dans `CHANGELOG.md` pour la nouvelle version.

**Pourquoi** : Cloudflare cache le CSS/logo avec un TTL de 7 jours (cf. README). Sans bump de version, la modif ne sera pas visible en prod avant une semaine.

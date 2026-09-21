# Architecture

How this repository is laid out and why.

## Repository layout

```text
.
├── index.html                          Page unique du site
├── robots.txt
├── sitemap.xml
├── assets/
│   ├── style.css                       Feuille de style (sections commentées)
│   ├── erepublik.jpg                   Logo + favicon
│   └── erepublik-badge-300x250.png     Badge officiel eRepublik (bandeau bas)
├── tools/
│   └── whois-reports/                  Rapports whois, non versionnés (.gitignore)
└── .claude/
    ├── CLAUDE.md
    ├── ARCHITECTURE.md                 Ce fichier
    ├── rules/                          Checklists bloquantes, toujours chargées
    ├── hooks/                          session-banner.sh
    └── settings.json
```

## Design constraints to preserve

- Pas de JavaScript : le toggle « À propos » utilise `<details>` natif — volontaire, ne pas réintroduire de JS pour ça.
- Cache busting manuel via `?v=N` sur `style.css` et le logo — voir `.claude/rules/cache-busting.md`.

## CI/CD

Pas de CI. Push sur `main` → pull automatique par Plesk via webhook → déploiement instantané sur erepublik.fr.

## Known pitfalls

- Les URLs in-game `erepublik.com/en/...` peuvent changer, à vérifier périodiquement (cf. README, section Maintenance).

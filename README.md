# erepublik.fr

Portail historique de la communauté française du jeu **eRepublik** (eFrance).

Site statique d'une seule page, restauré en mai 2026 depuis les archives Wayback Machine, déployé sur [erepublik.fr](https://erepublik.fr/).

## Stack

- HTML5 statique (pas de framework, pas de build)
- CSS vanilla (fidèle au visuel d'origine 2008-2010)
- Toggle "À propos" via `<details>` natif (aucun JavaScript)
- [Matomo](https://mesure.jasonrouet.com/) pour les analytics

## Structure

```
.
├── index.html              Page unique
├── robots.txt
├── sitemap.xml
└── assets/
    ├── style.css           Feuille de style (sections commentées)
    ├── erepublik.jpg       Logo + favicon
    ├── banner-erepublik.jpg
    └── city rising sun 300x250.jpg
```

## Déploiement

Push sur la branche `main` → Plesk pull automatique via webhook → déploiement instantané sur `https://erepublik.fr/`.

```bash
git add -A
git commit -m "..."
git push
```

## Cache busting

Le CSS est référencé avec un paramètre de version (`?v=N`) dans `index.html`. **Penser à incrémenter ce numéro à chaque modification de `style.css`** pour contourner le cache Cloudflare (TTL de 7 jours).

## Maintenance

- **Liens in-game** : les URLs `erepublik.com/en/...` peuvent changer. Vérifier périodiquement.
- **Wayback Machine** : les liens du toggle pointent vers des recherches Wayback (`/web/AAAA*/`), pas des snapshots figés. Si Wayback restructure ses URLs, à mettre à jour.
- **Discord/contact** : voir footer pour le contact mainteneur.

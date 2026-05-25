<p align="center">
  <img src="assets/erepublik.jpg" alt="eRepublik.fr" width="180">
</p>

<h1 align="center">eRepublik.fr</h1>

<p align="center">
  Portail historique de la communauté française du jeu <strong>eRepublik</strong> (eFrance).<br>
  <a href="https://erepublik.fr/">erepublik.fr</a>
</p>

---

Site statique d'une seule page, restauré en mai 2026 depuis les archives de la Wayback Machine.

## Stack

- **HTML5 statique** — pas de framework, pas de build
- **CSS vanilla** — fidèle au visuel d'origine (2008-2010)
- **Toggle « À propos »** via `<details>` natif — aucun JavaScript
- **[Matomo](https://stats.jasonrouet.com/)** pour les analytics

## Structure

```
.
├── index.html              Page unique
├── robots.txt
├── sitemap.xml
└── assets/
    ├── style.css                       Feuille de style (sections commentées)
    ├── erepublik.jpg                   Logo + favicon
    └── erepublik-badge-300x250.png     Badge officiel eRepublik (bandeau bas)
```

## Déploiement

Push sur `main` → pull automatique par Plesk via webhook → déploiement instantané sur [erepublik.fr](https://erepublik.fr/).

```bash
git add -A
git commit -m "..."
git push
```

> [!IMPORTANT]
> **Cache busting** — le CSS et le logo sont référencés avec un paramètre de version (`?v=N`) dans `index.html`. Incrémenter ce numéro à chaque modification de `style.css` ou du logo pour contourner le cache Cloudflare (TTL 7 jours).

## Maintenance

- **Liens in-game** — les URLs `erepublik.com/en/...` peuvent changer ; vérifier périodiquement.
- **Wayback Machine** — les liens du toggle pointent vers des recherches (`/web/AAAA*/`), pas des snapshots figés. À mettre à jour si Wayback restructure ses URLs.
- **Contact** — voir le footer du site pour joindre le mainteneur.

## Crédits

Créateurs historiques des sites de la communauté eFrance, identifiés depuis la Wayback Machine :

| Site | Créateur / Plateforme | Source |
|---|---|---|
| **eRepublik.fr** (portail) | CustMax | Footer 2010 : « Créé par CustMax pour eRepublik.fr » |
| **eBabyBoom** (erepublik.niouton.info) | **Niouton** | `<meta name="author" content="Niouton">` |
| **education.erepublik.fr** (wiki) | Communauté eFrance, propulsé par MediaWiki | Aucun auteur unique identifié |
| **forum.erepublik.fr** puis **forum.erepfrance.com** | Communauté eFrance, propulsé par phpBB | Forum communautaire, modéré par les administrateurs élus |
| **portail.erepublik.fr** (blog) | Inconnu — à investiguer | — |

Si vous étiez impliqué dans la création ou l'administration de l'un de ces sites et souhaitez être crédité (ou rectifier une attribution), [DM sur Discord](https://discord.com/users/250288551562969089).

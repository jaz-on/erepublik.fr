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

## Crédits

Créateurs historiques des sites de la communauté eFrance, identifiés depuis les archives Wayback Machine :

| Site | Créateur / Plateforme | Source |
|---|---|---|
| **eRepublik.fr** (portail) | [CustMax](https://web.archive.org/web/2010*/custmax.eu) | Footer 2010 : « Créé par CustMax pour eRepublik.fr » |
| **eBabyBoom** (erepublik.niouton.info) | **Niouton** | `<meta name="author" content="Niouton">` |
| **education.erepublik.fr** (wiki) | Communauté eFrance, propulsé par MediaWiki | Aucun auteur unique identifié |
| **forum.erepublik.fr** puis **forum.erepfrance.com** | Communauté eFrance, propulsé par phpBB | Forum communautaire, modéré par les administrateurs élus |
| **portail.erepublik.fr** (blog) | Inconnu — à investiguer | — |

Si vous étiez impliqué dans la création ou l'administration de l'un de ces sites et souhaitez être crédité (ou rectifier une attribution), [DM sur Discord](https://discord.com/users/250288551562969089).

### Anciens propriétaires des noms de domaine

Recherche automatisée via [`tools/whois_history.sh`](tools/whois_history.sh).

| Domaine | Première création AFNIC/Verisign | Statut actuel |
|---|---|---|
| **erepublik.fr** | **1999-10-18** (soit ~9 ans avant le lancement du jeu en 2007 — le créateur initial n'a sans doute aucun lien avec eRepublik) | Repris en mai 2026 par MarcDuplessisBack après expiration. Registrar : OVH. |
| **erepfrance.com** | 2023-02-19 (date du squat après expiration du domaine d'origine) | Squatté. Registrar : Key-Systems GmbH. NS : NDSPLITTER.COM (parking/monétisation). |

**Identités masquées** : AFNIC (`.fr`) anonymise depuis 2011 — mention `ANO00-FRNIC` sur le whois mais « *While the registrar knows him/her* », OVH connaît l'identité historique. Pour `.com`, le RGPD (mai 2018) a généralisé le redacted.

Pour reconstituer l'historique complet (succession des propriétaires, e-mails pré-RGPD), il faut une API payante :

```bash
export WHOISXML_API_KEY=ta_cle  # ~$2-5 par domaine
./tools/whois_history.sh erepublik.fr erepfrance.com
```

Pistes alternatives non automatisées : DomainTools, SecurityTrails (50 requêtes/mois gratuites), demande motivée à l'AFNIC pour les `.fr`.

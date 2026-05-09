#!/usr/bin/env bash
# ============================================================================
# whois_history.sh — Recherche d'historique Whois pour un domaine
#
# Automatise tout ce qui est faisable sans API key payante :
#   1. Whois actuel (registrar, nserver, dates de création/expiration)
#   2. Wayback Machine — snapshots de pages Whois publiques (who.is, etc.)
#   3. Aperçu gratuit WhoisXML (date premier enregistrement, nb de changements)
#
# Pour l'historique COMPLET (qui possédait quoi à quelle date), il faut une
# API payante. Si tu as une clé API, exporte-la et relance :
#   export WHOISXML_API_KEY="ton_api_key"
#   ./whois_history.sh erepublik.fr
#
# Sans clé : sortie limitée mais déjà utile.
#
# Usage : ./whois_history.sh <domaine> [<domaine2> ...]
# Sortie : ./whois-reports/<domaine>-<date>.md
# ============================================================================

set -euo pipefail

OUT_DIR="${OUT_DIR:-./whois-reports}"
mkdir -p "$OUT_DIR"

if [[ $# -eq 0 ]]; then
	echo "Usage : $0 <domaine> [<domaine2> ...]" >&2
	echo "Ex.   : $0 erepublik.fr erepfrance.com" >&2
	exit 1
fi

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

log()  { echo "  → $*"; }
hdr()  { echo ""; echo "## $*"; echo ""; }
code() { echo '```'; "$@" 2>&1 || true; echo '```'; }

check_dep() {
	command -v "$1" >/dev/null 2>&1 || {
		echo "❌ Dépendance manquante : $1" >&2
		echo "   Installe avec : brew install $1" >&2
		exit 1
	}
}

check_dep whois
check_dep curl
check_dep jq

# ---------------------------------------------------------------------------
# 1. Whois actuel
# ---------------------------------------------------------------------------

current_whois() {
	local domain=$1
	hdr "Whois actuel — $(date +%Y-%m-%d)"
	echo '```'
	whois "$domain" 2>&1 \
		| grep -iE "registrar|registrant|holder|admin|created|registered|registration|creation|updated|expir|nserver|name server|status" \
		| grep -v "^%" \
		| head -30
	echo '```'
}

# ---------------------------------------------------------------------------
# 2. Wayback Machine — pages Whois publiques archivées
# ---------------------------------------------------------------------------

wayback_whois() {
	local domain=$1
	hdr "Wayback Machine — pages Whois archivées"

	local services=(
		"who.is/whois/${domain}"
		"www.whois.com/whois/${domain}"
		"whois.domaintools.com/${domain}"
	)

	for url in "${services[@]}"; do
		log "Recherche : $url"
		# CDX API : retourne tous les snapshots Wayback pour cette URL
		local cdx
		cdx=$(curl -s "https://web.archive.org/cdx/search/cdx?url=${url}&output=json&limit=10" || true)

		if [[ -z "$cdx" || "$cdx" == "[]" ]]; then
			echo "- Aucun snapshot Wayback pour \`$url\`"
			continue
		fi

		echo ""
		echo "**Snapshots trouvés pour \`$url\` :**"
		echo ""
		# jq : skip header row, format chaque snapshot
		echo "$cdx" | jq -r '.[1:][] | "- [" + .[1] + "](https://web.archive.org/web/" + .[1] + "/" + .[2] + ")"' 2>/dev/null \
			| head -10
		echo ""
	done
}

# ---------------------------------------------------------------------------
# 3. WhoisXML — aperçu gratuit (avec API key : historique complet)
# ---------------------------------------------------------------------------

whoisxml_history() {
	local domain=$1
	hdr "WhoisXML — historique"

	if [[ -z "${WHOISXML_API_KEY:-}" ]]; then
		echo "⚠️  Pas de \`WHOISXML_API_KEY\` configurée. Aperçu gratuit uniquement :"
		echo ""
		# Endpoint preview gratuit (renvoie nb de changements et 1ère date)
		local preview
		preview=$(curl -s "https://whois-history.whoisxmlapi.com/api/v1/preview?domainName=${domain}&apiKey=at_demo" || true)

		echo '```json'
		echo "$preview" | jq . 2>/dev/null || echo "$preview"
		echo '```'

		echo ""
		echo "Pour le rapport COMPLET (~\$2-5 / domaine) :"
		echo "1. Crée un compte sur https://whois-history.whoisxmlapi.com/"
		echo "2. \`export WHOISXML_API_KEY=ta_cle\`"
		echo "3. Relance ce script"
	else
		log "Récupération de l'historique complet..."
		local full
		full=$(curl -s "https://whois-history.whoisxmlapi.com/api/v1?domainName=${domain}&apiKey=${WHOISXML_API_KEY}&mode=purchase" || true)

		echo '```json'
		echo "$full" | jq . 2>/dev/null || echo "$full"
		echo '```'
	fi
}

# ---------------------------------------------------------------------------
# 4. Pistes additionnelles
# ---------------------------------------------------------------------------

extra_resources() {
	local domain=$1
	hdr "Pistes additionnelles"

	cat <<EOF
- **DomainTools** : https://research.domaintools.com/research/whois-history/?q=${domain}
- **SecurityTrails** : https://securitytrails.com/domain/${domain}/history/whois (50 reqs gratuites/mois avec compte)
- **WhoisFreaks** : https://whoisfreaks.com/services/whois-api/whois-history-lookup-api.html
EOF

	if [[ "$domain" == *.fr ]]; then
		cat <<EOF
- **AFNIC** (registrar des \`.fr\`) : pas d'API publique, mais une demande motivée par mail peut aboutir pour des cas légitimes : https://www.afnic.fr/
EOF
	fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

for domain in "$@"; do
	out="${OUT_DIR}/${domain}-$(date +%Y%m%d).md"
	echo "▶ Recherche pour : $domain"
	echo "  Sortie : $out"

	{
		echo "# Whois history — $domain"
		echo ""
		echo "Généré le $(date +%Y-%m-%d) par \`whois_history.sh\`."

		current_whois "$domain"
		wayback_whois "$domain"
		whoisxml_history "$domain"
		extra_resources "$domain"
	} > "$out"

	echo "✅ Rapport : $out"
	echo ""
done

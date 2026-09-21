#!/usr/bin/env bash
# .claude/hooks/lint-edited.sh — PostToolUse hook (Edit|Write), non-blocking.
# Runs whatever linter/formatter the repo declares, on the edited file only.
#
# erepublik.fr n'a ni package.json ni pyproject.toml ni config de linter
# (site statique HTML/CSS sans build) — pas de commande à invoquer pour
# l'instant. Si un linter est ajouté un jour (ex. stylelint sur assets/,
# htmlhint sur index.html), brancher la commande ci-dessous plutôt que
# d'en inventer une qui n'existe pas dans le repo.

set -u

payload=$(cat)

if command -v jq >/dev/null 2>&1; then
    file=$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty')
else
    file=$(printf '%s' "$payload" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("tool_input",{}).get("file_path",""))' 2>/dev/null)
fi

[ -z "$file" ] && exit 0
[ ! -f "$file" ] && exit 0

cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" || exit 0

# Aucun linter déclaré dans ce repo : no-op volontaire.

exit 0

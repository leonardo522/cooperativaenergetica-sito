#!/usr/bin/env bash
# Pubblica il sito su Cloudflare Pages (progetto cooperativa-energetica -> cooperativaenergetica.it).
# Lo lancia SOLO Leonardo dal suo Mac (serve il suo login wrangler), dopo aver unito le modifiche su main.
# Uso: git switch main && git pull && ./deploy.sh

set -euo pipefail
cd "$(dirname "$0")"

branch="$(git rev-parse --abbrev-ref HEAD)"
if [ "$branch" != "main" ]; then
  echo "Sei sul ramo '$branch': si pubblica solo da main." >&2
  exit 1
fi
if [ -n "$(git status --porcelain)" ]; then
  echo "Ci sono modifiche non salvate: pubblico solo quello che è su main." >&2
  exit 1
fi

DEPLOY_DIR="_deploy"
rm -rf "$DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR"

# Tutte le pagine e le immagini in radice, più le cartelle di asset se esistono.
shopt -s nullglob
cp -f ./*.html ./*.png ./*.jpg ./*.jpeg ./*.webp ./*.svg ./*.ico "$DEPLOY_DIR/" 2>/dev/null || true
[ -f _headers ] && cp -f _headers "$DEPLOY_DIR/"
[ -f _redirects ] && cp -f _redirects "$DEPLOY_DIR/"
[ -d assets ] && cp -R assets "$DEPLOY_DIR/"

echo "Pubblico $(ls "$DEPLOY_DIR" | wc -l | tr -d ' ') elementi su Cloudflare Pages (commit $(git rev-parse --short HEAD))"
npx --yes wrangler pages deploy "$DEPLOY_DIR" --project-name=cooperativa-energetica --branch=main --commit-hash="$(git rev-parse HEAD)" --commit-message="$(git log -1 --format=%s)"

echo ""
echo "Online su https://cooperativaenergetica.it"

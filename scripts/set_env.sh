#!/usr/bin/env bash
# Usage: VERCEL_TOKEN=xxx ./scripts/set_env.sh PROJECT_NAME KEY VALUE [production|preview|development]
set -euo pipefail
TOKEN="${VERCEL_TOKEN:?set VERCEL_TOKEN}"
TEAM_ID="${TEAM_ID:-team_OKmb59rKdei9pVAPhZW3MwEo}"
PROJECT="${1:?project name or id}"
KEY="${2:?env key}"
VALUE="${3:?env value}"
TARGET="${4:-production}"

curl -sS -X POST \
  "https://api.vercel.com/v10/projects/${PROJECT}/env?upsert=true&teamId=${TEAM_ID}" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d "[{\"key\":\"${KEY}\",\"value\":\"${VALUE}\",\"type\":\"plain\",\"target\":[\"${TARGET}\"]}]"
echo

#!/usr/bin/env bash
# Bootstrap x402-secure-gateway facilitator + payTo + network
set -euo pipefail
TOKEN="${VERCEL_TOKEN:?set VERCEL_TOKEN}"
TEAM_ID="${TEAM_ID:-team_OKmb59rKdei9pVAPhZW3MwEo}"
PROJECT="${PROJECT:-x402-secure-gateway}"

curl -sS -X POST \
  "https://api.vercel.com/v10/projects/${PROJECT}/env?upsert=true&teamId=${TEAM_ID}" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '[
    {"key":"FACILITATOR_URL","value":"https://x402.org/facilitator","type":"plain","target":["production","preview"]},
    {"key":"TREASURY_ADDRESS","value":"0xc22f9CAEBAc37fE72D5142f35f21f6696Ea9Ef69","type":"plain","target":["production","preview"]},
    {"key":"X402_PAY_TO","value":"0xc22f9CAEBAc37fE72D5142f35f21f6696Ea9Ef69","type":"plain","target":["production","preview"]},
    {"key":"X402_NETWORK","value":"eip155:84532","type":"plain","target":["production","preview"]},
    {"key":"PUBLIC_BASE_URL","value":"https://x402-micro-pay.com","type":"plain","target":["production","preview"]}
  ]'
echo
echo "Env upserted. Redeploy production for x402-secure-gateway."

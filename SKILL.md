---
name: vercel-env-deploy
description: Write Vercel environment variables via REST API, list env, redeploy projects, and bootstrap x402 gateway facilitator/payTo. Triggers on vercel env, set env var, FACILITATOR_URL, deploy vercel, write vercel environment, add env connector.
---

# Vercel Env + Deploy Skill

## What this does
- Sets / upserts project env vars with the Vercel REST API (`POST /v10/projects/{id}/env?upsert=true`)
- Redeploys via connected `vercel___deploy_to_vercel` or CLI
- Defaults for x402-secure-gateway facilitator + payTo

## Required secret
You need a **Vercel token** (Account Settings → Tokens) as `VERCEL_TOKEN`.
Team ID for nic's projects: `team_OKmb59rKdei9pVAPhZW3MwEo`
Gateway project: `x402-secure-gateway` / `prj_m2CSI6kJmB5d6o87n5EUSU0pjKB2`

## One-shot gateway production env
```bash
export VERCEL_TOKEN=...
export TEAM_ID=team_OKmb59rKdei9pVAPhZW3MwEo
export PROJECT=x402-secure-gateway

curl -sS -X POST \
  "https://api.vercel.com/v10/projects/${PROJECT}/env?upsert=true&teamId=${TEAM_ID}" \
  -H "Authorization: Bearer ${VERCEL_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '[
    {"key":"FACILITATOR_URL","value":"https://x402.org/facilitator","type":"plain","target":["production","preview"]},
    {"key":"TREASURY_ADDRESS","value":"0xc22f9CAEBAc37fE72D5142f35f21f6696Ea9Ef69","type":"plain","target":["production","preview"]},
    {"key":"X402_PAY_TO","value":"0xc22f9CAEBAc37fE72D5142f35f21f6696Ea9Ef69","type":"plain","target":["production","preview"]},
    {"key":"X402_NETWORK","value":"eip155:84532","type":"plain","target":["production","preview"]},
    {"key":"PUBLIC_BASE_URL","value":"https://x402-micro-pay.com","type":"plain","target":["production","preview"]}
  ]'
```
Then Redeploy production in the Vercel UI or trigger a new deployment.

## Script
See `scripts/set_env.sh` and `scripts/gateway_bootstrap.sh`.

## Notes
- Connected MCP Vercel tools can **deploy** but cannot write env; this skill fills that gap via REST + token.
- Gateway v1.1.1 also bakes defaults into code so it works even if env is missing.

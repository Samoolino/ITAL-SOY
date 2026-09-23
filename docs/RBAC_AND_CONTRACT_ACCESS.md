# RBAC and Contract Access Model

## Two-layer authority

ITAL-SOY uses two independent authorization layers:

1. SaaS RBAC/data-scope/workflow authorization.
2. On-chain role-based access control.

A frontend permission never substitutes for an on-chain permission.

```text
User → Organization → SaaS Role → Data Scope → Workflow Permission
     → Authorized Signer → On-chain Role → Contract Function → Policy Gate
```

## Roles

| Role | Primary authority | Prohibited combination |
|---|---|---|
| GOVERNANCE_ADMIN | governance, role and policy administration | none; protected by governance policy |
| QA_LEAD | QMS/quality submission and disposition | cannot independently execute funded trades |
| COMPLIANCE_OFFICER | compliance evidence | cannot independently execute funded trades |
| RISK_OFFICER | risk assessment | cannot independently execute funded trades |
| ECONOMIC_ANALYST | economic qualification | cannot authorize treasury execution |
| TRACEABILITY_OFFICER | provenance/batch evidence | cannot authorize treasury execution |
| AUTHORIZER | exact execution authorization | cannot create its own qualifying evidence |
| STRATEGY_OPERATOR | prepare execution intent | cannot grant funding authorization |
| RESERVATION_OPERATOR | treasury reservation/release | cannot alter QA disposition |
| EXECUTOR | execute an already-authorized intent | cannot authorize itself |
| AUDITOR | read and verify | no state-changing authority |
| DEPLOYMENT_ADMIN | deployment/package administration | no business execution authority |

## Contract access boundary

The Contract Access Gateway maps SaaS permissions to permitted contract calls. It performs policy evaluation, evidence checks and transaction simulation before a signer is asked to approve a transaction.

The gateway must not expose unrestricted ABI methods to ordinary application users.

## Data containment

Recommended data classes:

- D0_PUBLIC
- D1_OPERATIONAL
- D2_QMS
- D3_COMPLIANCE
- D4_FINANCIAL
- D5_TRADING
- D6_TREASURY
- D7_SECURITY
- D8_SECRETS

Private keys and secret material are never exposed as SaaS-readable data.

## Remix

Remix is treated as a contract engineering and inspection workspace. Production deployment remains governed by source commit, compiler configuration, artifact hashes, deployment manifest, role wiring, signer policy and governance approval.

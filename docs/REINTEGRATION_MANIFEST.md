# ITAL-SOY / VITAL-SOY Reintegration Manifest

## Objective

ITAL-SOY is the enterprise integration repository. VITAL-SOY is the existing control-plane methodology and contract reference. This branch integrates the validated VITAL-SOY contract patterns into ITAL-SOY while adding the SaaS contract-access boundary.

## Repository responsibilities

| Layer | ITAL-SOY responsibility | VITAL-SOY source |
|---|---|---|
| SaaS control plane | identity, organization, data scope, workflow RBAC, contract gateway | methodology reference |
| QMS / QA | quality evidence, HACCP/CCP disposition | quality-gate methodology |
| Funding eligibility | certificate commitment and lifecycle | FundingEligibilityRegistry |
| Funding access | tiered unlock and backward funding | QualityFundingGate / BackwardFundingController |
| Authorization | exact intent + eligibility + signer + nonce | ExecutionAuthorization |
| Treasury | bounded reservation/release | funding vault methodology |
| Execution | arbitrage primary; commodity/trading auxiliary | engine methodology |
| Audit | automated event chain and on-chain anchoring | audit methodology |
| Verification | Foundry + controlled fork + machine-readable report | verification harness |

## Integration rule

The ITAL-SOY branch must not silently change a VITAL-SOY control invariant. Where enterprise requirements extend a control, the extension must be explicit, versioned and covered by tests.

## Contract-source lineage

Initial integrated contracts are copied from the VITAL-SOY implementation and adapted only where the domain identifier must become ITAL-SOY. Source lineage is recorded in the process/deployment documentation and must be carried into the final deployment manifest.

## SaaS-to-contract authority

```text
SaaS Identity
  -> Organization
  -> Application RBAC
  -> Data classification
  -> Workflow permission
  -> Contract Access Gateway
  -> Authorized signer
  -> On-chain role
  -> Contract policy
  -> State transition
```

Frontend visibility is not contract authority. Contract roles remain the final enforcement boundary.

## Production rule

No live venue, router, commodity or trading adapter is promoted merely because its source exists. It must pass schema validation, process-flow gates, RBAC checks, quality funding checks, authorization, deterministic deployment, unit/invariant tests and controlled-fork verification.

# ITAL-SOY Process Flow Evaluation

## Purpose

This document is the gate review before constructing the institutional contract set. It verifies that each operational transition has a defined actor, data class, evidence requirement, RBAC permission, contract boundary, automated log and failure behavior.

## Stage matrix

| Stage | Actor / service | Required evidence | RBAC | Contract boundary | Automated log | Fail closed |
|---|---|---|---|---|---|---|
| Identity | Identity service | verified organization/user | identity role | access gateway | yes | yes |
| Data intake | designated operator | schema-valid record | scoped role | schema/attestation | yes | yes |
| QA | QA Lead | QMS dataset | QA_LEAD | Quality Control Point | yes | yes |
| HACCP/CCP | QA/Compliance | CCP results | QA/COMPLIANCE | QualityFundingGate | yes | yes |
| Compliance | Compliance Officer | due-diligence evidence | COMPLIANCE_OFFICER | eligibility evidence | yes | yes |
| Risk | Risk Officer | risk assessment | RISK_OFFICER | eligibility evidence | yes | yes |
| Economics | Economic Analyst | deterministic economics | ECONOMIC_ANALYST | execution intent | yes | yes |
| Funding eligibility | control plane | complete certificate | authorized service | FundingEligibilityRegistry | yes | yes |
| Authorization | Authorizer | exact intent + eligibility | AUTHORIZER | ExecutionAuthorization | yes | yes |
| Funding | Treasury | authorized reservation | RESERVATION_OPERATOR | BackwardFundingController/Vault | yes | yes |
| Execution | Executor | exact authorization | EXECUTOR | engine/adapters | yes | yes |
| Settlement | Treasury/settlement | execution receipt | scoped role | settlement controls | yes | yes |
| Reconciliation | finance/QMS | settlement + batch evidence | scoped role | reconciliation boundary | yes | yes |
| Audit | verifier | event/batch hashes | AUDITOR | AuditAnchor | yes | yes |

## Funding gate invariants

1. Required logs are necessary but do not themselves unlock capital.
2. The quality classification must be independently evaluated from the log-presence condition.
3. FULL, CONDITIONAL and MINIMUM are policy-controlled classifications.
4. BLOCKED always produces zero unlockable capital.
5. Funding reservation cannot exceed the quality-gate-approved unlock percentage.
6. Authorization must bind the exact execution intent and funding eligibility commitment.
7. A stale, revoked or expired quality condition prevents new funding.
8. Financial reservations are bounded even when quality-data collection is indefinite.

## Execution exit conditions

A funded execution must define one or more of: target attainment, price condition failure, risk stop, authorization expiry, batch lifespan, quality revocation, treasury reconciliation, or explicit governance closure.

An endless data/QMS workflow is allowed to continue collecting evidence, but it does not imply an endless financial reservation.

## Verification status convention

- `DEFINED` — architecture and acceptance criteria exist.
- `IMPLEMENTED` — source exists in repository.
- `TESTED` — automated test has executed successfully.
- `FORK_VERIFIED` — controlled-fork test has executed and report is retained.
- `PRODUCTION_APPROVED` — governance/deployment approval has been recorded.

A contract must not be treated as production-approved merely because it is implemented.

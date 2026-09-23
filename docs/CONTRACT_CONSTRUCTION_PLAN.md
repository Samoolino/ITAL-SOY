# ITAL-SOY Institutional Contract Construction Plan

The contract set is constructed only after the process-flow evaluation is accepted and the verification harness passes.

## Contract families

### 1. Quality Control Point

Commits the canonical schema/version, evidence root, control-point classification and attestor state for a qualifying dataset.

### 2. Quality Funding Gate

Determines FULL / CONDITIONAL / MINIMUM / BLOCKED funding-access state from required-log completeness and independent HACCP/CCP/QA conditions.

### 3. Funding Eligibility Registry

Commits the complete funding eligibility certificate and provides the immutable eligibility reference used by authorization and funding.

### 4. Backward Funding Controller

Derives required capital from the deterministic economic target and policy, then requests only the quality-gate-approved amount from the vault.

### 5. Treasury / Execution Funding Vault

Holds and reserves bounded execution capital. It does not decide quality eligibility.

### 6. Execution Authorization

Binds execution ID, canonical intent hash, policy, funding eligibility hash, signer, nonce and expiry.

### 7. Audit Anchor

Anchors ordered audit batches for independent verification.

### 8. Primary Arbitrage Boundary

Accepts only authorized execution intents and enforces declared venue/router, minimum-output, deadline and risk constraints.

### 9. Auxiliary Commodity Boundary

Supports commodity observations and execution proposals without bypassing the primary funding and authorization controls.

### 10. Auxiliary Trading Boundary

Supports approved trading strategies through the same authorization/funding/settlement controls.

### 11. Adapter Registry

Defines which routers/venues/assets/executors are approved for a policy and execution intent.

### 12. Settlement/Reconciliation

Records execution receipt, attained result, residual capital, fees and final closure state.

## Construction rule

Each contract must have:

- explicit roles;
- explicit data dependencies;
- explicit state machine;
- deterministic intent/hash boundary;
- event/audit surface;
- failure behavior;
- unit tests;
- invariant tests where applicable;
- controlled-fork acceptance criteria;
- deployment manifest entry;
- upgrade authority declaration;
- independent verification procedure.

No contract is production-approved merely because it compiles.

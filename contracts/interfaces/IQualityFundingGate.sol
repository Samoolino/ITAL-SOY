// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
interface IQualityFundingGate {
    struct GateState { bytes32 batchId; bytes32 requiredLogSetHash; bytes32 qualityEvidenceRoot; bytes32 haccpPlanHash; bytes32 ccpEvidenceRoot; uint8 tier; uint16 unlockBps; uint64 validUntil; bool active; }
    function gateState(bytes32 batchId) external view returns (GateState memory);
    function unlockBps(bytes32 batchId) external view returns (uint16);
    function isUnlockable(bytes32 batchId) external view returns (bool);
}

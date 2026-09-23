// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IFundingEligibilityRegistry {
    struct Certificate {
        bytes32 executionId;
        bytes32 opportunityId;
        bytes32 policyVersion;
        bytes32 qmsEvidenceRoot;
        bytes32 complianceEvidenceRoot;
        bytes32 riskEvidenceRoot;
        bytes32 economicEvidenceRoot;
        bytes32 traceabilityRoot;
        uint256 requiredCapital;
        uint256 maximumLoss;
        uint256 targetNet;
        uint64 expiry;
        uint8 status;
    }
    function certificate(bytes32 eligibilityHash) external view returns (Certificate memory);
    function certificateHash(Certificate calldata x) external pure returns (bytes32);
    function isEligible(bytes32 eligibilityHash, bytes32 executionId, bytes32 policyVersion) external view returns (bool);
}

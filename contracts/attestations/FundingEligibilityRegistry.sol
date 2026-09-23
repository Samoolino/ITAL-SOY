// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../core/AccessControl.sol";
import "../interfaces/IFundingEligibilityRegistry.sol";

contract FundingEligibilityRegistry is AccessControl, IFundingEligibilityRegistry {
    bytes32 public constant ATTESTOR_ROLE = keccak256("ATTESTOR_ROLE");
    uint8 public constant ELIGIBLE = 1;
    uint8 public constant BLOCKED = 2;
    uint8 public constant EXPIRED = 3;
    uint8 public constant CONSUMED = 4;
    uint8 public constant REVOKED = 5;
    bytes32 private constant DOMAIN = keccak256("ITAL-SOY-FUNDING-ELIGIBILITY-V1");
    mapping(bytes32 => Certificate) private _certificates;
    error InvalidCertificate();
    error AlreadyRegistered();
    error InvalidStatus();
    event FundingEligibilityRegistered(bytes32 indexed eligibilityHash, bytes32 indexed executionId, bytes32 indexed opportunityId, bytes32 policyVersion, uint256 requiredCapital, uint256 maximumLoss, uint256 targetNet, uint64 expiry, address actor);
    event FundingEligibilityStatusChanged(bytes32 indexed eligibilityHash, uint8 status, address actor);
    constructor(address admin) AccessControl(admin) {}
    function certificateHash(Certificate calldata x) public pure returns (bytes32) {
        return keccak256(abi.encode(DOMAIN,x.executionId,x.opportunityId,x.policyVersion,x.qmsEvidenceRoot,x.complianceEvidenceRoot,x.riskEvidenceRoot,x.economicEvidenceRoot,x.traceabilityRoot,x.requiredCapital,x.maximumLoss,x.targetNet,x.expiry));
    }
    function register(bytes32 eligibilityHash, Certificate calldata x) external onlyRole(ATTESTOR_ROLE) {
        if (eligibilityHash == bytes32(0) || eligibilityHash != certificateHash(x) || x.executionId == bytes32(0) || x.opportunityId == bytes32(0) || x.policyVersion == bytes32(0) || x.qmsEvidenceRoot == bytes32(0) || x.complianceEvidenceRoot == bytes32(0) || x.riskEvidenceRoot == bytes32(0) || x.economicEvidenceRoot == bytes32(0) || x.traceabilityRoot == bytes32(0) || x.requiredCapital == 0 || x.maximumLoss == 0 || x.targetNet == 0 || x.expiry <= block.timestamp || x.status != ELIGIBLE) revert InvalidCertificate();
        if (_certificates[eligibilityHash].executionId != bytes32(0)) revert AlreadyRegistered();
        _certificates[eligibilityHash] = x;
        emit FundingEligibilityRegistered(eligibilityHash,x.executionId,x.opportunityId,x.policyVersion,x.requiredCapital,x.maximumLoss,x.targetNet,x.expiry,msg.sender);
    }
    function setStatus(bytes32 eligibilityHash, uint8 status) external onlyRole(ATTESTOR_ROLE) {
        if (status < ELIGIBLE || status > REVOKED) revert InvalidStatus();
        Certificate storage c = _certificates[eligibilityHash];
        if (c.executionId == bytes32(0)) revert InvalidCertificate();
        c.status = status;
        emit FundingEligibilityStatusChanged(eligibilityHash,status,msg.sender);
    }
    function certificate(bytes32 eligibilityHash) external view returns (Certificate memory) { return _certificates[eligibilityHash]; }
    function isEligible(bytes32 eligibilityHash, bytes32 executionId, bytes32 policyVersion) external view returns (bool) {
        Certificate memory c = _certificates[eligibilityHash];
        return certificateHash(c) == eligibilityHash && c.executionId == executionId && c.policyVersion == policyVersion && c.status == ELIGIBLE && c.expiry > block.timestamp;
    }
}

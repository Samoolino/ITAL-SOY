// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "../core/AccessControl.sol";
import "../interfaces/IQualityFundingGate.sol";
contract QualityFundingGate is AccessControl, IQualityFundingGate {
    bytes32 public constant QA_ATTESTOR_ROLE = keccak256("QA_ATTESTOR_ROLE");
    uint8 public constant BLOCKED = 0; uint8 public constant MINIMUM = 1; uint8 public constant CONDITIONAL = 2; uint8 public constant FULL = 3;
    uint16 public minimumUnlockBps = 2000; uint16 public conditionalUnlockBps = 5000; uint16 public fullUnlockBps = 10000;
    mapping(bytes32 => GateState) private _gates;
    error InvalidInput(); error InvalidPercentage();
    event UnlockPolicyUpdated(uint16 minimumUnlockBps,uint16 conditionalUnlockBps,uint16 fullUnlockBps,address actor);
    event QualityFundingGateAttested(bytes32 indexed batchId,uint8 indexed tier,uint16 unlockBps,bytes32 requiredLogSetHash,bytes32 qualityEvidenceRoot,bytes32 haccpPlanHash,bytes32 ccpEvidenceRoot,uint64 validUntil,address actor);
    event QualityFundingGateRevoked(bytes32 indexed batchId,address indexed actor);
    constructor(address admin) AccessControl(admin) {}
    function setUnlockPolicy(uint16 minimumBps,uint16 conditionalBps,uint16 fullBps) external onlyRole(ADMIN_ROLE) {
        if (minimumBps == 0 || conditionalBps < minimumBps || fullBps != 10000) revert InvalidPercentage();
        minimumUnlockBps=minimumBps; conditionalUnlockBps=conditionalBps; fullUnlockBps=fullBps;
        emit UnlockPolicyUpdated(minimumBps,conditionalBps,fullBps,msg.sender);
    }
    function attest(bytes32 batchId,bytes32 requiredLogSetHash,bytes32 qualityEvidenceRoot,bytes32 haccpPlanHash,bytes32 ccpEvidenceRoot,bool allLogsPresent,bool allCriticalControlPointsPassed,bool controlPointLogicValid,bool baselineQualityParametersMatched,uint64 validUntil) external onlyRole(QA_ATTESTOR_ROLE) {
        if(batchId==bytes32(0)||requiredLogSetHash==bytes32(0)||qualityEvidenceRoot==bytes32(0)||haccpPlanHash==bytes32(0)||ccpEvidenceRoot==bytes32(0)||validUntil<=block.timestamp) revert InvalidInput();
        uint8 tier; uint16 bps;
        if(allLogsPresent&&allCriticalControlPointsPassed&&controlPointLogicValid&&baselineQualityParametersMatched){tier=FULL;bps=fullUnlockBps;}
        else if(allLogsPresent&&controlPointLogicValid&&baselineQualityParametersMatched){tier=CONDITIONAL;bps=conditionalUnlockBps;}
        else if(allLogsPresent){tier=MINIMUM;bps=minimumUnlockBps;}
        else {tier=BLOCKED;bps=0;}
        _gates[batchId]=GateState(batchId,requiredLogSetHash,qualityEvidenceRoot,haccpPlanHash,ccpEvidenceRoot,tier,bps,validUntil,tier!=BLOCKED);
        emit QualityFundingGateAttested(batchId,tier,bps,requiredLogSetHash,qualityEvidenceRoot,haccpPlanHash,ccpEvidenceRoot,validUntil,msg.sender);
    }
    function revoke(bytes32 batchId) external onlyRole(QA_ATTESTOR_ROLE){GateState storage g=_gates[batchId];if(g.batchId==bytes32(0))revert InvalidInput();g.active=false;g.unlockBps=0;g.tier=BLOCKED;emit QualityFundingGateRevoked(batchId,msg.sender);}
    function gateState(bytes32 batchId) external view returns(GateState memory){return _gates[batchId];}
    function unlockBps(bytes32 batchId) public view returns(uint16){GateState memory g=_gates[batchId];if(!g.active||g.validUntil<=block.timestamp)return 0;return g.unlockBps;}
    function isUnlockable(bytes32 batchId) external view returns(bool){return unlockBps(batchId)>0;}
}

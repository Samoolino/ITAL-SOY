// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
interface IExecutionAuthorization {
    struct Authorization { bytes32 executionId; bytes32 intentHash; bytes32 policyId; bytes32 fundingEligibilityHash; uint256 nonce; uint64 expiresAt; address authorizedSigner; bool approved; }
    function authorization(bytes32 executionId) external view returns (Authorization memory);
    function isAuthorized(bytes32 executionId,bytes32 intentHash,bytes32 policyId,uint256 nonce) external view returns(bool);
    function isAuthorizedFor(bytes32 executionId,bytes32 intentHash,bytes32 policyId,bytes32 fundingEligibilityHash,uint256 nonce,address signer) external view returns(bool);
    function consume(bytes32 executionId,bytes32 intentHash) external;
}

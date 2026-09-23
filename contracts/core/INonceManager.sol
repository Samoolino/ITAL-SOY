// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface INonceManager {
    function currentNonce(address account) external view returns (uint256);
    function consumeNonce(address account, uint256 nonce) external;
}

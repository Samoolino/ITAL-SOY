// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./AccessControl.sol";
import "./INonceManager.sol";

contract NonceManager is AccessControl, INonceManager {
    mapping(address => uint256) private _nonce;
    event NonceConsumed(address indexed account, uint256 indexed nonce);
    error InvalidNonce();
    constructor(address admin) AccessControl(admin) {}
    function currentNonce(address account) external view returns (uint256) { return _nonce[account]; }
    function consumeNonce(address account, uint256 nonce) external onlyRole(ADMIN_ROLE) {
        if (nonce != _nonce[account]) revert InvalidNonce();
        unchecked { _nonce[account] = nonce + 1; }
        emit NonceConsumed(account, nonce);
    }
}

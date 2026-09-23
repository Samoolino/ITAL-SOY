// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../contracts/controllers/QualityFundingGate.sol";

contract QualityFundingGateTest {
    QualityFundingGate private gate;
    bytes32 private constant QA = keccak256("QA_ATTESTOR_ROLE");

    function setUp() public {
        gate = new QualityFundingGate(address(this));
        gate.grantRole(QA, address(this));
    }

    function testFullUnlock() public {
        setUp();
        gate.attest(bytes32(uint256(1)),bytes32(uint256(2)),bytes32(uint256(3)),bytes32(uint256(4)),bytes32(uint256(5)),true,true,true,true,uint64(block.timestamp + 1 days));
        require(gate.unlockBps(bytes32(uint256(1))) == 10000, "full unlock");
    }

    function testConditionalUnlock() public {
        setUp();
        gate.attest(bytes32(uint256(1)),bytes32(uint256(2)),bytes32(uint256(3)),bytes32(uint256(4)),bytes32(uint256(5)),true,false,true,true,uint64(block.timestamp + 1 days));
        require(gate.unlockBps(bytes32(uint256(1))) == 5000, "conditional unlock");
    }

    function testMinimumUnlock() public {
        setUp();
        gate.attest(bytes32(uint256(1)),bytes32(uint256(2)),bytes32(uint256(3)),bytes32(uint256(4)),bytes32(uint256(5)),true,false,false,false,uint64(block.timestamp + 1 days));
        require(gate.unlockBps(bytes32(uint256(1))) == 2000, "minimum unlock");
    }

    function testBlockedWhenLogsMissing() public {
        setUp();
        gate.attest(bytes32(uint256(1)),bytes32(uint256(2)),bytes32(uint256(3)),bytes32(uint256(4)),bytes32(uint256(5)),false,true,true,true,uint64(block.timestamp + 1 days));
        require(gate.unlockBps(bytes32(uint256(1))) == 0, "blocked");
    }
}

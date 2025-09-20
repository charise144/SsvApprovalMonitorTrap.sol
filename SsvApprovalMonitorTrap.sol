// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

interface IERC20 {
    function allowance(address owner, address spender) external view returns (uint256);
}

contract SsvApprovalMonitorTrap is ITrap {
    address public constant SSV_TOKEN = 0x9F5d4Ec84fC4785788aB44F9de973cF34F7A038e;
    address public constant TRUSTED_SPENDER = 0x5AdDb3f1529C5ec70D77400499eE4bbF328368fe;
    address public constant MONITORED_USER = 0xF0179dEC45a37423EAD4FaD5fCb136197872EAd9;
    uint256 public constant APPROVAL_THRESHOLD = 10 * 1e18;
    uint256 public constant RISK_LOW = 0;
    uint256 public constant RISK_MEDIUM = 1;
    uint256 public constant RISK_HIGH = 2;

    mapping(address => uint256) public lastKnownAllowance;

    struct ApprovalData {
        address user;
        address spender;
        uint256 amount;
        uint256 riskLevel;
        uint256 timestamp;
    }

    string constant MESSAGE = "Suspicious SSV approval detected on Hoodi - potential untrusted spender";

    function collect() external view returns (bytes memory) { ... }
    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) { ... }
}

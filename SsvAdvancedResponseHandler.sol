// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SsvAdvancedResponseHandler {
    // Copied from SsvApprovalMonitorTrap.sol to resolve compilation error
    struct ApprovalData {
        address user;
        address spender;
        uint256 amount;
        uint256 riskLevel;
        uint256 timestamp;
    }

    event ApprovalAlert(address indexed user, address indexed spender, uint256 amount, uint256 riskLevel, uint256 timestamp);
    event ReportGenerated(bytes indexed data, string message);

    IncidentReport[] public reports;
    mapping(address => uint256) public reportCount; // Per-user reports

    struct IncidentReport {
        address user;
        address spender;
        uint256 amount;
        uint256 riskLevel;
        uint256 timestamp;
    }

    // Advanced response: Handles message + full ApprovalData
    function handleApprovalAlert(string memory message, bytes calldata encodedData) external {
        (ApprovalData memory data) = abi.decode(encodedData, (ApprovalData));
        emit ApprovalAlert(data.user, data.spender, data.amount, data.riskLevel, data.timestamp);
        
        reports.push(IncidentReport({
            user: data.user,
            spender: data.spender,
            amount: data.amount,
            riskLevel: data.riskLevel,
            timestamp: data.timestamp
        }));
        reportCount[data.user]++;
        
        emit ReportGenerated(encodedData, message);
    }

    // View: Simulate revoke (checks if caller can revoke; actual revoke would be on token)
    function simulateRevoke(address token, address spender) external view returns (bool canRevoke) {
        // Placeholder: In real, check if msg.sender == owner or approved
        canRevoke = true; // Assume yes for PoC
    }

    // Query reports
    function getReportsLength() external view returns (uint256) {
        return reports.length;
    }
}

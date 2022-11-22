// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title FLFIToken
 * @notice FLFI Token for interacting in the federated learning network
 * @dev currently just a wrapper for IERC20 token
 */
contract FLFDToken is IERC20 {
    constructor(uint256 initialSupply) IERC20("Federated Learning on Fashion Image Token", "FLFI") {
        _mint(msg.sender, initialSupply);
    }
}
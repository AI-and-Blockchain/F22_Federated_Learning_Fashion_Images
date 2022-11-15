pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title FLFIToken
 * @notice FLFI Token for interacting in the federated learning network
 * @dev currently just a wrapper for ERC20 token
 */
contract FLFDToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Federated Learning on Fashion Image Token", "FLFI") {
        _mint(msg.sender, initialSupply);
    }
}
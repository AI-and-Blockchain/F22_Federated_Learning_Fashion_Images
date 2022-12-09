// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title Assign Trainer
 * @notice Assign trainers to train models
 * @dev still work in progress
 */

contract Learning{
    bytes32 param;

    constructor() {
        param = 0;
    }

    function update(bytes32 _param) public {
        param = _param;
    }

    function getParam() public view returns (bytes32) {
        // return the parameters
        return param;
    }
}
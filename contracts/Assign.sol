// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title Assign Trainer
 * @notice Assign trainers to train models
 * @dev currently work in progress
 */

contract Assign {
    address public owner;
    // a list of trainers
    address payable[] public trainers;

    constructor() {
        owner = msg.sender;
    }

    function trainerRegister() public {
        // address of trainers entering trainer list
        trainers.push(payable(msg.sender));
    }

    function getRandomNumber() public view returns (uint) {
    	return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickTrainer() public {
    	uint index = getRandomNumber() % trainers.length;
    	// select the trainer here 
    	// trainers[index]

    	// reset the state of the contract
    	trainers = new adress payable[](0);
    }

    // receive dataset from data provider
    // WIP
    //function sendData() public payable{
    //		// reward the data provider
    //		payable(msg.sender).transfer(address(this).balance);
    //}
}
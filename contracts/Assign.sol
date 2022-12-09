// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title Assign Trainer
 * @notice Assign trainers to train models
 * @dev still work in progress
 */

contract Assign{
    address public owner;
    // a list of trainers
    address [] public trainers;
    // a list of data providers
    address [] public dataProviders;
    // the address of the selected trainer
    address public selectedTrainer;
    // the dataset
    bytes32 public dataset;

    constructor() {
        owner = msg.sender;
    }

    // allows user to register as a trainer
    function trainerRegister() public {
        // address of trainers entering trainer list
        trainers.push(payable(msg.sender));
    }

    // allows user to register as a data provider
    function dataProviderRegister() public {
        // address of data provider entering data provider list
        dataProviders.push(payable(msg.sender));
    }

    // generates a random number
    function getRandomNumber() public view returns (uint) {
    	return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    // pick a random trainer from the trainer list
    function pickTrainer() public {
    	uint index = getRandomNumber() % trainers.length;
        selectedTrainer = trainers[index];
    }

    // Allow the data Provider to upload dataset
    function uploadData(bytes32 jsonFile) public{
        //require(dataProviders.indexOf(msg.sender) != -1, "ERROR: You are not a data provider.");
        // store the dataset in the contract
        dataset = jsonFile;
    }

    function getDataset() public view returns (bytes32) {
        // Noly the selected trainer can get the dataset
        require(msg.sender == selectedTrainer, "ERROR: You are not the selected trainer.");

        // return the dataset
        return dataset;
    }
}
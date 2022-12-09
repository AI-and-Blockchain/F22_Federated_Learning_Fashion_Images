// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Assign Trainer
 * @notice Assign trainers to train models
 * @dev still work in progress
 */

contract Assign is Ownable{
    // the reward token
    IERC20 public rewardToken;

    // the reward list
    mapping(address => uint) public rewardList;

    address public owner;
    // a list of trainers
    address payable[] public trainers;
    // a list of data providers
    address payable[] public dataProviders;
    // the address of the selected trainer
    address payable public selectedTrainer;
    // the dataset
    bytes32 public dataset;

    constructor(address tokenAddr) {
        owner = msg.sender;
        rewardToken = IERC20(tokenAddr);
    }

    // set the reward for a data provider
    function setReward(address account)  public {
        rewardList[account] += 1;
    }

    // Allow the data provider to claim the reward
    function claimReward() public{
    	require(rewardList[msg.sender] > 0, "ERROR: You don't have any rewards to claim for now.")
        uint256 reward = rewardList[msg.sender];
        rewardList[msg.sender] = 0;
        rewardsToken.transfer(msg.sender, reward);
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
        require(dataProvider.indexOf(msg.sender) >= 0, "ERROR: You are not a data provider.");
        
        // store the dataset in the contract
        dataset = jsonFile;

        // pay the data provider
        setReward(msg.sender);
    }

    function getDataset() public view returns (bytes32) {
        // Noly the selected trainer can get the dataset
        require(msg.sender == selectedTrainer, "ERROR: You are not the selected trainer.");

        // return the dataset
        return dataset;
    }
}
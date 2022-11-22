// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


/**
 * @title Reward
 * @notice Reward smart contract for interacting in the federated learning network
 * @dev need to call setReward() from FL smart contract based on contributor type
 */
 
contract Reward is Ownable {
    IERC20 public rewardToken;

    mapping(address => uint) public rewardList;

    constructor(address tokenAddr) {
        rewardToken = IERC20(tokenAddr);
    }

    function setReward(address account, uint256 amount)  public onlyOwner  {
        rewardList[account] = amount;
    }

    function claimReward() public{
    	require(rewardList[msg.sender] > 0, "ERROR: You don't have any rewards to claim for now.")
        uint256 reward = rewardList[msg.sender];
        rewardList[msg.sender] = 0;
        rewardsToken.transfer(msg.sender, reward);
    }
}
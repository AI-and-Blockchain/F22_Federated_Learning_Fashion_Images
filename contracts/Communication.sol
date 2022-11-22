// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
contract Communication {
	event BCEvent(
		uint256 timestamp,
		bool is_encrypted,
		bytes event_type,
	bytes body
	);

	function publish(
		uint256 timestamp,
		bool is_encrypted,
		bytes memory event_type,
		bytes memory body
	) public returns(uint ack) { }
}

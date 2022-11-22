// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
contract Contribution {
	uint len = 5; //5 federated clients
	uint[] memory _clients = new uint[](5);

	function set_contribution(
		uint client_id,
		uint relative_contribution
	) public returns(uint ack) {
	//only owner(federated server)
	//modifies state of _clients
	}

	function get_contributions()
	public view returns (uint memory) { } }
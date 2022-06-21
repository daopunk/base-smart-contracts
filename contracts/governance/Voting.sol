// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Voting {
	enum Choices { Yes, No }
	Vote[] public votes;
	
	struct Vote {
		Choices choice;
		address voter;
	}
	
	function createVote(Choices choice) external {
		require(!hasVoted(msg.sender));
		votes.push(Vote(choice, msg.sender));
	}

	function hasVoted(address addr) public view returns(bool b) {
		for (uint i=0; i<votes.length; i++) {
			if (votes[i].voter == addr) b = true;
		}
	}

	function findChoice(address addr) external view returns(Choices c) {
		for (uint i=0; i<votes.length; i++) {
			if (votes[i].voter == addr) c = votes[i].choice;
		}
	}

	function changeVote(Choices c) external {
		for (uint i=0; i<votes.length; i++) {
			if (votes[i].voter == msg.sender) votes[i].choice = c;
		}
	}
}
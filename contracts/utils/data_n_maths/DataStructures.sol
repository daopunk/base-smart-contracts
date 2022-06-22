// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract DataStructures {

  // mappings
  mapping(address => bool) public members;

  function addMember(address addr) external {
    members[addr] = true;
  }
  
  function isMember(address addr) external view returns(bool b) {
    b = members[addr];
  }

  function removeMember(address addr) external {
    members[addr] = false;
  }

  // mappings with structs
  struct User {
		uint balance;
		bool isActive;
	}

	mapping(address => User) public users;

	function createUser() external {
		require(!users[msg.sender].isActive);
		users[msg.sender] = User(100, true);
	}

	function transfer(address addr, uint amount) external {
		require(users[addr].isActive && users[msg.sender].isActive);
		require(users[msg.sender].balance >= amount);

		users[msg.sender].balance -= amount;
		users[addr].balance += amount;
	}

  // nested mappings
  	enum ConnectionTypes { 
		Unacquainted,
		Friend,
		Family
	}
	
	mapping(address => mapping(address => ConnectionTypes)) public connections;

	function connectWith(address other, ConnectionTypes connectionType) external {
		connections[msg.sender][other] = connectionType;
	}

  // array
  address[] club;

  constructor() {
    club.push(msg.sender);
  }

  function isMemberOfClub(address addr) public view returns(bool b) {
    for (uint i=0; i<club.length; i++) {
      if (club[i]==addr) b = true;
    }
  }

  function addMemberToClub(address addr) external {
    require(isMemberOfClub(msg.sender));
    club.push(addr);
  }

  function removeLastMemberOfClub() external {
    require(isMemberOfClub(msg.sender));
    club.pop();
  }
}
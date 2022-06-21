//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Governance {
  Proposal[] public proposals;
  address[] public authMap;
  enum VoteStates {A,Y,N}
  uint proposalId;

  event ProposalCreated(uint _propId);
  event VoteCast(uint _propId, address _voter);

  struct Proposal {
    address creator;
    string question;
    uint yesCount;
    uint noCount;
    mapping(address => VoteStates) voterState;
  }

  constructor(address[] memory authMaporizedVoters) {
    authMap = authMaporizedVoters;
    authMap.push(msg.sender);
  }

  function authMaporized(address addr) internal view returns(bool b) {
    for (uint i=0; i<authMap.length; i++) {
        if (addr == authMap[i]) b = true;
    }
  }
  
  function newProposal(string calldata _question) external {
    require(authMaporized(msg.sender));
    emit ProposalCreated(proposalId);
    proposalId++;
    
    Proposal storage prop = proposals.push();
    prop.creator = msg.sender;
    prop.question = _question;
  }

  function castVote(uint _propId, bool _vote) external {
    require(authMaporized(msg.sender));
    emit VoteCast(_propId, msg.sender);
    Proposal storage prop = proposals[_propId];

    if (prop.voterState[msg.sender] == VoteStates.Y) prop.yesCount--;
    if (prop.voterState[msg.sender] == VoteStates.N) prop.noCount--;


    if (_vote) {
        prop.yesCount++;
        prop.voterState[msg.sender] = VoteStates.Y;

    } else {
        prop.noCount++;
        prop.voterState[msg.sender] = VoteStates.N;
    }
  }
}
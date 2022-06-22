// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract DeadSwitch {
    address payable recipient;
    address public owner;
    uint public initTime;

    constructor(address payable _recipient) payable {
        owner = msg.sender;
        recipient = _recipient;
        initTime = block.timestamp;
    }

    function withdraw() external {
        require(block.timestamp >= initTime + 52 weeks);
        recipient.transfer(address(this).balance);
    }

    function ping() external {
        require(msg.sender == owner);
        initTime = block.timestamp;
    }
}
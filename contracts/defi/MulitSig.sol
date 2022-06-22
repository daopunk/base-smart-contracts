// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MultiSig {
    address[] public owners;
    uint public required;
    uint public transactionCount;

    constructor(address[] memory _owners, uint256 majority) {
        require(_owners.length > 0, "no owners");
        require(majority > 0, "no majority specified");
        require(majority < _owners.length, "majority overflow");
        owners = _owners;
        required = majority;
    }

    struct Transaction {
        address payable dest;
        uint value;
        bool executed;
        bytes data;
    }

    mapping(uint => Transaction) public transactions;
    mapping(uint => mapping(address => bool)) public confirmations;

    function addTransaction(address payable _dest, uint _value, bytes memory data) internal returns (uint transactionId) {
        transactionId = transactionCount;
        transactions[transactionCount] = Transaction(_dest, _value, false, data);
        transactionCount += 1;
    }

    function submitTransaction(address payable _dest, uint _value, bytes memory data) public {
        uint transactionID = addTransaction(_dest, _value, data);
        confirmTransaction(transactionID);
    }

    function confirmTransaction(uint _transactionID) public {
        require(isOwner(msg.sender), "not authorized");
        confirmations[_transactionID][msg.sender] = true;

        if(isConfirmed(_transactionID)) executeTransaction(_transactionID);
    }

    function getConfirmationsCount (uint _transactionID) public view returns (uint c) {
        uint count;
        for (uint i=0; i < owners.length; i++) {
            if (confirmations[_transactionID][owners[i]]) count++;
        }
        c = count;
    }

    function isConfirmed(uint _transactionID) public view returns(bool b) {
        b = (getConfirmationsCount(_transactionID) >= required);
    }

    function executeTransaction(uint _transactionID) public {
        require(isConfirmed(_transactionID));
        Transaction storage _tx = transactions[_transactionID];
        // _tx.dest.transfer(_tx.value);

        (bool success, ) = _tx.dest.call{ value: _tx.value }(_tx.data);
        require(success);

        _tx.executed = true;
    }

    function isOwner(address addr) private view returns(bool) {
        for(uint i = 0; i < owners.length; i++) {
            if(owners[i] == addr) return true;
        }
        return false;
    }

    receive() payable external {}
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract BasicOperations {
  uint count;
  uint[] public evenNumbers;

  constructor(uint _count) {
    count = _count;
  }

  function sumAndAverage(uint a, uint b, uint c, uint d) external pure returns(uint sum, uint average) {
    sum = a+b+c+d;
    average = sum/4;
  }

  function sum(uint[] memory array) external pure returns(uint s) {
    for(uint i = 0; i < array.length; i++) {
      s += array[i];
    }
  }

  function countToSelfDestruct() public {
    if(count == 1) {
      selfdestruct(payable(msg.sender));
    }
    count--;
  }

  // filter to storage
  function filterEvenStorage(uint[] memory nums) external {
    for(uint i=0; i<nums.length; i++) {
      if (nums[i]%2==0) {
        evenNumbers.push(nums[i]);
      }         
    }
  }

  // filter to memory
  function filterEvenMem(uint[] memory nums) external pure returns(uint[] memory n) {
    uint counter;
    for (uint i=0; i<nums.length; i++) {
      if (nums[i]%2==0) counter++;
    }

    n = new uint[](counter);

    uint j=0;
    for (uint i=0; i<nums.length; i++) {
      if (nums[i]%2==0) {
        n[j] = nums[i];
        j++;
      } 
    }
  }
}
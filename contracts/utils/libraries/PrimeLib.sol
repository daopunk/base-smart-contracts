// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

library Prime {
  function dividesEvenly(uint a, uint b) pure public returns (bool c) {
    c = a % b == 0 ? true : c;
  }

  function isPrime(uint a) pure external returns (bool c) {        
    for (uint i=2; i<= a/2; i++) {
        if (dividesEvenly(a,i)) return c;
    }
    c = true;
  }
}
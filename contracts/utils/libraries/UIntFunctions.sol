// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

library UIntFunctions {
    function isEven(uint num) public pure returns (bool b) {
        if (num % 2 == 0) b = true;
    }
}
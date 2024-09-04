// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Called {

    uint number;

    function getNumber() external view returns (uint) {
        return number;
    }

    function setNumber(uint _number) external {
        number = _number;
    }
}
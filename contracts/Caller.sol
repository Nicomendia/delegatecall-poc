// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
import "hardhat/console.sol";

contract Caller {
    uint public number;
    address public called;

    constructor(address called_) {
        called = called_;
    }

    function callSetNumber(uint _number) external {
        bool success;
        bytes memory returndata;

        (success, ) = called.delegatecall(abi.encodeWithSignature("setNumber(uint256)",_number));
        require(success, "Delegate call failed");

        (success, returndata) = called.staticcall(abi.encodeWithSignature("getNumber()"));
        require(success, "Static call failed");

        // This one prints the number settled in the called contract
        console.log(uint(abi.decode(returndata, (uint))));
        // This one prints the number settled in this contract
        console.log(number);
    }
}
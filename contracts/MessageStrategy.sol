// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {LibDataTransfer} from "./LibDataTransfer.sol";
// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract MessageStrategy {

    function createArgs(
        LibDataTransfer.TransferData calldata transferData_,
        bytes calldata extraOptionalArgs_
    ) external pure returns (bytes32 dAppId, uint256 serviceFeeAmount, bytes memory providerArgs) {
        // Mocked values used for tests purpose only
        uint256 feeFactor = 3 * (10 ** 18) / 100; // 3% fee factor
        dAppId = keccak256('ERC20-example-dApp');
        serviceFeeAmount = transferData_.amount_ * feeFactor;
        providerArgs = abi.encode(transferData_.targetChainId_, transferData_.receiver_, extraOptionalArgs_);
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {LibDataTransfer} from "./LibDataTransfer.sol";
// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Erc20Router {
    address strategyContractAddress;

    constructor(address strategyContractAddress_) {
        strategyContractAddress = strategyContractAddress_;
    }

    function handleStrategy(
        LibDataTransfer.TransferData calldata transferData_,
        bytes calldata extraOptionalArgs_
    ) external view returns (bytes32 dAppId, uint256 serviceFeeAmount, bytes memory providerArgs) {
        bytes memory data = abi.encodeWithSignature(
            "createArgs((uint8,address,address,uint256,bytes),bytes)",
            transferData_,
            extraOptionalArgs_
        );

        (bool success, bytes memory returndata) = strategyContractAddress.staticcall(data);
        require(success, "Static call failed");

        (dAppId, serviceFeeAmount, providerArgs) = abi.decode(returndata, (bytes32, uint256, bytes));
    }
}
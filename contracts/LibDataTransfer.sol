// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

library LibDataTransfer {
    struct TransferData {
        uint8 targetChainId_;
        address feeToken_;
        address token_;
        uint256 amount_;
        bytes receiver_;
    }
}
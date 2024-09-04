import {
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("Erc20Router", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployFixture() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await hre.ethers.getSigners();

    const MessageStrategy = await hre.ethers.getContractFactory("MessageStrategy");
    const messageStrategy = await MessageStrategy.deploy();

    const Erc20Router = await hre.ethers.getContractFactory("Erc20Router");
    const erc20Router = await Erc20Router.deploy(messageStrategy.getAddress());

    return { messageStrategy, erc20Router, owner, otherAccount };
  }

  describe("Router", function () {
    const targetChainId = 2;
    const amount = hre.ethers.parseEther('100');
    const feeFactor = hre.ethers.parseEther('0.03'); // 3% fee factor
    const addressZero = hre.ethers.ZeroAddress;

    const transferData = {
      targetChainId_: targetChainId,
      feeToken_: addressZero,
      token_: addressZero,
      amount_: amount,
      receiver_: addressZero,
    };

    it("Should get arguments for the erc20Router contract", async function () {
      const { erc20Router } = await loadFixture(
        deployFixture
      );

      const { dAppId, serviceFeeAmount, providerArgs } = await erc20Router.handleStrategy(
        transferData,
        '0x' // extraOptionalArgs
      );

      console.log("test - dAppId: ", dAppId);
      console.log("test - serviceFeeAmount: ", serviceFeeAmount);
      console.log("test - providerArgs: ", providerArgs);

      expect(serviceFeeAmount).to.equal(amount * feeFactor);
    });
  });
});

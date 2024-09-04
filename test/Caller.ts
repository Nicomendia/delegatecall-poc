import {
    loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("Caller", function () {
    // We define a fixture to reuse the same setup in every test.
    // We use loadFixture to run this setup once, snapshot that state,
    // and reset Hardhat Network to that snapshot in every test.
    async function deployFixture() {
      // Contracts are deployed using the first signer/account by default
      const [owner, otherAccount] = await hre.ethers.getSigners();

      const Called = await hre.ethers.getContractFactory("Called");
      const called = await Called.deploy();

      const Caller = await hre.ethers.getContractFactory("Caller");
      const caller = await Caller.deploy(called.getAddress());

      return { called, caller, owner, otherAccount };
    }

    describe("Set Number", function () {
        it("Should set number to the caller contract", async function () {
            const { caller } = await loadFixture(
              deployFixture
            );

            await caller.callSetNumber(7);

            expect(await caller.number()).to.equal(7);
          });
    });
});

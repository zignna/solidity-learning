import hre from "hardhat";
import { expect } from "chai";
import { MyToken } from "../typechain-types";

describe("mytoken deploy", () => {
  let myTokenC: MyToken;
  let signers: HardhatEthersSigner[];
  before("should deploy", async () => {
    myTokenC = await hre.ethers.deployContract("MyToken", [
      "MyToken",
      "MT",
      18,
    ]);
  });
  it("should return", async () => {
    expect(await myTokenC.name()).equal("MyToken");
  });
  it("should return", async () => {
    expect(await myTokenC.symbol()).equal("MT");
  });
  it("should return", async () => {
    expect(await myTokenC.decimals()).equal(18);
  });
  it("should return 0 totalSupply", async () => {
    expect(await myTokenC.totalSupply()).equal(0);
  });
  it("should return 0 balance for signer 0", async () => {
    const signers = await hre.ethers.getSigners();
    expect(await myTokenC.balanceOf(signers[0].address)).equal(0);
  });
});

import { ethers, run, network } from "hardhat";

const wormholeRelayer = network.name == "goerli" ? "0x28D8F1Be96f97C1387e94A53e00eCcFb4E75175a" : "0x0591C25ebd0580E0d4F27A82Fc2e24E7489CB5e0"

async function main() {
  const regsitry = await ethers.deployContract("Registry");

  await regsitry.waitForDeployment();

  console.log("Registry deployed to:", await regsitry.getAddress());

  const nebula = await ethers.deployContract("Nebula", [await regsitry.getAddress(), wormholeRelayer]);

  console.log("Nebula deployed to:", await nebula.getAddress());

  try {
    await run("verify:verify", {
      address: await regsitry.getAddress(),
      constructorArguments: [],
    });
  } catch (error) {
    console.log(error);
  }

  try {
    await run("verify:verify", {
      address: await nebula.getAddress(),
      constructorArguments: [await regsitry.getAddress(), wormholeRelayer],
    });
  } catch (error) {
    console.log(error);
  }

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

import { ethers, run } from "hardhat";

async function main() {
  const regsitry = await ethers.deployContract("Registry");

  await regsitry.waitForDeployment();

  console.log("Registry deployed to:", await regsitry.getAddress());

  const nebula = await ethers.deployContract("Nebula", [await regsitry.getAddress()]);

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
      constructorArguments: [await regsitry.getAddress()],
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

import { ethers, run } from "hardhat";

async function main() {
    const atom = await ethers.deployContract("ENSAtom", ["0x5c3EBd455a7844b9A701A0E4685F0C02a522E421"]);

    await atom.deploymentTransaction()?.wait(3);

    console.log("Atom deployed to:", await atom.getAddress());

    try {
        await run("verify:verify", {
            address: await atom.getAddress(),
            constructorArguments: ["0x5c3EBd455a7844b9A701A0E4685F0C02a522E421"],
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

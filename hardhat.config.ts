import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import { config as dotenv } from "dotenv";

dotenv();

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_URL as string,
      accounts: [process.env.PRIVATE_KEY as string],
    },
    zkEVM: {
      url: process.env.ZKEVM_URL as string,
      accounts: [process.env.PRIVATE_KEY as string],
    },
    goerli: {
      url: process.env.GOERLI_URL as string,
      accounts: [process.env.PRIVATE_KEY as string],
    },
    optimismGoerli: {
      url: process.env.OPTIMISM_GOERLI_URL as string,
      accounts: [process.env.PRIVATE_KEY as string],
    },
    mumbai: {
      url: process.env.MUMBAI_URL as string,
      accounts: [process.env.PRIVATE_KEY as string],
    },
  },
  etherscan: {
    apiKey: {
      sepolia: process.env.ETHERSCAN_KEY as string,
      zkEVM: process.env.POLYGONSCAN_KEY as string,
      optimisticGoerli: process.env.OPTIMISM_KEY as string,
      polygonMumbai: process.env.POLYGONSCAN_KEY as string,
      goerli: process.env.ETHERSCAN_KEY as string,
    },
    customChains: [
      {
        network: "zkEVM",
        chainId: 1422,
        urls: { apiURL: "https://api-testnet-zkevm.polygonscan.com/api", browserURL: "https://testnet-zkevm.polygonscan.com/" }
      }
    ]
  },
};

export default config;



/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.9",
    defaulNetwork: 'sepolia',
    networks:{
      hardhat: {},
      sepolia: {
        url: 'https://sepolia.rpc.thirdweb.com/15065ae3c21e0bff07eaf80b713a6ef0',
        accounts: [`0x${process.env.PRIVATE_KEY}`]
      }
    },
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};

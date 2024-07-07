module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545, // Match the port of your local blockchain (e.g., Ganache)
      network_id: "*", // Match any network id
      gas: 6721975, // Adjust gas limit if needed
      gasPrice: 20000000000, // Adjust gas price if needed
    },
  },
  compilers: {
    solc: {
      version: "0.8.0", // Ensure this matches the version specified in the contract
    },
  },
};

const XuluCoinContract = artifacts.require("XuluCoinContract");

module.exports = function (deployer) {
  deployer.deploy(XuluCoinContract);
};

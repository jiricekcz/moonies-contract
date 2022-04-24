/**
 * Determines whether or not to deploy truffle migrations.  
 * **WARNING:** This will cost additional gas if enabled.
 * @type {boolean}
 */
const DEPLOY_MIGRATIONS = false;


const Migrations = artifacts.require("Migrations");

module.exports = function (deployer) {
    if (!DEPLOY_MIGRATIONS) return;
    deployer.deploy(Migrations);
};

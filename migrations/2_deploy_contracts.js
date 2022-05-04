/**
 * An array including the names of all the contracts to be deployed.  
 * **Only** modify this.
 * @type {Array<string>}
 * @example 
 * const CONTRACT_NAMES = ["MyNFT", "MyContract", "MyOtherContract"];
 */
const CONTRACT_NAMES = ["Moonies"];


const contracts = CONTRACT_NAMES.map(name => artifacts.require(`./${name}`));


module.exports = function(deployer) {
    contracts.forEach(v => deployer.deploy(v));
    // Additional contracts can be deployed here
};
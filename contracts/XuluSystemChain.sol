// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

contract XuluSystemChain {
    address owner;
    uint fortune;
    bool isDeceased;

    address payable[] familyWallets;
    mapping (address => uint) inheritance;

    constructor() public payable {
        owner = msg.sender;
        fortune = msg.value;
        isDeceased = false;
    }

    modifier onlyOwner {
        require (msg.sender == owner, "This function is for owner only");
        _;
    }

    modifier mustBeDeceased {
        require (isDeceased == true, "Owner must be deceased!");
        _;
    }

    function getOwnerName() view public returns (address) {
        return owner;
    }

    function setInherintance(address payable wallet, uint inheritanceAmount) public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet] = inheritanceAmount;
    }

    function getWallets() view public mustBeDeceased returns (address payable[] memory) {
        return familyWallets;
    }

    function getInheritanceAmount(address own) view public mustBeDeceased returns (uint) {
        return inheritance[own];
    }

    function payout() private mustBeDeceased {
        for (uint index = 0; index < familyWallets.length; index++) {
            familyWallets[index].transfer(inheritance[familyWallets[index]]);
        }
    }

    function deceased() public onlyOwner {
        isDeceased = true;
        payout();
    }
}
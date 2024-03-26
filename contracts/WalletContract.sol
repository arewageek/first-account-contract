// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Wallet {
    address private _owner;
    uint public balance;

    constructor(){
        _owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value > 0, "Zero ethers tranaction not allowed");
        balance += msg.value;
    }

    function withdraw(uint amount) public {
        require(msg.sender == _owner, "Only owner can withdraw funds");
        require(amount >= balance, "Insufficient Funds");
        balance -= amount;
    }

    function transferOwnership(address _newOwner) public {
        require(msg.sender == _owner, "Access denied!");
        _owner = _newOwner;
    }
}
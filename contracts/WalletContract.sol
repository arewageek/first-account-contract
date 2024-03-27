// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Wallet {
    address public _owner;
    uint public balance;
    address public _backupAccount;


    constructor(address backupAccount){
        _owner = msg.sender;
        _backupAccount = backupAccount;
    }


    modifier OnlyOwner {
        require (msg.sender == _owner);
        _;
    }


    function deposit() public payable OnlyOwner {
        require(msg.value > 0, "Zero ethers tranaction not allowed");
        balance += msg.value;
    }

    function withdraw() public OnlyOwner {
        require(msg.sender == _owner, "Access denied");
        (bool success,) = _owner.call{ value: address(this).balance }("");
        require(success, "Failed");
    }

    function transfer(uint amount) public OnlyOwner {
        require(msg.sender == _owner, "Only owner can withdraw funds");
        require(amount >= balance, "Insufficient Funds");
        ( bool success, ) = _owner.call{ value: address(this).balance } ("");
        require(success, "Failed");
    }

    function transferOwnership(address _newOwner) public OnlyOwner {
        require(msg.sender == _owner, "Access denied!");
        _owner = _newOwner;
    }

    function recoverAccount(address _newBackupAccount) public {
        require(msg.sender == _backupAccount, "Access denied");
        _owner = _backupAccount;
        _backupAccount = _newBackupAccount;
    }

    function changeBackupAccount ( address _newBackupAccount) public OnlyOwner {
        require (msg.sender == _owner);
        _backupAccount = _newBackupAccount;
    }
}
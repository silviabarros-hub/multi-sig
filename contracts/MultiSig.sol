// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MultiSig {
    address[] public owners;
    uint public required;
    uint public transactionCount;

    struct Transaction {
        address recipient;
        uint amount;
        bool executed;
        bytes data;
    }

    mapping(uint => Transaction) public transactions;
    mapping(uint => mapping(address => bool)) public confirmations;

    receive() external payable {

    }

    function executeTransaction(uint transactionID) public {
        require(isConfirmed(transactionID));

        Transaction storage _tx = transactions[transactionID]; 
    
        (bool s1, ) = _tx.recipient.call{value: _tx.amount}(_tx.data);
        require(s1);
        _tx.executed = true;
    }

    function isConfirmed(uint transactionID) public view returns(bool) {
        if(getConfirmationsCount(transactionID) >= required)
        return true;
        return false;
    }

    function submitTransaction(address _recipient, uint _amount, bytes memory _data) external {
        uint transactionID = addTransaction(_recipient, _amount, _data);
        confirmTransaction(transactionID);
    }

    function isOwner(address _address) internal view returns(bool){
        for(uint i = 0; i < owners.length; i++) {
            if(owners[i] == _address){
                return true;
            }
        }

        return false;
    }

    function confirmTransaction(uint transactionID) public {
        require(isOwner(msg.sender));

        confirmations[transactionID][msg.sender] = true;  

        if(isConfirmed(transactionID)){
            executeTransaction(transactionID);
        }     
    }

    function getConfirmationsCount(uint transactionID) public view returns(uint counts) {        
        for(uint i = 0; i < owners.length; i++){
            if(confirmations[transactionID][owners[i]] == true) {
                counts++;
            }
        }
        return counts;
    }

    function addTransaction(address _recipient, uint _amount, bytes memory _data) internal returns(uint transactionID) {
        transactionID = transactionCount;
        transactions[transactionCount] = Transaction(_recipient, _amount, false, _data);
        transactionCount++;
        return transactionID;
    }

    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0);
        require(_required > 0);
        require(_owners.length > _required);
        
        owners = _owners;
        required = _required;
    }
}

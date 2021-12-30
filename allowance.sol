pragma solidity ^0.5.13;

contract allowance {

    uint public balance;
    uint public allowanceLimit ;

    mapping(address => uint) public allowances;

    function deposit() public payable {
        // owner check
        balance += msg.value;
    }

    function withdraw(uint amount) public {
        address payable to = msg.sender;
        to.transfer(amount);
        balance -= amount;
    }

    function setAllowance(uint limit ) public {
        // owner check
        allowanceLimit = limit;
    }
}
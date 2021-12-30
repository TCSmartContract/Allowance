pragma solidity ^0.5.13;

contract allowance {

    address payable owner;
    uint public balance;
    uint public allowanceLimit ;

    mapping(address => uint) public allowances;

    constructor() public {
        owner = msg.sender;
    }

    function deposit() public payable {
        // owner check
        require(msg.sender == owner, "You are not the owner");
        balance += msg.value;
    }

    function withdraw(uint amount) public {
        //check address
        //if address is deployer withdraw unlimited
        //else withdraw is amount <= allowance
        address payable to;

        if ( msg.sender == owner ) {
            require( amount <= balance, "contract doesn't have enough funds");
            to = owner;
        } else {
            require( allowances[msg.sender] + amount <= allowanceLimit, "amount exceeds allowed allowance");
            require( amount <= balance, "contract doesn't have enough funds");
            to = msg.sender;
        }

        to.transfer(amount);                
        allowances[to] += amount;
        balance -= amount;


    }

    function setAllowance(uint limit ) public {
        // owner check
        allowanceLimit = limit;
    }
}
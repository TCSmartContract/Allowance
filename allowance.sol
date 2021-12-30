pragma solidity ^0.5.13;

contract Allowance {
    
    event WithDrawEvent(address indexed _from, uint indexed oldAmount, uint newAmount);

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
        address payable to;

        if ( msg.sender == owner ) {
            require( amount <= balance, "contract doesn't have enough funds");
            to = owner;
        } else {
            require( allowances[msg.sender] + amount <= allowanceLimit, "amount exceeds allowed allowance");
            require( amount <= balance, "contract doesn't have enough funds");
            to = msg.sender;
        }

        emit WithDrawEvent(msg.sender, allowances[to], allowances[to]+amount);

        to.transfer(amount);                
        allowances[to] += amount;
        balance -= amount;


    }

    function setAllowance(uint limit ) public {
        // owner check
        allowanceLimit = limit;
    }
}
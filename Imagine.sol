pragma solidity ^0.8.4;

//SPDX-License-Identifier: UNLICENSED

contract Token as SafeMath { //Implement SafeMath library
    uint public totalSupply = ;
    string public constant name = ;
    string public constant symbol = ;
    uint8 public constant decimals = ;  
    
    //^^^ all intuitive meanings


    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value); //NEED TO ADD EVENTS TO APPROVE TRANSFERFROM FUNCTION
    //the 2 needed events for sending/recieving tokens
    
    mapping(address => uint) public balance;
    mapping(address => mapping(address => uint)) public allowance;
    mapping(address => mapping(address => mapping(address => uint256)))
    //necessary for finding balances/allowances of accounts


    constructor() {  
	balance[msg.sender] = totalSupply; //multiplied by some value to decide how much goes to burn pool/owner pools/other pools
	//balance[] = totalSupply*xx; same thing as above ^ add address for a certain pool
	// can add more for starting pools
    }  
    
    function balanceOf(address addr) public view returns (uint) { //returns balance of given address
        return balance[addr];
    }

    function transfer(address to, uint value) public returns (bool) { //NEED TO ADD HOW MUCH GOES INTO DIFFERENT POOL WITH EACH TRANSACTION
        if (balanceOf(msg.sender) >= value) {
            balance[msg.sender] -= value;
            balance[to] += value;
            emit Transfer(msg.sender, to, value);
            return true;
        }
        return false;
    }
    
    function transferFrom(address from, address to, uint value) public returns (bool) { //NEED TO ADD HOW MUCH GOES INTO DIFFERENT POOL WITH EACH TRANSACTION
        if (allowance[from][msg.sender] > value) {
            balance[from] -= value;
            balance[to] += value;
            emit Approval(from, to value);
            emit Transfer(from, to, value);
            return true;
        }
        return false;
    }

    function approve(address user, uint value) public returns (bool) {
        allowance[msg.sender][user] = value;
        emit Approval(msg.sender, user, value);
        return true;
    }

    function userAllowance(address owner, address user) public returns (uint) {
        return allowance[owner][user];
    }
}



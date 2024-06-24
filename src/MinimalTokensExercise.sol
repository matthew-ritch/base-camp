// SPDX-License-Identifier: UNLICENSED
// Use the --constructor-args flag to pass arguments to the constructor:
// https://book.getfoundry.sh/forge/deploying
pragma solidity ^0.8.13;

contract UnburnableToken {
    mapping (address => uint) public balances;
    uint public totalSupply;
    uint public totalClaimed;
    address[] claimants;

    constructor () {
        totalSupply = 100000000;
    }

    error TokensClaimed();
    error AllTokensClaimed();

    function claim () public {
        if (totalClaimed >= totalSupply) {
            revert AllTokensClaimed();
        }
        for (uint i; i<claimants.length; i++) {
            if (claimants[i] == msg.sender) {
                revert TokensClaimed();
            }
        }
        claimants.push(msg.sender);
        balances[msg.sender] += 1000;
        totalClaimed += 1000;
    }

    error UnsafeTransfer(address);

    function safeTransfer(address _to, uint _amount) public {
        if ((_to == address(0x0)) || (_to.balance == 0)) {
            revert UnsafeTransfer(_to);
        }
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }

}
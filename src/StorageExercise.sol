// SPDX-License-Identifier: UNLICENSED
// Use the --constructor-args flag to pass arguments to the constructor:
// https://book.getfoundry.sh/forge/deploying
pragma solidity ^0.8.13;

contract EmployeeStorage {
    uint16 private shares;
    uint24 private salary;
    string public name;
    uint256 public idNumber;

    constructor(uint16 _shares, string memory _name, uint24 _salary, uint256 _idNumber) {
        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
    }

    function viewSalary() public returns(uint24) {
        return salary;
    }

    function viewShares() public returns(uint16) {
        return shares;
    }

    error TooManyShares(uint16);

    function grantShares(uint16 _newshares) public {
        if (_newshares > 5000) {
            revert("Too many shares");
        }
        if ((_newshares + shares) > 5000) {
            revert TooManyShares(_newshares + shares);
        }
        shares += _newshares;
    }

    /**
    * Functions for contract checking
    */

    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload (_slot)
        }
    }
    
    function debugResetShares() public {
        shares = 1000;
    }

}

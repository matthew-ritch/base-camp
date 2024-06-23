// SPDX-License-Identifier: UNLICENSED
// Use the --constructor-args flag to pass arguments to the constructor:
// https://book.getfoundry.sh/forge/deploying
pragma solidity ^0.8.13;

abstract contract employee { 
    uint public idNumber;
    uint public managerId;

    constructor(uint _idNumber, uint _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }

    function getAnnualCost() public virtual returns(uint);
}

contract Salaried is employee {
    uint public annualSalary;

    constructor(uint _idNumber, uint _managerId, uint _annualSalary) employee(_idNumber, _managerId) {
        annualSalary = _annualSalary;
    }

    function getAnnualCost() public view override returns(uint) {
        return annualSalary;
    }

}

contract Hourly is employee {

    uint public hourlyRate;

    constructor(uint _idNumber, uint _managerId, uint _hourlyRate) employee(_idNumber, _managerId) {
        hourlyRate = _hourlyRate;
    }

    function getAnnualCost() public view override returns(uint) {
        return hourlyRate * 2080;
    }

}

contract Manager {
    uint[] public employee_ids;

    function addReport(uint _id) public {
        employee_ids.push(_id);
    }

    function resetReports() public {
        delete employee_ids;
    }

}

contract Salesperson is Hourly {

    constructor(uint _idNumber, uint _managerId, uint _hourlyRate) Hourly(_idNumber, _managerId, _hourlyRate) {}

}

contract EngineeringManager is Salaried {

    constructor(uint _idNumber, uint _managerId, uint _annualSalary) Salaried(_idNumber, _managerId, _annualSalary) {}



}

contract InheritanceSubmission {
    address public salesPerson;
    address public engineeringManager;

    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}
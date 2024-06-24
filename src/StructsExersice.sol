// SPDX-License-Identifier: UNLICENSED
// Use the --constructor-args flag to pass arguments to the constructor:
// https://book.getfoundry.sh/forge/deploying
pragma solidity ^0.8.13;

contract GarageManager {
    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }
    mapping (address => Car[]) public garage;

    function addCar(string calldata _make, string calldata _model, string  calldata _color, uint _numberOfDoors) public {
        Car storage c = garage[msg.sender].push();
        c.make = _make;
        c.model = _model;
        c.color = _color;
        c.numberOfDoors = _numberOfDoors;
    }

    function getMyCars() public view returns(Car[] memory) {
        return garage[msg.sender];
    }

    function getUserCars(address x) public view returns(Car[] memory) {
        return garage[x];
    }

    error BadCarIndex(uint);

    function updateCar(uint ind, string calldata _make, string calldata _model, string  calldata _color, uint _numberOfDoors) public {
        if (ind >= garage[msg.sender].length){
            revert BadCarIndex(ind);
        }
        Car storage c = garage[msg.sender][ind];
        c.make = _make;
        c.model = _model;
        c.color = _color;
        c.numberOfDoors = _numberOfDoors;
    }

    function resetMyGarage() public{
        delete garage[msg.sender];
    }
}
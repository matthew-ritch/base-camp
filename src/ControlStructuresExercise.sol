// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

contract ControlStructures{

    function fizzBuzz(uint _number) public returns(string memory) {
        if ((_number % 3 == 0) && (_number % 5 == 0)){
            return "FizzBuzz";
        }
        if (_number % 3 == 0){
            return "Fizz";
        }
        if (_number % 5 == 0){
            return "Buzz";
        }
        return "Splat";
    }

    error AfterHours(uint _time);
    error LunchTime(string message);

    function doNotDisturb(uint _time) public returns(string memory){
        assert (_time < 2400);
        if (_time > 2200 || _time <800){
            revert AfterHours(_time);
        }
        if (_time >= 1200 && _time <= 1299){
            revert LunchTime("At lunch!");
        }
        if (_time >= 1800) {
            return "Evening!";
        }
        if (_time >= 1300) {
            return "Afternoon!";
        }
        return "Morning!";
    }

}
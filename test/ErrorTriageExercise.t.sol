// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ErrorTriageExercise} from "../src/ErrorTriageExercise.sol";

contract ErrorTriageExerciseTest is Test {
    ErrorTriageExercise public errortriage;

    function test_array_ops() public {
        errortriage = new ErrorTriageExercise();
        errortriage.addToArr(100);
        errortriage.addToArr(10);
        errortriage.addToArr(1);
        uint res;
        res = errortriage.popWithReturn();
        assertEq(res,1);
        res = errortriage.popWithReturn();
        assertEq(res,10);
        res = errortriage.popWithReturn();
        assertEq(res,100);

    }
}

// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

contract BasicMath {

    function adder (uint _a, uint _b) public pure returns (uint, bool) {
        unchecked {
            if (((_a + _b) < _a) || ((_a + _b) < _b)) {
                return (0, true);
            }
            return (_a + _b, false);
        }
    }

    function subtractor (uint _a, uint _b) public pure returns (uint, bool) {
        unchecked {
            if (((_a - _b) > _a)) {
                return (0, true);
            }
            return (_a - _b, false);
        }
    }

}
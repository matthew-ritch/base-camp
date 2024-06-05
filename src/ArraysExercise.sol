// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ArraysExercise {
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];
    address[] public senders;
    uint[] public timestamps;

    function getNumbers() public view returns( uint  [] memory){
        return numbers;
    }

    function resetNumbers() public {
        numbers = [1,2,3,4,5,6,7,8,9,10];
    }

    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i=0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    function afterY2K() public view returns(uint[] memory, address[] memory)  {
        uint counter;
        for (uint i=0; i < senders.length; i++) {
            if (timestamps[i]>946702800) {
                counter++;
            }
        }
        uint[] memory  _timestamps = new uint[](counter);
        address[] memory _senders = new address[](counter);
        uint j;
        for (uint i=0; i < senders.length; i++) {
            if (timestamps[i]>946702800) {
                _timestamps[j] = timestamps[i];
                _senders[j] = senders[i];
                j++;
            }
        }
        return (_timestamps, _senders);
    }

    function resetSenders() public {
        delete senders;
    }

    function resetTimestamps() public {
        delete timestamps;
    }

}
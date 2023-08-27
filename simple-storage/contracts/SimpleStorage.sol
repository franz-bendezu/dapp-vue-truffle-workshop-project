// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

contract SimpleStorage {
    struct Data {
        uint256 value;
        address owner;
    }
    Data data;

    function set(Data memory newData) public {
        data = newData;
    }

    function get() public view returns (Data memory) {
        return data;
    }
}

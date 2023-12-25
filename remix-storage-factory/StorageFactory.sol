// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SimpleStorage, SimpleStorage2} from "./SimpleStorage.sol";

contract StorageFactory {
    // we will store simpleStrogae
    // type visibiilty name
    SimpleStorage[] public listOfSimpleStorageAddresses;

    function createSimpleStorageContrat() public {
        SimpleStorage newSimpleStorage = new SimpleStorage();
        listOfSimpleStorageAddresses.push(newSimpleStorage);
    }

    function sfStore(
        uint256 _simpleStorgeIndex,
        uint256 _newSimpleStorageNumber
    ) public {
        // 2 things
        // address and ABI [APPLICATION BIANRY INTERFACE]
        SimpleStorage mySimpleStorage = listOfSimpleStorageAddresses[
            _simpleStorgeIndex
        ];
        mySimpleStorage.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorgeIndex) public view returns (uint256) {
        SimpleStorage mySimpleStorage = listOfSimpleStorageAddresses[
            _simpleStorgeIndex
        ];
        return mySimpleStorage.retrieve();
    }
}

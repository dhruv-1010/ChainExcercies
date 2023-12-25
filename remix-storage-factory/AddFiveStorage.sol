// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; // stating our version

import {SimpleStorage} from "./SimpleStorage.sol";
contract AddFiveStorage is SimpleStorage{
    // this is for custom child of SimpleStorage 
    function sayHello() public pure returns(string memory){
        return "HELLO";
    }
    // ps is add +5 to each SimpleStorage Number
    // override
    // virtual override
    
    function store(uint256 _newNumber) public override {
        myFavouriteNumber = _newNumber+5;
    }

}
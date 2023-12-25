// Etherium Virtual Machine  is just SC after compiling for now !!
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; // stating our version

// this is gonna be super easy so what do i have to do??
// so in this excercise we are gonna do is build a class which will be storing name of persons and their favNum

contract SimpleStorage{
    // basic data types in solidity
    // boolean,uint,int,address,bytes
    // bool hasFavouriteNumber = true;//boolean
    // uint256 favouriteNumber = 88;//only positive
    // int256 favouriteNumberInt = 88;// integers
    // string favouriteNumberInText = "88";// " ",
    // address myAddress = ;
    // bytes32 favouriteBytes32 = "cat";//same as string i.e. internally string are stored as bytes 
    // important note ye h ki address ke lie checksum nikalna padta h jo glt haur bytes32 hi bytes ka max size h
    uint256 myFavouriteNumber; //default == 0
    // lets make our first function
    function store(uint256 _favouriteNumber) public {
        myFavouriteNumber = _favouriteNumber;
    }
    // default visibility = internal
    // contract to  
    // input field 
    // view pure
    function retrieve() public view returns(uint256){
        return myFavouriteNumber;
    }

    // uint256[] listOfFavouriteNumbers; // []
    struct Person{
        uint256 favouriteNumber;
        string name;
    }
    // Person public Dhruv = Person(7,"Dhruv");
    // dynmaic array or static array
    Person[] public listOfPeople;
    mapping(string => uint256) public nameToFavouriteNumber;

    function addPerson(string memory _name,uint256 _favouriteNumber) public {
        // Person  memory newPerson = Person(_favouriteNumber,_name);
        // listOfPeople.push(newPerson);
        listOfPeople.push(Person(_favouriteNumber,_name));
        nameToFavouriteNumber[_name] = _favouriteNumber;
    }


    // mappings?? search its a hashmap nigga nnothing else
    // looping is shit here too much gas

    // ex Dhruv --> his favourite number



     



}
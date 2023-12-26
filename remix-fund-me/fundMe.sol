//  SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// we want to get funds from users
// withdraw funds
// set a minimum funding value in USD

// actually the thing is this was really easy till now cuz i have studied OOPS and DSA SO KUDOS ! HARDWORK IS PAYING ME UP NOW

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConvertor} from "./PriceConvertor.sol";

// allow users to fund money
// have a minimum $ spent
// value field of transcation
// 1e18 == 1 ETH =100000000000000000000 wei
// reverts !! undo any action that have been done and send the remaining gas back
// 849490 gas cost before optimizations
// so in the end all blockchain is to write efficient code for less and less gas
// use constant and immutable
error NotOwner();

contract fundMe {
    using PriceConvertor for uint256;

    // for more gas efficiency
    uint256 public constant minimumUSD = 5e18;
    address[] public funders;

    // Constructor : called when we deploy our contract
    // In Solidity, a constructor is a special function that is
    //  automatically executed only once when a contract is deployed to the Ethereum blockchain.
    // It is used to initialize the contract's state variables and
    // perform any setup tasks that need to be executed at the time of deployment.
    address public immutable i_owner;

    constructor() {
        // setup owner
        i_owner = msg.sender;
    }

    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        require(
            msg.value.getConversionRate() >= minimumUSD,
            "didn't send enough ETH"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }

  // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \ 
    //         yes  no
    //         /     \
    //    receive()?  fallback() 
    //     /   \ 
    //   yes   no
    //  /        \
    //receive()  fallback()

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

    // modifier allows to create custom keyword or conditions
    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _; // decides the order of execution of code if put first runs the code first else runs the code afterwards
    }

    function getPriceUSD() public view returns (uint256) {
        // 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI == LIST OF FUNCTIONS IN A CONTRACT
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer * 10000000000);
        //
    }

    function getConversionRateUSD(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPriceUSD();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }


}
// ways to send money in ETH from contracts [use solidity by example for more use cases]
// transfer : payable(msg.sender).transfer(address(this).balance);
// send     : boolean sendSucess = payable(msg.sender).transfer(address(this).balance); require(sendSucess,"Send Failed");
// call     : powerful function which call functions
// withdraw the funds

// // transfer
// payable(msg.sender).transfer(address(this).balance);

// // send
// bool sendSuccess = payable(msg.sender).send(address(this).balance);
// require(sendSuccess, "Send failed");

// call
// (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");

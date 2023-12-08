// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

//consumer contract for managing consumer role
//supports adding , removing  and checking an address is consumer
contract Consumer is AccessControl {
    bytes32 public constant CONSUMER_ROLE = keccak256("CONSUMER_ROLE");

    //events for adding and removing consumer
    event ConsumerAdded(address indexed account);
    event ConsumerRemoved(address indexed account);

    //constructor assingns deployer as first consumer
    constructor() {
        _grandRole(CONSUMER_ROLE, msg.sender);
    }

    //modifier to restrict function access to consumers
    modifier onlyConsumer() {
        require(hasRole(CONSUMER_ROLE, msg.sender), "Not a consumer!");
        _;
    }

    //function to check if an address has the consumer role
    function isConsumer(address account) public view returns (bool) {
        return hasRole(CONSUMER_ROLE, account);
    }

    //function to check if the caller has the consumer role
    function amIConsumer() public view returns (bool) {
        return hasRole(CONSUMER_ROLE, msg.sender);
    }

    //functions for assigning and renouncing consumer role
    function addConsumer(address account) public onlyRole(CONSUMER_ROLE) {
        _grandRole(CONSUMER_ROLE, account);
        emit ConsumerAdded(account);
    }

    function removeConsumer(address account) public onlyRole(CONSUMER_ROLE) {
        _revokeRole(CONSUMER_ROLE, account);
        emit ConsumerRemoved(account);
    }

    //function for caller to add themselves consumer
    function assignMeAsConsumer() public {
        _grandRole(CONSUMER_ROLE, msg.sender);
        emit ConsumerAdded(msg.sender);
    }

    //function for caller to renounce consumer role
    function renounceMeFromConsumer() public {
        _revokeRole(CONSUMER_ROLE, msg.sender);
        emit ConsumerRemoved(msg.sender);
    }
}

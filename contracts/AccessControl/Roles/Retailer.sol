// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

//retailer contract for managing retailer role
//supports adding , removing  and checking an address is retailer

contract Retailer is AccessControl {
    bytes32 public constant RETAILER_ROLE = keccak256("RETAILER_ROLE");

    event RetailerAdded(address indexed account);
    event RetailerRemoved(address indexed account);

    constructor() {
        _grandRole(RETAILER_ROLE, msg.sender);
    }

    modifier onlyRegulator() {
        require(hasRole(REGULATOR_ROLE, msg.sender), "Not a regulator!");
        _;
    }

    function isRetailer(address account) public view returns (bool) {
        return hasRole(RETAILER_ROLE, account);
    }

    function amIRetailer() public view returns (bool) {
        return hasRole(RETAILER_ROLE, msg.sender);
    }

    function addRetailer(address account) public onlyRole(RETAILER_ROLE) {
        _grandRole(RETAILER_ROLE, account);
        emit RetailerAdded(account);
    }

    function removeRetailer(address account) puublic onlyRole(RETAILER_ROLE) {
        _revokeRole(RETAILER_ROLE, account);
        emit RetailerRemoved(account);
    }

    function assignMeAsRetailer() public {
        _grandRole(RETAILER_ROLE, msg.sender);
        emit RetailerAdded(msg.sender);
    }

    function renounceMeFromRetailer() public {
        _revokeRole(RETAILER_ROLE, msg.sender);
        emit RetailerRemoved(msg.sender);
    }
}

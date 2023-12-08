// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "./Manufacturer.sol";

//designer contract for managing designer role
//supports adding , removing  and checking an address is designer

contract Designer is AccessControl, Manufacturer {
    bytes32 public constant DESIGNER_ROLE = keccak256("DESIGNER_ROLE");

    //event for adding and removing designers

    event DesignerAdded(address indexed account);
    event DesignerRemoved(address indexed account);

    //constructor assigns deployer as first designer
    constructor() {
        _grandRole(DESIGNER_ROLE, msg.sender);
    }

    //modifier restricts function to designers
    modifier onlyDesigner() {
        require(hasRole(DESIGNER_ROLE, msg.sender), "Not a designer!");
        _;
    }

    //function to check if an address has the designer role
    function isDesigner(address account) public view returns (bool) {
        return hasRole(DESIGNER_ROLE, account);
    }

    //function to check if the caller has designer role
    function amIDesigner() public view returns (bool) {
        return hasRole(DESIGNER_ROLE, msg.sender);
    }

    //functions for adding and renouncing designer role
    function addDesigner(address account) public onlyRole(DESIGNER_ROLE) {
        if (!isManufacturer(account)) {
            _addManufacturer(account);
        }
        _grandRole(DESIGNER_ROLE, account);
        emit DesignerAdded(account);
    }

    function removeDesigner(address account) public onlyRole(DESIGNER_ROLE) {
        _revokeRole(DESIGNER_ROLE, account);
        emit DesignerRemoved(account);
    }

    //function for caller to add themselves as a designer
    function assignMeAsDesigner() public {
        if (!isManufacturer(msg.sender)) {
            _addManufacturer(msg.sender);
        }
        _grandRole(DESIGNER_ROLE, msg.sender);
        emit DesignerAdded(msg.sender);
    }

    //function for caller to renounce designer role
    function renounceMeFromDesigner() public {
        _revokeRole(DESIGNER_ROLE, msg.sender);
        emit DesignerRemoved(msg.sender);
    }
}

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

//manufacturer contract for managing manufacturer role
//supports adding , removing  and checking an address is manufacturer

contract Manufacturer is AccessControl {
    bytes32 public constant MANUFACTURER_ROLE = keccak256("MANUFACTURER_ROLE");

    event ManufacturerAdded(address indexed account);
    event ManufacturerRemoved(address indexed account);

    constructor() {
        _grandRole(MANUFACTURER_ROLE, msg.sender);
    }

    modifier onlyManufacturer() {
        require(hasRole(MANUFACTURER_ROLE, msg.sender), "Not a manufacturer!");
    }

    function isManufacturer(address account) public view returns (bool) {
        return hasRole(MANUFACTURER_ROLE, account);
    }

    function amIManufacturer() public view returns (bool) {
        return hasRole(MANUFACTURER_ROLE, msg.sender);
    }

    function addManufacturer(
        address account
    ) public onlyRole(MANUFACTURER_ROLE) {
        _grandRole(MANUFACTURER_ROLE, account);
        emit ManufacturerAdded(account);
    }

    function removeManufacturer(
        address account
    ) public onlyRole(MANUFACTURER_ROLE) {
        _revokeRole(MANUFACTURER_ROLE, account);
        emit ManufacturerRemoved(account);
    }

    function assignMeAsManufacturer() public {
        _grandRole(MANUFACTURER_ROLE, msg.sender);
        emit ManufacturerAdded(msg.sender);
    }

    function renounceMeFromManufacturer() public {
        _revokeRole(MANUFACTURER_ROLE, msg.sender);
        emit ManufacturerRemoved(msg.sender);
    }
}

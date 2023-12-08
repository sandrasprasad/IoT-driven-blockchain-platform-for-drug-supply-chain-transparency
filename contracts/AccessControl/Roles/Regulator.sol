// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

//regulator contract for managing regulator role
//supports adding , removing  and checking an address is regulator

contract Regulator is AccessControl {
    bytes32 public constant REGULATOR_ROLE = keccak256("REGULATOR_ROLE");

    event RegulatorAdded(address indexed account);
    event RegulatorRemoved(address indexed account);

    constructor() {
        _grandRole(REGULATOR_ROLE, msg.sender);
    }

    modifier onlyRegulator() {
        require(hasRole(REGULATOR_ROLE, msg.sender), "Not a regulator!");
        _;
    }

    function isRegulator(address account) public view returns (bool) {
        return hasRole(REGULATOR_ROLE, account);
    }

    function amIRegulator() public view returns (bool) {
        return hasRole(REGULATOR_ROLE, msg.sender);
    }

    function addRegulator(address account) public onlyRole(REGULATOR_ROLE) {
        _grandRole(REGULATOR_ROLE, account);
        emit RegulatorAdded(account);
    }

    function removeRegulator(address account) puublic onlyRole(REGULATOR_ROLE) {
        _revokeRole(REGULATOR_ROLE, account);
        emit RegulatorRemoved(account);
    }

     function assignMeAsRegulator() public {
        _grandRole(REGULATOR_ROLE, msg.sender);
        emit RegulatorAdded(msg.sender);
    }

    function renounceMeFromRegulator() public {
        _revokeRole(REGULATOR_ROLE, msg.sender);
        emit RegulatorRemoved(msg.sender);
    }
}

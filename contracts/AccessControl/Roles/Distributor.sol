// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

//distributor contract for managing distributor role
//supports adding , removing  and checking an address is distributor

contract Distributor is AccessControl {
    bytes32 public constant DISTRIBUTOR_ROLE = keccak256("DISTRIBUTOR_ROLE");

    event DistributorAdded(address indexed account);
    event DistributorRemoved(address indexed account);

    constructor() {
        _grandRole(DISTRIBUTOR_ROLE, msg.sender);
    }

    modifier onlyDistributor() {
        require(hasRole(DISTRIBUTOR_ROLE, msg.sender), "Not a distributor!");
        _;
    }

    function isDistributor(address account) public view returns (bool) {
        return hasRole(DISTRIBUTOR_ROLE, msg.sender);
    }

    function amIDistributor() public view returns (bool) {
        return hasRole(DISTRIBUTOR_ROLE, msg.sender);
    }

    function addDistributor(address account) public onlyRole(DISTRIBUTOR_ROLE) {
        _grandRole(DISTRIBUTOR_ROLE, account);
        emit DesignerAdded(account);
    }

    function removeDistributor(
        address account
    ) public onlyRole(DISTRIBUTOR_ROLE) {
        _revokeRole(DISTRIBUTOR_ROLE, account);
        emit DesignerRemoved(account);
    }

    function assignMeAsDistributor() public {
        _grandRole(DISTRIBUTOR_ROLE, msg.sender);
        emit DistributorAdded(msg.sender);
    }

    function renounceMeFromDistributor() public {
        _revokeRole(DISTRIBUTOR_ROLE, msg.sender);
        emit DistributorRemoved(msg.sender);
    }
}

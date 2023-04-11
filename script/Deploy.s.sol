// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {BaseColor} from "src/BaseColor.sol";

contract DeployScript is Script {
    function run() public returns (BaseColor baseColor) {
        vm.startBroadcast();
        baseColor = new BaseColor();
        vm.stopBroadcast();
    }
}

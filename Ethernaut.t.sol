// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

// import {Test, console2} from "forge-std/Test.sol";
// import {Hack, GatekeeperOne} from "../src/Ethernaut.sol";

contract EthernautTest is Test {
    GatekeeperOne private gateKeeper;
    Hack private hack;

    function setUp() external {
        gateKeeper = GatekeeperOne(0xfB0ed7740E4C17C45A6661407ADF60fac2A5BFD1);
        hack = new Hack();
    }

    function testGas() external {
        for (uint256 i = 100; i < 8191; i++) {
            try hack.attack(address(gateKeeper), i) {
                console2.log("Gas", i);
                return;
            } catch {}
        }
        revert("Failed");
    }
}

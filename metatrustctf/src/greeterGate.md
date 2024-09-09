要解决的话需要调用unlock函数，而unlock函数需要函数自己发出的data中必须包含data[2]，可以通过读取内存槽的方法读取data[2]，根据Gate合约，内存槽分配如下：
槽 0: locked（1 字节，占用槽 0 的最低位）
槽 1: timestamp（uint256 占满 32 字节）
槽 2: number1 和 number2（number1 占用 1 字节，number2 占用 2 字节，共占 3 字节）
槽 3: data[0]（bytes32 占满 32 字节）
槽 4: data[1]（bytes32 占满 32 字节）
槽 5: data[2]（bytes32 占满 32 字节）
直接读取槽5的值就行，使得前16位与data[2]前16位对应 0x290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563

//用vm.load(address, bytes32) 
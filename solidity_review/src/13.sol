
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

contract  Yeye5 {
   event Log(string msg);

   function hip() public virtual{
    emit Log("Yeye5");
   }

   function pop() public virtual{
    emit Log("Yeye5");
   }

   function yeye5() public virtual{
    emit Log("Yeye5");
   }
}
   contract Die is Yeye5{
    function hip() public virtual override{
        emit Log("Die");
    }

    function pop() public virtual override{
        emit Log("Die");
    }

    function die() public virtual {
        emit Log("Die");
    }
}

   contract Son is Yeye5,Die {
    function hip() public virtual override(Yeye5,Die) {
        emit Log("Son");
    }

    function pop() public virtual override(Yeye5,Die) {
        emit Log("Son");
    }

    function callParent() public {
        Yeye5.pop();
    }

    function callParentSuper() public {
        super.pop();
    }
}

abstract contract A {

    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}

contract B is A(1) {
}

contract C is A {
    constructor(uint _c) A(_c * _c) {}
}
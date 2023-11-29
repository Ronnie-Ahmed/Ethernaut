// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFallback {
    function owner() external view returns (address);

    function contributions() external view returns (uint);

    function contribute() external payable;

    function withdraw() external;
}

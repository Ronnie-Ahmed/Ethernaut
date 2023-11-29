// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IFallout {
    function allocate() external payable;

    function sendAllocation(address payable allocator) external;

    function collectAllocations() external;

    function allocatorBalance(address allocator) external view returns (uint);

    function owner() external view returns (address);

    function Fal1out() external payable;
}

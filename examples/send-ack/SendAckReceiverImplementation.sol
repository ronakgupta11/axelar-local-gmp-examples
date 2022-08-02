// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import { SendAckReceiver } from './SendAckReceiver.sol';
import { AxelarExecutable } from '@axelar-network/axelar-utils-solidity/contracts/executables/AxelarExecutable.sol';
import { IAxelarGateway } from '@axelar-network/axelar-utils-solidity/contracts/interfaces/IAxelarGateway.sol';

contract SendAckReceiverImplementation is SendAckReceiver {
    IAxelarGateway immutable _gateway;
    
    constructor(address gateway_) {
        _gateway = IAxelarGateway(gateway_);
    }

    function gateway() public view override returns (IAxelarGateway) {
        return _gateway;
    }

    string[] public messages;

    function messagesLength() external view returns (uint256) {
        return messages.length;
    }

    // override this to do stuff
    function _executePostAck(
        string memory, /*sourceChain*/
        string memory, /*sourceAddress*/
        bytes memory payload
    ) internal override {
        string memory message = abi.decode(payload, (string));
        messages.push(message);
    }
}

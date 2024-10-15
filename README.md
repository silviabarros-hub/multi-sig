# MultiSig Smart Contract

## Overview

This Solidity smart contract is a Multi-Signature Wallet (`MultiSig`) that allows multiple owners to collectively approve and execute transactions. It ensures that a transaction can only be executed once the required number of confirmations is met.

## Features

- **Multiple Owners**: The contract allows a set of predefined owners.
- **Transaction Confirmation**: A transaction must receive the required number of confirmations before it can be executed.
- **Secure Execution**: Transactions can only be executed after they are confirmed by the required number of owners.
- **Submit and Confirm Transactions**: Any owner can submit a new transaction, which can then be confirmed by others.

## Contract Structure

- **Owners**: Array of addresses that act as authorized participants.
- **Transactions**: Mapping of `Transaction` structs, which include the recipient address, the amount of funds, the execution status, and any additional data.
- **Confirmations**: Mapping that tracks which owners have confirmed each transaction.

### Key Functions:

1. `submitTransaction`: Allows an owner to submit a new transaction to be executed.
2. `confirmTransaction`: Allows an owner to confirm a pending transaction.
3. `executeTransaction`: Executes a transaction if it has enough confirmations.
4. `isConfirmed`: Checks if a transaction has received the required number of confirmations.
5. `getConfirmationsCount`: Retrieves the number of confirmations for a specific transaction.

### Additional Functions:

- `isOwner`: Internal function that verifies if an address is one of the contract owners.
- `addTransaction`: Internal function that adds a new transaction to the mapping.

## How It Works

1. **Submit a Transaction**: An owner submits a transaction to the contract, providing the recipient, amount, and any additional data.
2. **Confirm the Transaction**: Owners must confirm the transaction. Once the required number of owners have confirmed, the transaction can be executed.
3. **Execute the Transaction**: If enough confirmations are gathered, the contract executes the transaction, transferring funds to the recipient.

## Example Usage

1. Deploy the contract with a list of owners and a required number of confirmations.
2. An owner submits a transaction by calling `submitTransaction`.
3. Other owners confirm the transaction using `confirmTransaction`.
4. Once the required number of confirmations is met, the transaction can be executed.

## Deployment

To deploy the contract, use the constructor, which takes two parameters:
- `address[] _owners`: An array of owner addresses.
- `uint _required`: The minimum number of confirmations required to execute a transaction.

### Example:

```solidity
constructor([0xAddress1, 0xAddress2], 2);

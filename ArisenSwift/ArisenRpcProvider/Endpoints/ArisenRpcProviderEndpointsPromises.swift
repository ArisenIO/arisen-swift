//
//  ArisenRpcProviderEndpointsPromises.swift
//  ArisenSwift
//
//  Created by Brandon Fancher on 4/18/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation
import PromiseKit

// MARK: - Endpoint methods returning Promises.
extension ArisenRpcProvider {

    /* Chain Endpoints */

    /// Call `chain/get_account` and get a Promise back. Fetch an account by account name.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcAccountRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcAccountResponse` or rejected with an `ArisenError`.
    public func getAccount(_: PMKNamespacer, requestParameters: ArisenRpcAccountRequest) -> Promise<ArisenRpcAccountResponse> {
        return Promise { getAccount(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_block` and get a Promise back. Get a block by block number or ID.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcBlockRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcBlockResponse` or rejected with an `ArisenError`.
    public func getBlock(_: PMKNamespacer, requestParameters: ArisenRpcBlockRequest) -> Promise<ArisenRpcBlockResponse> {
        return Promise { getBlock(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_info` and get a Promise back. Get information about the chain and node.
    ///
    /// - Parameter _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    /// - Returns: A Promise fulfilled with an `ArisenRpcInfoResponse` or rejected with an `ArisenError`.
    public func getInfo(_: PMKNamespacer) -> Promise<ArisenRpcInfoResponse> {
        return Promise { getInfo(completion: $0.resolve) }
    }

    /// Call `chain/push_transaction` and get a Promise back. Push a transaction to the blockchain!
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcPushTransactionRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcTransactionResponse` or rejected with an `ArisenError`.
    public func pushTransaction(_: PMKNamespacer, requestParameters: ArisenRpcPushTransactionRequest) -> Promise<ArisenRpcTransactionResponse> {
        return Promise { pushTransaction(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/push_transactions` and get a Promise back. Push multiple transactions to the chain.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcPushTransactionsRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcPushTransactionsResponse` or rejected with an `ArisenError`.
    public func pushTransactions(_: PMKNamespacer, requestParameters: ArisenRpcPushTransactionsRequest) -> Promise<ArisenRpcPushTransactionsResponse> {
        return Promise { pushTransactions(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_block_header_state` and get a Promise back.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcBlockHeaderStateRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcBlockHeaderStateResponse` or rejected with an `ArisenError`.
    public func getBlockHeaderState(_: PMKNamespacer, requestParameters: ArisenRpcBlockHeaderStateRequest) -> Promise<ArisenRpcBlockHeaderStateResponse> {
        return Promise { getBlockHeaderState(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_abi` and get a Promise back. Fetch an ABI by account/contract name.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcAbiRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcAbiResponse` or rejected with an `ArisenError`.
    public func getAbi(_: PMKNamespacer, requestParameters: ArisenRpcAbiRequest) -> Promise<ArisenRpcAbiResponse> {
        return Promise { getAbi(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_currency_balance` and get a Promise back.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcCurrencyBalanceRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcCurrencyBalanceResponse` or rejected with an `ArisenError`.
    public func getCurrencyBalance(_: PMKNamespacer, requestParameters: ArisenRpcCurrencyBalanceRequest) -> Promise<ArisenRpcCurrencyBalanceResponse> {
        return Promise { getCurrencyBalance(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_currency_stats` and get a Promise back.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcCurrencyStatsRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcCurrencyStatsResponse` or rejected with an `ArisenError`.
    public func getCurrencyStats(_: PMKNamespacer, requestParameters: ArisenRpcCurrencyStatsRequest) -> Promise<ArisenRpcCurrencyStatsResponse> {
        return Promise { getCurrencyStats(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_required_keys` and get a Promise back. Pass in a transaction and an array of available keys. Get back the subset of those keys required for signing the transaction.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcRequiredKeysRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcRequiredKeysResponse` or rejected with an `ArisenError`.
    public func getRequiredKeys(_: PMKNamespacer, requestParameters: ArisenRpcRequiredKeysRequest) -> Promise<ArisenRpcRequiredKeysResponse> {
        return Promise { getRequiredKeys(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_producers` and get a Promise back.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcProducersRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcProducersResponse` or rejected with an `ArisenError`.
    public func getProducers(_: PMKNamespacer, requestParameters: ArisenRpcProducersRequest) -> Promise<ArisenRpcProducersResponse> {
        return Promise { getProducers(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_raw_code_and_abi` and get a Promise back.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcRawCodeAndAbiRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcRawCodeAndAbiResponse` or rejected with an `ArisenError`.
    public func getRawCodeAndAbi(_: PMKNamespacer, requestParameters: ArisenRpcRawCodeAndAbiRequest) -> Promise<ArisenRpcRawCodeAndAbiResponse> {
        return Promise { getRawCodeAndAbi(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_raw_code_and_abi` and get a Promise back. Convenience method called with simple account name.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - accountName: The account/contract name, as a String.
    /// - Returns: A Promise fulfilled with an `ArisenRpcRawCodeAndAbiResponse` or rejected with an `ArisenError`.
    public func getRawCodeAndAbi(_: PMKNamespacer, accountName: String) -> Promise<ArisenRpcRawCodeAndAbiResponse> {
        return Promise { getRawCodeAndAbi(accountName: accountName, completion: $0.resolve) }
    }

    /// Call `chain/get_table_by_scope` and get a Promise back.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcTableByScopeRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcTableByScopeResponse` or rejected with an `ArisenError`.
    public func getTableByScope(_: PMKNamespacer, requestParameters: ArisenRpcTableByScopeRequest) -> Promise<ArisenRpcTableByScopeResponse> {
        return Promise { getTableByScope(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_table_rows` and get a Promise back. Returns an object containing rows from the specified table.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcTableRowsRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcTableRowsResponse` or rejected with an `ArisenError`.
    public func getTableRows(_: PMKNamespacer, requestParameters: ArisenRpcTableRowsRequest) -> Promise<ArisenRpcTableRowsResponse> {
        return Promise { getTableRows(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_code` and get a Promise back.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcCodeRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcCodeResponse` or rejected with an `ArisenError`.
    public func getCode(_: PMKNamespacer, requestParameters: ArisenRpcCodeRequest) -> Promise<ArisenRpcCodeResponse> {
        return Promise { getCode(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `chain/get_code` and geta Promise back. Convenience method called with simple account name.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - accountName: The account/contract name, as a String.
    /// - Returns: A Promise fulfilled with an `ArisenRpcCodeResponse` or rejected with an `ArisenError`.
    public func getCode(_: PMKNamespacer, accountName: String) -> Promise<ArisenRpcCodeResponse> {
        return Promise { getCode(accountName: accountName, completion: $0.resolve) }
    }

    /// Call `chain/get_raw_abi` and get a Promise back. Get a raw abi.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcRawAbiRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcRawAbiResponse` or rejected with an `ArisenError`.
    public func getRawAbi(_: PMKNamespacer, requestParameters: ArisenRpcRawAbiRequest) -> Promise<ArisenRpcRawAbiResponse> {
        return Promise { getRawAbi(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /* History Endpoints */

    /// Call `history/get_actions` and get a Promise back.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcHistoryActionsRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcActionsResponse` or rejected with an `ArisenError`.
    public func getActions(_: PMKNamespacer, requestParameters: ArisenRpcHistoryActionsRequest) -> Promise<ArisenRpcActionsResponse> {
        return Promise { getActions(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `history/get_transaction` and get a Promise back.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcHistoryTransactionRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcGetTransactionResponse` or rejected with an `ArisenError`.
    public func getTransaction(_: PMKNamespacer, requestParameters: ArisenRpcHistoryTransactionRequest) -> Promise<ArisenRpcGetTransactionResponse> {
        return Promise { getTransaction(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `history/get_key_accounts` and get a Promise back.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcHistoryKeyAccountsRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcKeyAccountsResponse` or rejected with an `ArisenError`.
    public func getKeyAccounts(_: PMKNamespacer, requestParameters: ArisenRpcHistoryKeyAccountsRequest) -> Promise<ArisenRpcKeyAccountsResponse> {
        return Promise { getKeyAccounts(requestParameters: requestParameters, completion: $0.resolve) }
    }

    /// Call `history/get_controlled_accounts` and get a Promise back.
    ///
    /// - Parameters:
    ///   - _: Differentiates call signature from that of non-promise-returning endpoint method. Pass in `.promise` as the first parameter to call this method.
    ///   - requestParameters: An `ArisenRpcHistoryControlledAccountsRequest`.
    /// - Returns: A Promise fulfilled with an `ArisenRpcControlledAccountsResponse` or rejected with an `ArisenError`.
    public func getControlledAccounts(_: PMKNamespacer, requestParameters: ArisenRpcHistoryControlledAccountsRequest) -> Promise<ArisenRpcControlledAccountsResponse> {
        return Promise { getControlledAccounts(requestParameters: requestParameters, completion: $0.resolve) }
    }
}

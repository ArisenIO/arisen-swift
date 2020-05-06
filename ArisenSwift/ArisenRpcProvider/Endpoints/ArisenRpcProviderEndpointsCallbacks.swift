//
//  ArisenRpcProviderEndpointsCallbacks.swift
//  ArisenSwift
//
//  Created by Brandon Fancher on 4/22/19.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import Foundation

// MARK: - Endpoint methods taking callbacks
extension ArisenRpcProvider {
    /* Chain Endpoints */

    /// Call `chain/get_account`. Fetch an account by account name.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcAccountRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcAccountResponse` and an optional `ArisenError`.
    public func getAccount(requestParameters: ArisenRpcAccountRequest, completion:@escaping (ArisenResult<ArisenRpcAccountResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_account", requestParameters: requestParameters) {(result: ArisenRpcAccountResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_block`. Get a block by block number or ID.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcBlockRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcBlockResponse` and an optional `ArisenError`.
    public func getBlock(requestParameters: ArisenRpcBlockRequest, completion: @escaping (ArisenResult<ArisenRpcBlockResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_block", requestParameters: requestParameters) {(result: ArisenRpcBlockResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_info`. Get information about the chain and node.
    ///
    /// - Parameter completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcInfoResponse` and an optional `ArisenError`.
    public func getInfo(completion: @escaping (ArisenResult<ArisenRpcInfoResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_info", requestParameters: nil) {(result: ArisenRpcInfoResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/push_transaction`. Push a transaction to the blockchain!
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcPushTransactionRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcTransactionResponse` and an optional `ArisenError`.
    public func pushTransaction(requestParameters: ArisenRpcPushTransactionRequest, completion: @escaping (ArisenResult<ArisenRpcTransactionResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/push_transaction", requestParameters: requestParameters) {(result: ArisenRpcTransactionResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/push_transactions`. Push multiple transactions to the chain.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcPushTransactionsRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcPushTransactionsResponse` and an optional `ArisenError`.
    public func pushTransactions(requestParameters: ArisenRpcPushTransactionsRequest, completion: @escaping (ArisenResult<ArisenRpcPushTransactionsResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/push_transactions", requestParameters: requestParameters.transactions) {(result: ArisenRpcPushTransactionsResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }
    /// Call `chain/get_block_header_state`.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcBlockHeaderStateRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcBlockHeaderStateResponse` and an optional `ArisenError`.
    public func getBlockHeaderState(requestParameters: ArisenRpcBlockHeaderStateRequest, completion: @escaping (ArisenResult<ArisenRpcBlockHeaderStateResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_block_header_state", requestParameters: requestParameters) {(result: ArisenRpcBlockHeaderStateResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_abi`. Fetch an ABI by account/contract name.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcAbiRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcAbiResponse` and an optional `ArisenError`.
    public func getAbi(requestParameters: ArisenRpcAbiRequest, completion: @escaping (ArisenResult<ArisenRpcAbiResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_abi", requestParameters: requestParameters) {(result: ArisenRpcAbiResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_currency_balance`.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcCurrencyBalanceRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcCurrencyBalanceResponse` and an optional `ArisenError`.
    public func getCurrencyBalance(requestParameters: ArisenRpcCurrencyBalanceRequest, completion:@escaping (ArisenResult<ArisenRpcCurrencyBalanceResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_currency_balance", requestParameters: requestParameters) {(result: ArisenRpcCurrencyBalanceResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_currency_stats`.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcCurrencyStatsRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcCurrencyStatsResponse` and an optional `ArisenError`.
    public func getCurrencyStats(requestParameters: ArisenRpcCurrencyStatsRequest, completion:@escaping (ArisenResult<ArisenRpcCurrencyStatsResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_currency_stats", requestParameters: requestParameters) {(result: ArisenRpcCurrencyStatsResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_required_keys`. Pass in a transaction and an array of available keys. Get back the subset of those keys required for signing the transaction.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcRequiredKeysRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcRequiredKeysResponse` and an optional `ArisenError`.
    public func getRequiredKeys(requestParameters: ArisenRpcRequiredKeysRequest, completion: @escaping (ArisenResult<ArisenRpcRequiredKeysResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_required_keys", requestParameters: requestParameters) {(result: ArisenRpcRequiredKeysResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_producers`.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcProducersRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcProducersResponse` and an optional `ArisenError`.
    public func getProducers(requestParameters: ArisenRpcProducersRequest, completion:@escaping (ArisenResult<ArisenRpcProducersResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_producers", requestParameters: requestParameters) {(result: ArisenRpcProducersResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_raw_code_and_abi`.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcRawCodeAndAbiRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcRawCodeAndAbiResponse` and an optional `ArisenError`.
    public func getRawCodeAndAbi(requestParameters: ArisenRpcRawCodeAndAbiRequest, completion:@escaping (ArisenResult<ArisenRpcRawCodeAndAbiResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_raw_code_and_abi", requestParameters: requestParameters) {(result: ArisenRpcRawCodeAndAbiResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_raw_code_and_abi`. Convenience method called with simple account name.
    ///
    /// - Parameters:
    ///   - accountName: The account name, as a String.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcRawCodeAndAbiResponse` and an optional `ArisenError`.
    public func getRawCodeAndAbi(accountName: String, completion:@escaping (ArisenResult<ArisenRpcRawCodeAndAbiResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_raw_code_and_abi", requestParameters: ["account_name": accountName]) {(result: ArisenRpcRawCodeAndAbiResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_table_by_scope`.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcTableByScopeRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcTableByScopeResponse` and an optional `ArisenError`.
    public func getTableByScope(requestParameters: ArisenRpcTableByScopeRequest, completion:@escaping (ArisenResult<ArisenRpcTableByScopeResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_table_by_scope", requestParameters: requestParameters) {(result: ArisenRpcTableByScopeResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_table_rows`. Returns an object containing rows from the specified table.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcTableRowsRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcTableRowsResponse` and an optional `ArisenError`.
    public func getTableRows(requestParameters: ArisenRpcTableRowsRequest, completion:@escaping (ArisenResult<ArisenRpcTableRowsResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_table_rows", requestParameters: requestParameters) {(result: ArisenRpcTableRowsResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_code`.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcCodeRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcCodeResponse` and an optional `ArisenError`.
    public func getCode(requestParameters: ArisenRpcCodeRequest, completion:@escaping (ArisenResult<ArisenRpcCodeResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_code", requestParameters: requestParameters) {(result: ArisenRpcCodeResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_code`. Convenience method called with simple account name.
    ///
    /// - Parameters:
    ///   - accountName: The account/contract name, as a String.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcCodeResponse` and an optional `ArisenError`.
    public func getCode(accountName: String, completion:@escaping (ArisenResult<ArisenRpcCodeResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_code", requestParameters: ["account_name": accountName]) {(result: ArisenRpcCodeResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_raw_abi`. Get a raw abi.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcRawAbiRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcRawAbiResponse` and an optional `ArisenError`.
    public func getRawAbi(requestParameters: ArisenRpcRawAbiRequest, completion: @escaping (ArisenResult<ArisenRpcRawAbiResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_raw_abi", requestParameters: requestParameters) {(result: ArisenRpcRawAbiResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /* History Endpoints */

    /// Call `history/get_actions`.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcHistoryActionsRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcActionsResponse` and an optional `ArisenError`.
    public func getActions(requestParameters: ArisenRpcHistoryActionsRequest, completion:@escaping (ArisenResult<ArisenRpcActionsResponse, ArisenError>) -> Void) {
        getResource(rpc: "history/get_actions", requestParameters: requestParameters) {(result: ArisenRpcActionsResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `history/get_transaction`.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcHistoryTransactionRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcGetTransactionResponse` and an optional `ArisenError`.
    public func getTransaction(requestParameters: ArisenRpcHistoryTransactionRequest, completion:@escaping (ArisenResult<ArisenRpcGetTransactionResponse, ArisenError>) -> Void) {
        getResource(rpc: "history/get_transaction", requestParameters: requestParameters) {(result: ArisenRpcGetTransactionResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `history/get_key_accounts`.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcHistoryKeyAccountsRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcKeyAccountsResponse` and an optional `ArisenError`.
    public func getKeyAccounts(requestParameters: ArisenRpcHistoryKeyAccountsRequest, completion:@escaping (ArisenResult<ArisenRpcKeyAccountsResponse, ArisenError>) -> Void) {
        getResource(rpc: "history/get_key_accounts", requestParameters: requestParameters) {(result: ArisenRpcKeyAccountsResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `history/get_controlled_accounts`.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcHistoryControlledAccountsRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcControlledAccountsResponse` and an optional `ArisenError`.
    public func getControlledAccounts(requestParameters: ArisenRpcHistoryControlledAccountsRequest, completion:@escaping (ArisenResult<ArisenRpcControlledAccountsResponse, ArisenError>) -> Void) {
        getResource(rpc: "history/get_controlled_accounts", requestParameters: requestParameters) {(result: ArisenRpcControlledAccountsResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/send_transaction`. Send a transaction to the blockchain!
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcSendTransactionRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of an `ArisenRpcTransactionResponse` and an optional `ArisenError`.
    public func sendTransaction(requestParameters: ArisenRpcSendTransactionRequest, completion: @escaping (ArisenResult<ArisenRpcTransactionResponse, ArisenError>) -> Void) {
        getResource(rpc: "chain/send_transaction", requestParameters: requestParameters) {(result: ArisenRpcTransactionResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }
}

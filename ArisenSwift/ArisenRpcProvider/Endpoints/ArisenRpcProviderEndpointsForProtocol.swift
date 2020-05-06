//
//  ArisenRpcProviderEndpointsForProtocol.swift
//  ArisenSwift
//
//  Created by Brandon Fancher on 4/22/19.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import Foundation

// MARK: - RPC methods used by `ArisenTransaction`. These force conformance only to the protocols, not the entire response structs.
extension ArisenRpcProvider: ArisenRpcProviderProtocol {

    /// Call `chain/get_info`. This method is called by `ArisenTransaction`, as it only enforces the response protocol, not the entire response struct.
    ///
    /// - Parameter completion: Called with the response, as an `ArisenResult` consisting of a response conforming to `ArisenRpcInfoResponseProtocol` and an optional `ArisenError`.
    public func getInfo(completion: @escaping (ArisenResult<ArisenRpcInfoResponseProtocol, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_info", requestParameters: nil) {(result: ArisenRpcInfoResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_block`. This method is called by `ArisenTransaction`, as it only enforces the response protocol, not the entire response struct.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcBlockRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of a response conforming to `ArisenRpcBlockResponseProtocol` and an optional `ArisenError`.
    public func getBlock(requestParameters: ArisenRpcBlockRequest, completion: @escaping (ArisenResult<ArisenRpcBlockResponseProtocol, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_block", requestParameters: requestParameters) {(result: ArisenRpcBlockResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_raw_abi`. This method is called by `ArisenTransaction`, as it only enforces the response protocol, not the entire response struct.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcRawAbiRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of a response conforming to `ArisenRpcRawAbiResponseProtocol` and an optional `ArisenError`.
    public func getRawAbi(requestParameters: ArisenRpcRawAbiRequest, completion: @escaping (ArisenResult<ArisenRpcRawAbiResponseProtocol, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_raw_abi", requestParameters: requestParameters) {(result: ArisenRpcRawAbiResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/get_required_keys`. This method is called by `ArisenTransaction`, as it only enforces the response protocol, not the entire response struct.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcRequiredKeysRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of a response conforming to `ArisenRpcRequiredKeysResponseProtocol` and an optional `ArisenError`.
    public func getRequiredKeys(requestParameters: ArisenRpcRequiredKeysRequest, completion: @escaping (ArisenResult<ArisenRpcRequiredKeysResponseProtocol, ArisenError>) -> Void) {
        getResource(rpc: "chain/get_required_keys", requestParameters: requestParameters) {(result: ArisenRpcRequiredKeysResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }

    /// Call `chain/push_transaction`. This method is called by `ArisenTransaction`, as it only enforces the response protocol, not the entire response struct.
    ///
    /// - Parameters:
    ///   - requestParameters: An `ArisenRpcPushTransactionRequest`.
    ///   - completion: Called with the response, as an `ArisenResult` consisting of a response conforming to `ArisenRpcTransactionResponseProtocol` and an optional `ArisenError`.
    public func pushTransaction(requestParameters: ArisenRpcPushTransactionRequest, completion: @escaping (ArisenResult<ArisenRpcTransactionResponseProtocol, ArisenError>) -> Void) {
        getResource(rpc: "chain/push_transaction", requestParameters: requestParameters) {(result: ArisenRpcTransactionResponse?, error: ArisenError?) in
            completion(ArisenResult(success: result, failure: error)!)
        }
    }
}

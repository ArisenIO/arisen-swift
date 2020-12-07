//
//  RpcProviderProtocol.swift
//  ArisenSwift
//
//  Created by Steve McCoole on 2/19/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation

// Protocol defining the endpoints required by the core Arisen SDK for Swift library.
public protocol ArisenRpcProviderProtocol {

    /// Calls /v1/chain/get_info.
    ///
    /// - Parameter completion: Completion called with an `ArisenResult`.
    func getInfo(completion: @escaping(ArisenResult<ArisenRpcInfoResponseProtocol, ArisenError>) -> Void)

    /// Calls /v1/chain/get_block.
    ///
    /// - Parameter completion: Completion called with an `ArisenResult`.
    func getBlock(requestParameters: ArisenRpcBlockRequest, completion: @escaping(ArisenResult<ArisenRpcBlockResponseProtocol, ArisenError>) -> Void)

    /// Calls /v1/chain/get_raw_abi.
    ///
    /// - Parameter completion: Completion called with an `ArisenResult`.
    func getRawAbi(requestParameters: ArisenRpcRawAbiRequest, completion: @escaping(ArisenResult<ArisenRpcRawAbiResponseProtocol, ArisenError>) -> Void)

    /// Calls /v1/chain/get_required_keys.
    ///
    /// - Parameter completion: Completion called with an `ArisenResult`.
    func getRequiredKeys(requestParameters: ArisenRpcRequiredKeysRequest, completion: @escaping(ArisenResult<ArisenRpcRequiredKeysResponseProtocol, ArisenError>) -> Void)

    /// Calls /v1/chain/push_transaction.
    ///
    /// - Parameter completion: Completion called with an `ArisenResult`.
    func pushTransaction(requestParameters: ArisenRpcPushTransactionRequest, completion: @escaping(ArisenResult<ArisenRpcTransactionResponseProtocol, ArisenError>) -> Void)

}

//
//  AllResponseProtocols.swift
//  ArisenSwift
//
//  Created by Farid Rahmani on 4/3/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation

/// Protocol for get_info responses. RPC responses must contain these properties, at a minimum, in order to be compatible with the core Arisen SDK for Swift library.
public protocol ArisenRpcInfoResponseProtocol {
    /// The chain ID.
    var chainId: String { get }
    /// The block number of the latest (head) block.
    var headBlockNum: ArisenUInt64 { get }
    /// The timestamp on the latest (head) block.
    var headBlockTime: String { get }
}

/// Protocol for get_block responses. RPC responses must contain these properties, at a minimum, in order to be compatible with the core Arisen SDK for Swift library.
public protocol ArisenRpcBlockResponseProtocol {
    /// The block number of the block fetched.
    var blockNum: ArisenUInt64 { get }
    /// The block prefix for the block fetched.
    var refBlockPrefix: ArisenUInt64 { get }
}

/// Protocol for get_raw_abi responses. RPC responses must contain these properties, at a minimum, in order to be compatible with the core Arisen SDK for Swift library.
public protocol ArisenRpcRawAbiResponseProtocol {
    /// The ABIs account name (contract name).
    var accountName: String { get }
    /// The ABI, itself.
    var abi: String { get }
    /// The hash of the ABI.
    var abiHash: String { get }
}

/// Protocol for get_required_keys responses. RPC responses must contain these properties, at a minimum, in order to be compatible with the core Arisen SDK for Swift library.
public protocol ArisenRpcRequiredKeysResponseProtocol {
    /// The keys required to sign the provided transaction. This is a subset of the available keys passed into the request.
    var requiredKeys: [String] { get }
}

/// Protocol for push_transaction responses. RPC responses must contain these properties, at a minimum, in order to be compatible with the core Arisen SDK for Swift library.
public protocol ArisenRpcTransactionResponseProtocol {
    /// The transaction ID.
    var transactionId: String { get }
}

/// Protocol for generic responses. All RPC response objects will contain the `_rawResponse` property.
public protocol ArisenRpcResponseProtocol {
    /// The raw response, as received from the RPC endpoint. This will contain all of the data, not just the properties enumerated by the response objects.
    var _rawResponse: Any? { get set }
}

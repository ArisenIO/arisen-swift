//
//  RequestModels.swift
//  ArisenSwift
//
//  Created by Steve McCoole on 2/20/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation

/// Request struct for requests to `v1/chain/get_required_keys`.
/// To be compatible with Arisen SDK for Swift, RPC endpoints must, at a minimum, accept these parameters.
public struct ArisenRpcRequiredKeysRequest: Codable {
    /// The transaction, as an `ArisenTransaction`.
    public var transaction: ArisenTransaction
    /// All public keys available for signing.
    public var availableKeys: [String]

    /// Initialize an `ArisenRpcRequiredKeysRequest`.
    public init(availableKeys: [String], transaction: ArisenTransaction) {
        self.availableKeys = availableKeys
        self.transaction = transaction
    }

    enum CodingKeys: String, CodingKey {
        case transaction = "transaction"
        case availableKeys = "available_keys"
    }
}

/// Request struct for requests to `v1/chain/push_transaction`.
/// To be compatible with Arisen SDK for Swift, RPC endpoints must, at a minimum, accept these parameters.
public struct ArisenRpcPushTransactionRequest: Codable {
    /// Array of signatures as Strings.
    public var signatures = [String]()
    /// Compression
    public var compression = 0
    /// Context free data, packed.
    public var packedContextFreeData = ""
    /// The serialized transaction as a hex String.
    public var packedTrx = ""

    /// Initialize an `ArisenRpcPushTransactionRequest`.
    public init(signatures: [String] = [], compression: Int = 0, packedContextFreeData: String = "", packedTrx: String = "") {
        self.signatures = signatures
        self.compression = compression
        self.packedContextFreeData = packedContextFreeData
        self.packedTrx = packedTrx
    }
}

/// Request struct for requests to `v1/chain/get_block`.
/// To be compatible with Arisen SDK for Swift, RPC endpoints must, at a minimum, accept these parameters.
public struct ArisenRpcBlockRequest: Codable {
    enum CodingKeys: String, CodingKey {
        case blockNumberOrId = "block_num_or_id"
    }
    /// The number or ID of the block you are fetching.
    @available(*, deprecated, message: "Please use blockNumberOrId instead.")
    public var blockNumOrId: UInt64 {
        get {
            return UInt64(blockNumberOrId) ?? 0
        }
        set {
            blockNumberOrId = String(newValue)
        }
    }
    /// The number or ID of the block you are fetching.
    public var blockNumberOrId: String
    /// Initialize an `ArisenRpcBlockRequest` with a block number.
    public init(blockNumOrId: UInt64 = 1) {
        self.blockNumberOrId = String(blockNumOrId)
    }
    /// Initialize an `ArisenRpcBlockRequest` with a block number or id.
    public init(blockNumOrId: String) {
        self.blockNumberOrId = blockNumOrId
    }
}

/// Request struct for requests to `v1/chain/get_raw_abi`.
/// To be compatible with Arisen SDK for Swift, RPC endpoints must, at a minimum, accept these parameters.
public struct ArisenRpcRawAbiRequest: Codable {
    /// Account name (i.e., name of the contract).
    public var accountName: ArisenName
    /// Hash of the ABI. (optional)
    public var abiHash: String?
    /// Initialize an `ArisenRpcRawAbiRequest`.
    public init(accountName: ArisenName, abiHash: String? = nil) {
        self.accountName = accountName
        self.abiHash = abiHash
    }
}

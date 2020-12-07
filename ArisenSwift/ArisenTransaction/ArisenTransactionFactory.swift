//
//  ArisenTransactionFactory.swift
//  ArisenSwift
//
//  Created by Serguei Vinnitskii on 4/15/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation

/// Convenience class for creating transactions on Arisen-based blockchains. Once you set properties (`rpcProvider` etc.), you don't have to set them again in order to create a new transaction.
public class ArisenTransactionFactory {

    /// Remote Procedure Call (RPC) provider for facilitating communication with blockchain nodes. Conforms to `ArisenRpcProviderProtocol`.
    let rpcProvider: ArisenRpcProviderProtocol
    /// Signature provider for facilitating the retrieval of available public keys and the signing of transactions. Conforms to `ArisenSignatureProviderProtocol`.
    let signatureProvider: ArisenSignatureProviderProtocol
    /// Serialization provider for facilitating ABI-driven transaction and action (de)serialization between JSON and binary data representations. Conforms to `ArisenSerializationProviderProtocol`.
    let serializationProvider: ArisenSerializationProviderProtocol
     /// Application Binary Interface (ABI) provider for facilitating the fetching and caching of ABIs from blockchain nodes. A default is provided. Conforms to `ArisenAbiProviderProtocol`.
    let abiProvider: ArisenAbiProviderProtocol?
    /// Transaction configuration.
    let config: ArisenTransaction.Config?

    /// Initializes the class.
    public init(
        rpcProvider: ArisenRpcProviderProtocol,
        signatureProvider: ArisenSignatureProviderProtocol,
        serializationProvider: ArisenSerializationProviderProtocol,
        abiProvider: ArisenAbiProviderProtocol? = nil,
        config: ArisenTransaction.Config? = nil
    ) {
        self.rpcProvider = rpcProvider
        self.signatureProvider = signatureProvider
        self.serializationProvider = serializationProvider
        self.abiProvider = abiProvider
        self.config = config
    }

    /// Returns a new `ArisenTransaction` instance.
    public func newTransaction() -> ArisenTransaction {

        let newTransaction = ArisenTransaction()
        newTransaction.rpcProvider = rpcProvider
        newTransaction.signatureProvider = signatureProvider
        newTransaction.serializationProvider = serializationProvider
        newTransaction.abiProvider = abiProvider
        if let config = config { newTransaction.config = config }

        return newTransaction
    }
}

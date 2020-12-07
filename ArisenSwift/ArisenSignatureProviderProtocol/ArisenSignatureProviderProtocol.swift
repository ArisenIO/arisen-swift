//
//  ArisenSignatureProviderProtocol.swift
//  ArisenSwift

//  Created by Todd Bowden on 7/15/18.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation

/// The transaction and related information structure sent to a signature provider for signing.
public struct ArisenTransactionSignatureRequest: Codable {
    /// The serialized transaction as `Data`.
    public var serializedTransaction = Data()
    /// The chain ID as a `String`.
    public var chainId = ""
    /// An array of public keys identifying the private keys with which the transaction should be signed.
    public var publicKeys = [String]()
    /// An array of `BinaryAbi`s sent along so that signature providers can display transaction information to the user.
    public var abis = [BinaryAbi]()
    /// Should the signature provider be allowed to modify the transaction? E.g., adding an assert action. Defaults to `true`.
    public var isModificationAllowed = true

    /// The structure for `BinaryAbi`s.
    public struct BinaryAbi: Codable {
        /// The account name for the contract, as a `String`.
        public var accountName = ""
        /// The binary representation of the ABI as a `String`.
        public var abi = ""
        /// Initializer for the `BinaryAbi`.
        public init() { }
    }

    /// Initializer for the `ArisenTransactionSignatureRequest`.
    public init() { }
}

/// The structure for the response from a signature provider to an `ArisenTransactionSignatureRequest`.
public struct ArisenTransactionSignatureResponse: Codable {
    /// The signed transaction, as a `SignedTransaction`.
    public var signedTransaction: SignedTransaction?
    /// An optional error.
    public var error: ArisenError?

    /// The structure for a `SignedTransaction`.
    public struct SignedTransaction: Codable {
        /// The serialized transaction, as `Data`. This may be different the transaction requested if the transaction was modified by the signature provider.
        public var serializedTransaction = Data()
        /// An array of signatures as `String`s.
        public var signatures = [String]()
        /// Initializer for the `SignedTransaction`.
        public init() { }
    }

    /// Initializer for the `ArisenTransactionSignatureResponse`.
    public init() { }

    /// Initializer for the `ArisenTransactionSignatureResponse` when it contains an error.
    ///
    /// - Parameter error: The error as an `ArisenError`.
    public init(error: ArisenError) {
        self.error = error
    }
}

/// The structure for the response from a signature provider when asked what keys are available for signing.
public struct ArisenAvailableKeysResponse: Codable {
    /// The keys as `String`s.
    public var keys: [String]?
    /// An optional error.
    public var error: ArisenError?

    /// Initializer for the `ArisenAvailableKeysResponse`.
    public init() { }
}

/// The protocol to which signature provider implementations must conform.
public protocol ArisenSignatureProviderProtocol {
    /// The method signature for transaction signing requests to conforming signature providers.
    ///
    /// - Parameters:
    ///   - request: The request as an `ArisenTransactionSignatureRequest`.
    ///   - completion: The completion that the signature provider implementation will call in response.
    func signTransaction(request: ArisenTransactionSignatureRequest, completion: @escaping (ArisenTransactionSignatureResponse) -> Void)

    /// The method signature for transaction signing requests to conforming signature providers while specifying
    /// a prompt to use for biometric validation if desired.
    ///
    /// - Parameters:
    ///   - request: The request as an `ArisenTransactionSignatureRequest`.
    ///   - prompt: Prompt for biometric authentication, if required.
    ///   - completion: The completion that the signature provider implementation will call in response.
    func signTransaction(request: ArisenTransactionSignatureRequest,
                         prompt: String,
                         completion: @escaping (ArisenTransactionSignatureResponse) -> Void)

    /// The method signature for public key requests to conforming signature providers.
    ///
    /// - Parameter completion: The method signature for key requests to conforming signature providers.
    func getAvailableKeys(completion: @escaping (ArisenAvailableKeysResponse) -> Void)
}

public extension ArisenSignatureProviderProtocol {
    func signTransaction(request: ArisenTransactionSignatureRequest,
                         prompt: String,
                         completion: @escaping (ArisenTransactionSignatureResponse) -> Void) {
        self.signTransaction(request: request, completion: completion)
    }
}

//
//  ArisenError.swift
//  ArisenSwift
//
//  Created by Todd Bowden on 7/11/18.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation

/// Error codes for `ArisenError`.
///
/// - ArisenTransactionError: Error was encountered while preparing the Transaction.
/// - rpcProviderError: Error was encountered in RpcProvider.
/// - getInfoError: Error was returned by getInfo() method.
/// - getBlockError: Error was encountered from getBlock() method.
/// - getRequiredKeysError: Error was returned by getRequiredKeys() method.
/// - getRawAbiError: Error was returned by getRawAbi() method.
/// - pushTransactionError: Error was encountered while pushing the transaction.
/// - signatureProviderError: Error was encountered in SignatureProvider.
/// - getAvailableKeysError: Error was returned by getAvailableKeys() method.
/// - signTransactionError: Error was encountered while signing the transaction.
/// - abiProviderError: Error was encountered in AbiProvider.
/// - getAbiError: Error was returned by getAbi() method.
/// - serializationProviderError: Error was encountered in SerializationProvider.
/// - serializeError: Error was encountered while serializing the transaction.
/// - deserializeError: Error was encountered while deserializing transaction.
/// - ArisenNameError: Error was encountered in ArisenName.
/// - keyManagementError: Error was encountered in key management.
/// - keySigningError: Error was encountered while signing with a key.
/// - unexpectedError: There was an unexpected error.
public enum ArisenErrorCode: String, Codable {

    /// Error was encountered while preparing the Transaction.
    case ArisenTransactionError = "ArisenTransactionError"
    /// Error was encountered in RpcProvider.
    case rpcProviderError = "RpcProviderError"
    /// Error was returned by getInfo() method.
    case getInfoError = "GetInfoError"
    /// Error was encountered from getBlock() method.
    case getBlockError = "GetBlockError"
    /// Error was returned by getRequiredKeys() method.
    case getRequiredKeysError = "GetRequiredKeysError"
    /// Error was returned by getRawAbi() method.
    case getRawAbiError = "GetRawAbiError"
    /// Error was encountered while pushing the transaction.
    case pushTransactionError = "PushTransactionError"
    /// Error was encountered in SignatureProvider.
    case signatureProviderError = "SignatureProviderError"
    /// Error was returned by getAvailableKeys() method.
    case getAvailableKeysError = "GetAvailableKeysError"
    /// Error was encountered while signing the transaction.
    case signTransactionError = "SignTransactionError"
    /// Error was encountered in AbiProvider.
    case abiProviderError = "AbiProviderError"
    /// Error was returned by getAbi() method.
    case getAbiError = "GetAbiError"
    /// Error was encountered in SerializationProvider.
    case serializationProviderError = "SerializationProviderError"
    /// Error was encountered while serializing the transaction.
    case serializeError = "SerializeError"
    /// Error was encountered while deserializing transaction.
    case deserializeError = "DeserializeError"
    /// Fatal Error was encountered in RpcProvider.
    case rpcProviderFatalError = "RpcProviderFatalError"
    /// Chain ID Error was encountered in RpcProvider.
    case rpcProviderChainIdError = "RpcProviderChainIdError"

    // Non-provider errors (added as these are encountered in Arisen Extensions and Foundation).

    /// Error was encountered in ArisenName.
    case ArisenNameError = "ArisenNameError"
    /// Error was encountered in key management.
    case keyManagementError = "KeyManagementError"
    /// Error was encountered while signing with a key.
    case keySigningError = "KeySigningError"

    // General catch all.

    /// There was an unexpected error.
    case unexpectedError = "UnexpectedError"
}

/// An error for Arisen SDK for Swift libraries containing an error code, reason, and the original error.
open class ArisenError: Error, CustomStringConvertible, Codable {

    /// An `ArisenErrorCode`.
    public var errorCode: ArisenErrorCode
    /// The reason for the error as a human-readable string.
    public var reason: String
    /// The original error.
    public var originalError: NSError?

    enum CodingKeys: String, CodingKey {
        case errorCode
        case reason
    }

    /// Returns a JSON string representation of the error object.
    var errorAsJsonString: String {
        let jsonDict = [
            "errorType": "ArisenError",
            "errorInfo": [
                "errorCode": self.errorCode.rawValue,
                "reason": self.reason
            ]
            ] as [String: Any]

        if JSONSerialization.isValidJSONObject(jsonDict),
            let data = try? JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted),
            let jsonString = String(data: data, encoding: .utf8) {

            return jsonString

        }

        return "{}"

    }

    /// Descriptions for the various `ArisenErrorCode` members.
    public var description: String {

        switch self.errorCode {
        case .ArisenTransactionError:
            return NSLocalizedString("Error was encountered while preparing the Transaction.", comment: "Error in transaction processing flow.")
        case .rpcProviderError:
            return NSLocalizedString("Error was encountered in RpcProvider.", comment: "Error in RPC processing flow.")
        case .getInfoError:
            return NSLocalizedString("Error was returned by getInfo() method.", comment: "Error in RPC processing flow.")
        case .getBlockError:
            return NSLocalizedString("Error was encountered from getBlock() method.", comment: "Error in RPC processing flow.")
        case .getRequiredKeysError:
            return NSLocalizedString("Error was returned by getRequiredKeys() method.", comment: "Error in RPC processing flow.")
        case .getRawAbiError:
            return NSLocalizedString("Error was returned by getRawAbi() method.", comment: "Error in RPC processing flow.")
        case .pushTransactionError:
            return NSLocalizedString("Error was encountered while pushing the transaction.", comment: "Error in RPC processing flow.")
        case .signatureProviderError:
            return NSLocalizedString("Error was encountered in SignatureProvider.", comment: "Error in SignatureProvider processing flow.")
        case .getAvailableKeysError:
            return NSLocalizedString("Error was returned by getAvailableKeys() method.", comment: "Error in SignatureProvider processing flow.")
        case .signTransactionError:
            return NSLocalizedString("Error was encountered while signing the transaction.", comment: "Error in SignatureProvider processing flow.")
        case .abiProviderError:
            return NSLocalizedString("Error was encountered in AbiProvider.", comment: "Error in AbiProvider processing flow.")
        case .getAbiError:
            return NSLocalizedString("Error was returned by getAbi() method.", comment: "Error in AbiProvider processing flow.")
        case .serializationProviderError:
            return NSLocalizedString("Error was encountered in SerializationProvider.", comment: "Error in SerializationProvider processing flow.")
        case .serializeError:
            return NSLocalizedString("Error was encountered while serializing the transaction.", comment: "Error in SerializationProvider processing flow.")
        case .deserializeError:
            return NSLocalizedString("Error was encountered while deserializing transaction.", comment: "Error in SerializationProvider processing flow.")
        case .ArisenNameError:
            return NSLocalizedString("Error was encountered in ArisenName.", comment: "Error in ArisenName processing flow.")
        case .keyManagementError:
            return NSLocalizedString("Error was encountered in key management.", comment: "Error was encountered in key management.")
        case .keySigningError:
            return NSLocalizedString("Error was encountered while signing with a key.", comment: "Error was encountered while signing with a key.")
        case .rpcProviderFatalError:
            return NSLocalizedString("Fatal non-recoverable Error was encountered in RpcProvider.", comment: "Error in RPC processing flow.")
        case .rpcProviderChainIdError:
            return NSLocalizedString("Error was encountered in comparing chain Ids in RpcProvider.", comment: "Error in RPC processing flow.")
        case .unexpectedError:
            return NSLocalizedString("There was an unexpected error.", comment: "Unexpected Error")
        }
    }

    /// Initialize an `ArisenError`.
    ///
    /// - Parameters:
    ///   - errorCode: An `ArisenErrorCode`.
    ///   - reason: The reason for the error as a human-readable string.
    ///   - originalError: The original error.
    public init (_ errorCode: ArisenErrorCode, reason: String, originalError: NSError? = nil) {
        self.errorCode = errorCode
        self.reason = reason
        self.originalError = originalError
    }
}

extension ArisenError: LocalizedError {

    /// Returns an error description.
    public var errorDescription: String? {
        return "\(self.errorCode.rawValue): \(self.reason)"
    }
}

public extension Error {

    /// Returns an `ArisenError` unexpected error for the given Error.
    var ArisenError: ArisenError {

        if let ArisenError = self as? ArisenError {
            return ArisenError
        }

        return ArisenError(ArisenErrorCode.unexpectedError, reason: self.localizedDescription, originalError: self as NSError)
    }

}

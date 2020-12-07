//
//  ArisenTransactionAbis.swift
//  ArisenSwift
//
//  Created by Todd Bowden on 2/16/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation

public extension ArisenTransaction {

    /// Manages Application Binary Interfaces (ABIs) associated with an `ArisenTransaction` instance.
    class Abis {

        private var abis = [ArisenName: Data]()

        /// The serialization provider instance used for ABI deserialization.
        public var serializationProvider: ArisenSerializationProviderProtocol?

        /// Validate an ABI.
        /// - Parameter hex: The ABI as a hex string.
        /// - Throws: If the ABI is not valid.
        public func validateAbi(hex: String) throws {
            guard let serializer = self.serializationProvider else {
                preconditionFailure("A serializationProvider must be set!")
            }
            _ = try serializer.deserializeAbi(hex: hex)
        }

        /// Add an ABI encoded as base64.
        /// - Parameters:
        ///   - name: The contract name.
        ///   - hex: The ABI as a base64 string.
        /// - Throws: If the base64 string is not valid or the ABI is not valid.
        public func addAbi(name: ArisenName, base64: String) throws {
            let hex = try Data(base64: base64).hex
            try addAbi(name: name, hex: hex)
        }

        /// Add an ABI encoded as hex.
        /// - Parameters:
        ///   - name: The contract name.
        ///   - hex: The ABI as a hex string.
        /// - Throws: If the hex string is not valid or the ABI is not valid.
        public func addAbi(name: ArisenName, hex: String) throws {
            let abi = try Data(hex: hex)
            try validateAbi(hex: hex)
            abis[name] = abi
        }

        /// Add an ABI as Data.
        /// - Parameters:
        ///   - name: The contract name.
        ///   - data: The ABI as Data.
        /// - Throws: If the ABI is not valid.
        public func addAbi(name: ArisenName, data: Data) throws {
            try validateAbi(hex: data.hex)
            abis[name] = data
        }

        /// Array of contract names missing an ABI.
        /// - Parameter names: Contract names to look for.
        /// - Returns: Contract names missing an ABI.
        public func missingAbis(names: [ArisenName]) -> [ArisenName] {
            return names.filter({ (name) -> Bool in
                abis[name] == nil
            })
        }

        /// Get the hash of the ABI for a contract name.
        /// - Parameter name: The contract name.
        /// - Returns: The sha256 hash of the ABI.
        /// - Throws: If the ABI is not available or not valid.
        public func hashAbi(name: ArisenName) throws -> String {
            guard let abi = abis[name] else {
                throw ArisenError(.abiProviderError, reason: "No abi available for \(name)")
            }
            return abi.sha256.hex
        }

        /// Hash of ABIs.
        /// - Returns: Dictionary of the sha256 hashes of the ABIs, keyed by contract name.
        public func hashAbis() -> [ArisenName: String] {
            return abis.mapValues({ (data) -> String in
                return data.sha256.hex
            })
        }

        /// Get the hex ABI for a contract name.
        /// - Parameter name: The contract name.
        /// - Returns: The ABI as hex.
        /// - Throws: If the ABI is not available or not valid.
        public func hexAbi(name: ArisenName) throws -> String {
            guard let hexAbi = abis[name]?.hex else {
                throw ArisenError(.abiProviderError, reason: "No abi available for \(name)")
            }
            return hexAbi
        }

        /// The ABIs encoded as hex.
        /// - Returns: Dictionary of the ABIs encoded as hex, keyed by contract name.
        public func hexAbis() -> [ArisenName: String] {
            return abis.mapValues({ (data) -> String in
                return data.hex
            })
        }

        /// The ABIs as json.
        /// - Returns: Dictionary of the ABIs as json, keyed by contract name.
        public func jsonAbis() throws -> [ArisenName: String] {
            return try hexAbis().mapValues({ (hex) -> String in
                guard let serializer = self.serializationProvider else {
                    preconditionFailure("A serializationProvider must be set!")
                }
                return try serializer.deserializeAbi(hex: hex)
            })
        }

        /// Get the json ABI for a contract name.
        /// - Parameter name: The contract name.
        /// - Returns: The ABI as json.
        /// - Throws: If the ABI is not available or not valid.
        public func jsonAbi(name: ArisenName) throws -> String {
            let hexAbi = try self.hexAbi(name: name)
            guard let serializer = self.serializationProvider else {
                preconditionFailure("A serializationProvider must be set!")
            }
            return try serializer.deserializeAbi(hex: hexAbi)
        }

    }

}

//
//  ArisenTransactionAction.swift
//  ArisenSwift
//
//  Created by Todd Bowden on 2/5/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation

public extension ArisenTransaction {

    /// Action class for `ArisenTransaction`
    class Action: Codable {

        /// Contract account name.
        public private(set) var account: ArisenName
        /// Contract action name.
        public private(set) var name: ArisenName
        /// Authorization (actor and permission).
        public private(set) var authorization: [Authorization]
        /// Action data.
        public private(set) var data: [String: Any]

        /// Action data as a json string.
        public var dataJson: String? {
            return data.jsonString
        }
        /// Action data in serialized form.
        public private(set) var dataSerialized: Data?

        /// Action data in serialized form as a hex string.
        public var dataHex: String? {
            return dataSerialized?.hexEncodedString()
        }

        /// Is the action data serialized?
        public var isDataSerialized: Bool {
            return dataSerialized != nil
        }

        /// Add an Authorization.
        ///
        /// - Parameters:
        ///   - authorization: The Authorization to add.
        ///   - at: An optional index at which to insert the Authorization. If not provided, the Authorization will be appended to the end of the authorization array.
        public func add(authorization auth: Authorization, at: Int? = nil) {
            authorization.insert(auth, at: at ?? authorization.count)
        }

        /// Remove an Authorization.
        ///
        /// - Parameters:
        ///   - at: The position of the authorization to remove. index must be a valid index of the collection that is not equal to the collection’s end index
        public func removeAuthorization(at: Int) -> Authorization? {
            return authorization.remove(at: at)
        }

        /// Coding keys
        enum CodingKeys: String, CodingKey { // swiftlint:disable:this nesting
            case account
            case name
            case authorization
            case data
        }

        /// Init Action struct with strings and an Encodable struct for data. Strings will be used to init ArisenNames.
        ///
        /// - Parameters:
        ///   - account: Contract account name.
        ///   - name: Contract action name.
        ///   - authorization: Authorization (actor and permission).
        ///   - data: Action data (codable struct).
        /// - Throws: If the strings are not valid Arisen names or data cannot be encoded.
        public convenience init(account: String, name: String, authorization: [Authorization], data: Encodable) throws {
            try self.init(account: ArisenName(account), name: ArisenName(name), authorization: authorization, data: data)
        }

        /// Init Action struct with `ArisenName`s and an Encodable struct for data.
        ///
        /// - Parameters:
        ///   - account: Contract account name.
        ///   - name: Contract action name.
        ///   - authorization: Authorization (actor and permission).
        ///   - data: Action data (codable struct).
        /// - Throws: If the strings are not valid Arisen names or data cannot be encoded.
        public convenience init(account: ArisenName, name: ArisenName, authorization: [Authorization], data: Encodable) throws {
            let dict = try data.toJsonString().jsonToDictionary()
            self.init(account: account, name: name, authorization: authorization, data: dict)
        }

        /// Init Action struct with strings and a Dictionary for data. Strings will be used to init ArisenNames.
        ///
        /// - Parameters:
        ///   - account: Contract account name.
        ///   - name: Contract action name.
        ///   - authorization: Authorization (actor and permission).
        ///   - data: Dictionary.
        /// - Throws: If the strings are not valid Arisen names or data cannot be encoded.
        public convenience init(account: String, name: String, authorization: [Authorization], data: [String: Any]) throws {
            try self.init(account: ArisenName(account), name: ArisenName(name), authorization: authorization, data: data)
        }

        /// Init Action struct with `ArisenName`s and a Dictionary for data.
        ///
        /// - Parameters:
        ///   - account: Contract account name.
        ///   - name: Contract action name.
        ///   - authorization: Authorization (actor and permission).
        ///   - data: Dictionary.
        /// - Throws: If the strings are not valid Arisen names or data cannot be encoded.
        public init(account: ArisenName, name: ArisenName, authorization: [Authorization], data: [String: Any]) {
            self.account = account
            self.name = name
            self.authorization = authorization
            self.data = data
        }

        /// Init Action struct with strings and serialized data. Strings will be used to init ArisenNames.
        ///
        /// - Parameters:
        ///   - account: Contract account name.
        ///   - name: Contract action name.
        ///   - authorization: Authorization (actor and permission).
        ///   - dataSerialized: Data in serialized form.
        /// - Throws: If the strings are not valid Arisen names.
        public convenience init(account: String, name: String, authorization: [Authorization], dataSerialized: Data) throws {
            try self.init(account: ArisenName(account), name: ArisenName(name), authorization: authorization, dataSerialized: dataSerialized)
        }

        /// Init Action struct with `ArisenName`s and serialized data.
        ///
        /// - Parameters:
        ///   - account: Contract account name.
        ///   - name: Contract action name.
        ///   - authorization: Authorization (actor and permission).
        ///   - dataSerialized: Data in serialized form.
        public init(account: ArisenName, name: ArisenName, authorization: [Authorization], dataSerialized: Data) {
            self.account = account
            self.name = name
            self.authorization = authorization
            self.dataSerialized = dataSerialized
            self.data = [String: Any]()
        }

        /// Init with decoder. The data property must be a hex string.
        ///
        /// - Parameter decoder: The decoder.
        /// - Throws: If the input cannot be decoded into a Action struct.
        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            account = try container.decode(ArisenName.self, forKey: .account)
            name = try container.decode(ArisenName.self, forKey: .name)
            authorization = try container.decode([Authorization].self, forKey: .authorization)
            self.data = [String: Any]()

            if let dataString = try? container.decode(String.self, forKey: .data) {
                if let ds = Data(hexString: dataString) { // swiftlint:disable:this identifier_name
                    dataSerialized = ds
                } else {
                    throw ArisenError(.ArisenTransactionError, reason: "\(dataString) is not a valid hex string")
                }
            } else {
                throw ArisenError(.ArisenTransactionError, reason: "Data property is not set for action \(account)::\(name)")
            }
        }

        /// Encode this action using the Encodable protocol. Action data will be serialized.
        ///
        /// - Parameter encoder: The encoder.
        /// - Throws: If the action cannot be encoded.
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(account, forKey: .account)
            try container.encode(name, forKey: .name)
            try container.encode(authorization, forKey: .authorization)
            try container.encode(dataHex ?? "", forKey: .data)
        }

        /// Return the action as a Dictionary. Action data will be unserialized.
        public var actionAsDictionary: [String: Any] {
            var dictionary = [String: Any]()
            dictionary["account"] = account.string
            dictionary["name"]  = name.string
            dictionary["authorization"] = authorization.toDictionary()
            dictionary["data"] = data
            return dictionary
        }

        /// Serialize the data from the `data` dictionary using `serializationProvider` and an ABI. Then set the `dataSerialized` property.
        ///
        /// - Parameters:
        ///   - abi: The ABI as a json string.
        ///   - serializationProvider: An `ArisenSerializationProviderProtocol` conforming implementation for the transformation.
        /// - Throws: If the data cannot be serialized.
        public func serializeData(abi: String, serializationProvider: ArisenSerializationProviderProtocol) throws {
            if isDataSerialized { return }
            guard let json = dataJson else {
                throw ArisenError(.serializeError, reason: "Cannot convert data to json")
            }
            let hex = try serializationProvider.serialize(contract: account.string, name: name.string, type: nil, json: json, abi: abi)
            guard let binaryData = Data(hexString: hex) else {
                throw ArisenError(.serializeError, reason: "Cannot decode hex \(hex)")
            }
            self.dataSerialized = binaryData
        }

        /// Deserialize the data from the `dataSerialized` property using `serializationProvider` and an ABI. Then set the `data` dictionary.
        ///
        /// - Parameters:
        ///   - abi: The ABI as a json string.
        ///   - serializationProvider: An `ArisenSerializationProviderProtocol` conforming implementation for the transformation.
        /// - Throws: If the data cannot be deserialized.
        public func deserializeData(abi: String, serializationProvider: ArisenSerializationProviderProtocol) throws {
            if data.count > 0 { return }
            guard let dataHex = dataHex else {
                throw ArisenError(.deserializeError, reason: "Serialized data not set for action \(account)::\(name)")
            }
            let json = try serializationProvider.deserialize(contract: account.string, name: name.string, type: nil, hex: dataHex, abi: abi)
            data = try json.jsonToDictionary()
        }

    }

}

extension ArisenTransaction.Action {

    /// Authorization struct for `ArisenTransaction.Action`.
    public struct Authorization: Codable, Equatable {

        /// The acting account.
        public var actor: ArisenName

        /// The permission under which the actor is executing the Action.
        public var permission: ArisenName

        /// Init Authorization with ArisenNames.
        ///
        /// - Parameters:
        ///   - actor: Actor as `ArisenName`.
        ///   - permission: Permission as `ArisenName`.
        public init(actor: ArisenName, permission: ArisenName) {
            self.actor = actor
            self.permission = permission
        }

        /// Init Authorization with strings.
        ///
        /// - Parameters:
        ///   - actor: Actor as String.
        ///   - permission: Permission as String.
        /// - Throws: If the strings are not valid ArisenNames.
        public init(actor: String, permission: String) throws {
            try self.init(actor: ArisenName(actor), permission: ArisenName(permission))
        }

    }

}

//
//  ArisenName.swift
//  ArisenSwift

//  Created by Todd Bowden on 1/31/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation

/// The `ArisenName` struct provides validation that an Arisen name is valid,
/// throwing errors on attempts to create an invalid name.
///
/// Arisen names are a max of 12 characters, `a-z`, `1-5` & `.`.
/// Names may not begin or end with a period (`.`).
public struct ArisenName: Codable, CustomStringConvertible, Equatable, Hashable {

    /// - Returns: The Arisen name as a String.
    public var description: String {
        return string
    }

    /// - Returns: The Arisen name as a String.
    private (set) public var string = ""

    /// Init with a String.
    ///
    /// - Parameter name: An Arisen name as a string.
    /// - Throws: If not a valid Arisen name.
    public init(_ name: String) throws {
        guard name.isValidArisenName else {
            throw ArisenError(.ArisenNameError, reason: "\(name) is not a valid Arisen name.")
        }
        self.string = name
    }

    /// Init with a decoder.
    ///
    /// - Parameter decoder: The decoder.
    /// - Throws: If not a valid Arisen name.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self).lowercased()
        guard string.isValidArisenName else {
            throw ArisenError(.ArisenNameError, reason: "\(string) is not a valid Arisen name.")
        }
        self.string = string
    }

    /// Encode the Arisen name to String.
    ///
    /// - Parameter encoder: The encoder.
    /// - Throws: If the name cannot be encoded.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }

}

public extension String {

    /// - Returns: `true` if a string is a valid Arisen name.
    var isValidArisenName: Bool {
        let pattern = "^[a-z1-5]{1,2}$|^[a-z1-5]{1}([a-z1-5\\.]){1,10}[a-z1-5]{1}$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let match = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return match.count > 0
    }
}

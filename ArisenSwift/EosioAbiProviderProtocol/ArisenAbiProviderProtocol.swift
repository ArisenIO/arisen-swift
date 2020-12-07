//
//  ArisenAbiProviderProtocol.swift
//  ArisenSwift
//
//  Created by Todd Bowden on 2/24/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation

/// Protocol for fetching and caching ABIs.
public protocol ArisenAbiProviderProtocol {

    /// Get all ABIs for the given accounts, keyed by account name.
    ///
    /// - Parameters:
    ///   - chainId: The chain ID.
    ///   - accounts: An array of account names as `ArisenName`s.
    ///   - completion: Calls the completion with an `ArisenResult` containing a map of ABIs as Data for all of the given accounts, keyed by the account name. An ABI for each account must be
    ///     returned, otherwise an `ArisenResult.failure` type will be returned.
    func getAbis(chainId: String, accounts: [ArisenName], completion: @escaping (ArisenResult<[ArisenName: Data], ArisenError>) -> Void)

    /// Get the ABI as `Data` for the specified account name.
    ///
    /// - Parameters:
    ///   - chainId: The chain ID.
    ///   - account: The account name as an `ArisenName`.
    ///   - completion: Calls the completion with an `ArisenResult` containing the ABI as Data. An `ArisenResult.failure` type will be returned if the specified ABI could not be found or
    ///     decoded properly.
    func getAbi(chainId: String, account: ArisenName, completion: @escaping (ArisenResult<Data, ArisenError>) -> Void)
}

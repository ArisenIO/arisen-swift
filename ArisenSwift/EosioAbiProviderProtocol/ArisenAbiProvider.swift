//
//  ArisenAbiProvider.swift
//  ArisenSwift
//
//  Created by Todd Bowden on 2/24/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation

/// Default implementation of the `ArisenAbiProviderProtocol`. For fetching and caching ABIs.
public class ArisenAbiProvider: ArisenAbiProviderProtocol {

    private let rpcProvider: ArisenRpcProviderProtocol
    private var abis = [String: Data]()
    private let lock = String()

    /// Initialize the ABI Provider.
    ///
    /// - Parameter rpcProvider: The RPC provider, which this ABI provider will use to fetch ABIs.
    public init(rpcProvider: ArisenRpcProviderProtocol) {
        self.rpcProvider = rpcProvider
    }

    private func getCachedAbi(chainId: String, account: ArisenName) -> Data? {
        return abis[chainId + account.string]
    }

    private func cacheAbi(_ abi: Data, chainId: String, account: ArisenName) {
        objc_sync_enter(self.lock)
        abis[chainId + account.string] = abi
        objc_sync_exit(self.lock)
    }

    /// Get all ABIs for the given accounts, keyed by account name.
    ///
    /// - Parameters:
    ///   - chainId: The chain ID.
    ///   - accounts: An array of account names as `ArisenName`s.
    ///   - completion: Calls the completion with an `ArisenResult` containing a map of ABIs as Data for all of the given accounts, keyed by the account name. An ABI for each account must be
    ///     returned, otherwise an `ArisenResult.failure` type will be returned.
    public func getAbis(chainId: String, accounts: [ArisenName], completion: @escaping (ArisenResult<[ArisenName: Data], ArisenError>) -> Void) {
        let accounts = Array(Set(accounts)) // remove any duplicate account names
        var responseAbis = [ArisenName: Data]()
        var optionalError: ArisenError?
        let dispatchGroup = DispatchGroup()

        for account in accounts {
            dispatchGroup.enter()
            getAbi(chainId: chainId, account: account) { (response) in
                switch response {
                case .success(let abi):
                    responseAbis[account] = abi
                    dispatchGroup.leave()
                case .failure(let error):
                    if optionalError == nil { optionalError = error }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            if let validError = optionalError {
                completion(.failure(validError))
            } else {
                completion(.success(responseAbis))
            }
        }
    }

    /// Get the ABI as `Data` for the specified account name.
    ///
    /// - Parameters:
    ///   - chainId: The chain ID.
    ///   - account: The account name as an `ArisenName`.
    ///   - completion: Calls the completion with an `ArisenResult` containing the ABI as Data. An `ArisenResult.failure` type will be returned if the specified ABI could not be found
    ///     or decoded properly.
    public func getAbi(chainId: String, account: ArisenName, completion: @escaping (ArisenResult<Data, ArisenError>) -> Void) {
        if let abi = getCachedAbi(chainId: chainId, account: account) {
            return completion(.success(abi))
        }

        let requestParameters = ArisenRpcRawAbiRequest(accountName: account)
        rpcProvider.getRawAbi(requestParameters: requestParameters) { (response) in
            switch response {
            case .success(let abiResponse):
                do {
                    let abi = try Data(base64: abiResponse.abi)
                    let computedHash = abi.sha256.hex.lowercased()
                    let declaredHash = abiResponse.abiHash.lowercased()
                    guard computedHash == declaredHash else {
                        let errorReason = "Computed hash of abi for \(account) \(computedHash) does not match declared hash \(declaredHash)"
                        return completion(.failure(ArisenError(.getRawAbiError, reason: errorReason)))
                    }
                    guard account.string == abiResponse.accountName else {
                        let errorReason = "Requested account \(account) does not match declared account \(abiResponse.accountName)"
                        return completion(.failure(ArisenError(.getRawAbiError, reason: errorReason)))
                    }
                    self.cacheAbi(abi, chainId: chainId, account: account)
                    return completion(.success(abi))

                } catch {
                    completion(.failure(error.ArisenError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

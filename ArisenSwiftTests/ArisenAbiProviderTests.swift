//
//  ArisenAbiProviderTests.swift
//  ArisenSwiftTests
//
//  Created by Todd Bowden on 2/25/19.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import Foundation
import XCTest
import ArisenSwift

class ArisenAbiProviderTests: XCTestCase {

    var rpcProvider: ArisenRpcProviderProtocol!
    override func setUp() {
        super.setUp()
        let url = URL(string: "https://localhost")
        rpcProvider = RPCProviderMock(endpoint: url!)
    }
    func testGetAbi() {
        let abiProvider = ArisenAbiProvider(rpcProvider: rpcProvider!)
        do {
            let arisenToken = try ArisenName("arisen.token")
            abiProvider.getAbi(chainId: "", account: arisenToken, completion: { (response) in
                switch response {
                case .success(let abi):
                    XCTAssertEqual(abi.sha256.hex, "43864d5af0fe294d44d19c612036cbe8c098414c4a12a5a7bb0bfe7db1556248")
                case .failure(let error):
                    print(error)
                    XCTFail("Failed to get Abi from provider")
                }
            })
        } catch {
            XCTFail("\(error)")
        }

    }

    func testGetAbis() {
        let abiProvider = ArisenAbiProvider(rpcProvider: rpcProvider!)
        do {
            let arisenToken = try ArisenName("arisen.token")
            let arisen = try ArisenName("arisen")
            abiProvider.getAbis(chainId: "", accounts: [arisenToken, arisen, arisenToken], completion: { (response) in
                switch response {
                case .success(let abi):
                    XCTAssertEqual(abi[arisenToken]?.sha256.hex, "43864d5af0fe294d44d19c612036cbe8c098414c4a12a5a7bb0bfe7db1556248")
                    XCTAssertEqual(abi[arisen]?.sha256.hex, "d745bac0c38f95613e0c1c2da58e92de1e8e94d658d64a00293570cc251d1441")
                case .failure(let error):
                    print(error)
                    XCTFail("Failed to get Abi from provider")
                }
            })
        } catch {
            XCTFail("\(error)")
        }

    }

    func testGetAbisBadAccount() {
        let abiProvider = ArisenAbiProvider(rpcProvider: rpcProvider!)
        do {
            let arisenToken = try ArisenName("arisen.token")
            let arisen = try ArisenName("arisen")
            let badAccount = try ArisenName("bad.acount")
            abiProvider.getAbis(chainId: "", accounts: [badAccount, arisenToken, arisen], completion: { (response) in
                switch response {
                case .success:
                    XCTFail("getting Abi from provider succeeded despite being wrong")
                case .failure(let error):
                    print(error)
                }
            })
        } catch {
            XCTFail("\(error)")
        }

    }

    class AbiProviderMock: ArisenAbiProviderProtocol {
        var getAbisCalled = false
        func getAbis(chainId: String, accounts: [ArisenName], completion: @escaping (ArisenResult<[ArisenName: Data], ArisenError>) -> Void) {
            getAbisCalled = true
        }
        var getAbiCalled = false
        func getAbi(chainId: String, account: ArisenName, completion: @escaping (ArisenResult<Data, ArisenError>) -> Void) {
            getAbiCalled = true
        }
    }
}

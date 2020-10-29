//
//  RpcProviderExtensionEndpointTests.swift
//  ArisenSwiftTests
//
//  Created by Ben Martell on 4/15/19.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import XCTest
@testable import ArisenSwift
import OHHTTPStubs

class RpcProviderExtensionEndpointTests: XCTestCase {

    var rpcProvider: ArisenRpcProvider?
    override func setUp() {
        super.setUp()
        let url = URL(string: "https://localhost")
        rpcProvider = arisenRpcProvider(endpoint: url!)
        OHHTTPStubs.onStubActivation { (request, stub, _) in
            print("\(request.url!) stubbed by \(stub.name!).")
        }
    }

    override func tearDown() {
        super.tearDown()
        //remove all stubs on tear down
        OHHTTPStubs.removeAllStubs()
    }

    /// Test pushTransactions implementation.
    func testPushTransactions() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "PushTransactions stub"
        let expect = expectation(description: "testPushTransactions")
        // swiftlint:disable line_length
        let transOne = ArisenRpcPushTransactionRequest(signatures: ["SIG_K1_KfFAcqhHTSzabsxGRLpK8KQonqLEXXzMkVQXoj4XGhqNNEzdjSfsGuDVsKFtMPs2NAit8h9LpVDkm2NoAGBaZAUzSmLpVR"], compression: 0, packedContextFreeData: "", packedTrx: "2D324F5CEBFDD0C60CDD000000000290AFC2D800EA3055000000405DA7ADBA0072CBDD956F52ACD910C3C958136D72F8560D1846BC7CF3157F5FBFB72D3001DE4597F4A1FDBECDA6D59C96A43009FC5E5D7B8F639B1269C77CEC718460DCC19CB30100A6823403EA3055000000572D3CCDCD0143864D5AF0FE294D44D19C612036CBE8C098414C4A12A5A7BB0BFE7DB155624800A6823403EA3055000000572D3CCDCD0100AEAA4AC15CFD4500000000A8ED32323B00AEAA4AC15CFD4500000060D234CD3DA06806000000000004454F53000000001A746865206772617373686F70706572206C69657320686561767900")
        let transTwo = ArisenRpcPushTransactionRequest(signatures: ["SIG_K1_K2mRrB7aknJPquDXJRsVy5xA9wyYrHEw7bkoc8vX4mHrww5UWLV25J3ZHb5kpMnfR3LF3Z2cJk3ydULkXx4vuet7cwYYa8"], compression: 0, packedContextFreeData: "", packedTrx: "8B324F5CA8FE7CC54C3A000000000290AFC2D800EA3055000000405DA7ADBA0072CBDD956F52ACD910C3C958136D72F8560D1846BC7CF3157F5FBFB72D3001DE4597F4A1FDBECDA6D59C96A43009FC5E5D7B8F639B1269C77CEC718460DCC19CB30100A6823403EA3055000000572D3CCDCD0143864D5AF0FE294D44D19C612036CBE8C098414C4A12A5A7BB0BFE7DB155624800A6823403EA3055000000572D3CCDCD0100AEAA4AC15CFD4500000000A8ED32323B00AEAA4AC15CFD4500000060D234CD3DA06806000000000004454F53000000001A746865206772617373686F70706572206C69657320686561767900")
        // swiftlint:enable line_length
        let requestParameters = ArisenRpcPushTransactionsRequest(transactions: [transOne, transTwo])
        rpcProvider?.pushTransactions(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcPushTransactionsResponse):
                XCTAssertNotNil(arisenRpcPushTransactionsResponse._rawResponse)
                XCTAssertNotNil(arisenRpcPushTransactionsResponse.transactionResponses)
                XCTAssert(arisenRpcPushTransactionsResponse.transactionResponses.count == 2)
                XCTAssert(arisenRpcPushTransactionsResponse.transactionResponses[0].transactionId == "2de4cd382c2e231c8a3ac80acfcea493dd2d9e7178b46d165283cf91c2ce6121")
                XCTAssert(arisenRpcPushTransactionsResponse.transactionResponses[1].transactionId == "8bddd86928d396dcec91e15d910086a4f8682167ff9616a84f23de63258c78fe")
            case .failure(let err):
                print(err.description)
                XCTFail("Failed push_transactions")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test testGetBlockHeaderState() implementation.
    // swiftlint:disable function_body_length
    func testGetBlockHeaderState() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetBlockHeaderState stub"
        let expect = expectation(description: "testGetBlockHeaderState")
        let requestParameters = ArisenRpcBlockHeaderStateRequest(blockNumOrId: "25260035")
        rpcProvider?.getBlockHeaderState(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcBlockHeaderStateResponse):
                XCTAssertNotNil(arisenRpcBlockHeaderStateResponse._rawResponse)
                XCTAssert(arisenRpcBlockHeaderStateResponse.id == "0137c067c65e9db8f8ee467c856fb6d1779dfeb0332a971754156d075c9a37ca")
                XCTAssert(arisenRpcBlockHeaderStateResponse.header.producerSignature == "SIG_K1_K11ScNfXdat71utYJtkd8E6dFtvA7qQ3ww9K74xEpFvVCyeZhXTarwvGa7QqQTRw3CLFbsXCsWJFNCHFHLKWrnBNZ66c2m")
                guard let version = arisenRpcBlockHeaderStateResponse.pendingSchedule["version"] as? UInt64 else {
                    return XCTFail("Should be able to get pendingSchedule as [String : Any].")
                }
                XCTAssert(version == 2)
                guard let activeSchedule = arisenRpcBlockHeaderStateResponse.activeSchedule["producers"] as? [[String: Any]] else {
                    return XCTFail("Should be able to get activeSchedule as [String : Any].")
                }
                guard let producerName = activeSchedule.first?["producer_name"] as? String else {
                    return XCTFail("Should be able to get producer_name as String.")
                }
                XCTAssert(producerName == "blkproducer1")
                guard let nodeCount = arisenRpcBlockHeaderStateResponse.blockRootMerkle["_node_count"] as? UInt64 else {
                    return XCTFail("Should be able to get _node_count as Int.")
                }
                XCTAssert(nodeCount == 20430950)
                XCTAssert(arisenRpcBlockHeaderStateResponse.confirmCount.count == 12)
                XCTAssertNotNil(arisenRpcBlockHeaderStateResponse.producerToLastImpliedIrb)
                XCTAssert(arisenRpcBlockHeaderStateResponse.producerToLastImpliedIrb.count == 2)
                if let irb = arisenRpcBlockHeaderStateResponse.producerToLastImpliedIrb[0] as? [Any] {
                    XCTAssertNotNil(irb)
                    XCTAssert(irb.count == 2)
                    guard let name = irb[0] as? String, name == "blkproducer1" else {
                        XCTFail("Should be able to find name.")
                        return
                    }
                    guard let num = irb[1] as? UInt64, num == 20430939 else {
                        XCTFail("Should be able to find number.")
                        return
                    }
                } else {
                    XCTFail("Should be able to find producer to last implied irb.")
                }

            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_block_header_state.")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }
    // swiftlint:enable function_body_length

    /// Test testGetAbi() implementation.
    func testGetAbi() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetAbi stub"
        let expect = expectation(description: "testGetAbi")
        let requestParameters = ArisenRpcAbiRequest(accountName: "arisen.token")
        rpcProvider?.getAbi(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcAbiResponse):
                XCTAssertNotNil(arisenRpcAbiResponse._rawResponse)
                let abi = arisenRpcAbiResponse.abi
                if let abiVersion = abi["version"] as? String {
                    XCTAssert(abiVersion == "arisen::abi/1.0")
                } else {
                    XCTFail("Should be able to find and verify abi version.")
                }
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_abi \(String(describing: err.originalError))")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test testGetAccount() implementation.
    // swiftlint:disable function_body_length
    // swiftlint:disable cyclomatic_complexity
    func testGetAccount() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetAccount stub"
        let expect = expectation(description: "testGetAccount")
        let requestParameters = arisenRpcAccountRequest(accountName: "cryptkeeper")
        rpcProvider?.getAccount(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcAccountResponse):
                XCTAssertNotNil(arisenRpcAccountResponse)
                XCTAssert(arisenRpcAccountResponse.accountName == "cryptkeeper")
                XCTAssert(arisenRpcAccountResponse.ramQuota.value == 13639863)
                let permissions = arisenRpcAccountResponse.permissions
                XCTAssertNotNil(permissions)
                guard let activePermission = permissions.filter({$0.permName == "active"}).first else {
                    return XCTFail("Cannot find Active permission in permissions structure of the account")
                }
                XCTAssert(activePermission.parent == "owner")
                guard let keysAndWeight = activePermission.requiredAuth.keys.first else {
                    return XCTFail("Cannot find key in keys structure of the account")
                }
                XCTAssert(keysAndWeight.key == "RIX5j67P1W2RyBXAL8sNzYcDLox3yLpxyrxgkYy1xsXzVCvzbYpba")
                guard let firstPermission = activePermission.requiredAuth.accounts.first else {
                    return XCTFail("Can't find permission in keys structure of the account")
                }
                XCTAssert(firstPermission.permission.actor == "RIXaccount1")
                XCTAssert(firstPermission.permission.permission == "active")
                XCTAssert(activePermission.requiredAuth.waits.first?.waitSec.value == 259200)
                XCTAssertNotNil(arisenRpcAccountResponse.totalResources)
                if let dict = arisenRpcAccountResponse.totalResources {
                    if let owner = dict["owner"] as? String {
                        XCTAssert(owner == "cryptkeeper")
                    } else {
                        XCTFail("Should be able to get total_resources owner as String and should equal cryptkeeper.")
                    }
                    if let rambytes = dict["ram_bytes"] as? UInt64 {
                        XCTAssert(rambytes == 13639863)
                    } else {
                        XCTFail("Should be able to get total_resources ram_bytes as UIn64 and should equal 13639863.")
                    }
                } else {
                    XCTFail("Should be able to get total_resources as [String : Any].")
                }
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_account")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    func testGetAccountNegativeUsageValues() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            if let urlString = request.url?.absoluteString {
                if callCount == 1 && urlString == "https://localhost/v1/chain/get_info" {
                    callCount += 1
                    return RpcTestConstants.getInfoOHHTTPStubsResponse()
                } else if callCount == 2 && urlString == "https://localhost/v1/chain/get_account" {
                    return RpcTestConstants.getOHHTTPStubsResponseForJson(json: RpcTestConstants.accountNegativeUsageValuesJson)
                } else {
                    return RpcTestConstants.getErrorOHHTTPStubsResponse(code: NSURLErrorUnknown, reason: "Unexpected call count in stub: \(callCount)")
                }
            } else {
                return RpcTestConstants.getErrorOHHTTPStubsResponse(reason: "No valid url string in request in stub")
            }
        }).name = "Get Account Negative Usage Values stub"
        let expect = expectation(description: "testGetAccountNegativeUsageValues")
        let requestParameters = arisenRpcAccountRequest(accountName: "cryptkeeper")
        rpcProvider?.getAccount(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcAccountResponse):
                XCTAssertNotNil(arisenRpcAccountResponse)
                XCTAssert(arisenRpcAccountResponse.accountName == "cryptkeeper")
                XCTAssert(arisenRpcAccountResponse.ramQuota.value == -1)
                XCTAssert(arisenRpcAccountResponse.cpuWeight.value == -1)
                let permissions = arisenRpcAccountResponse.permissions
                XCTAssertNotNil(permissions)
                guard let activePermission = permissions.filter({$0.permName == "active"}).first else {
                    return XCTFail("Cannot find Active permission in permissions structure of the account")
                }
                XCTAssert(activePermission.parent == "owner")
                guard let keysAndWeight = activePermission.requiredAuth.keys.first else {
                    return XCTFail("Cannot find key in keys structure of the account")
                }
                XCTAssert(keysAndWeight.key == "RIX5j67P1W2RyBXAL8sNzYcDLox3yLpxyrxgkYy1xsXzVCvzbYpba")
                guard let firstPermission = activePermission.requiredAuth.accounts.first else {
                    return XCTFail("Can't find permission in keys structure of the account")
                }
                XCTAssert(firstPermission.permission.actor == "RIXaccount1")
                XCTAssert(firstPermission.permission.permission == "active")
                XCTAssert(activePermission.requiredAuth.waits.first?.waitSec.value == 259200)
                XCTAssertNotNil(arisenRpcAccountResponse.totalResources)
                if let dict = arisenRpcAccountResponse.totalResources {
                    if let owner = dict["owner"] as? String {
                        XCTAssert(owner == "cryptkeeper")
                    } else {
                        XCTFail("Should be able to get total_resources owner as String and should equal cryptkeeper.")
                    }
                    if let rambytes = dict["ram_bytes"] as? UInt64 {
                        XCTAssert(rambytes == 13639863)
                    } else {
                        XCTFail("Should be able to get total_resources ram_bytes as UIn64 and should equal 13639863.")
                    }
                } else {
                    XCTFail("Should be able to get total_resources as [String : Any].")
                }
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_account")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }
    // swiftlint:enable function_body_length
    // swiftlint:enable cyclomatic_complexity

    /// Test testGetCurrencyBalance() implementation.
    func testGetCurrencyBalance() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetCurrencyBalance stub"
        let expect = expectation(description: "testGetCurrencyBalance")
        let requestParameters = arisenRpcCurrencyBalanceRequest(code: "arisen.token", account: "cryptkeeper", symbol: "RIX")
        rpcProvider?.getCurrencyBalance(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcCurrencyBalanceResponse):
                XCTAssertNotNil(arisenRpcCurrencyBalanceResponse._rawResponse)
                XCTAssert(arisenRpcCurrencyBalanceResponse.currencyBalance.count == 1)
                XCTAssert(arisenRpcCurrencyBalanceResponse.currencyBalance[0].contains(words: "RIX") )
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_currency_balance")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getCurrencyStats() implementation.
    func testGetCurrencyStats() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetCurrencyStats stub"
        let expect = expectation(description: "getCurrencyStats")
        let requestParameters = arisenRpcCurrencyStatsRequest(code: "arisen.token", symbol: "RIX")
        rpcProvider?.getCurrencyStats(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcCurrencyStatsResponse):
                XCTAssertNotNil(arisenRpcCurrencyStatsResponse._rawResponse)
                XCTAssert(arisenRpcCurrencyStatsResponse.symbol == "RIX")
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_currency_stats")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getCurrencyStatsRIX() implementation.
    func testGetCurrencyStatsRIX() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            if let urlString = request.url?.absoluteString {
                if callCount == 1 && urlString == "https://localhost/v1/chain/get_info" {
                    callCount += 1
                    return RpcTestConstants.getInfoOHHTTPStubsResponse()
                } else if callCount == 2 && urlString == "https://localhost/v1/chain/get_currency_stats" {
                    let json = RpcTestConstants.currencyStatsRIX
                    let data = json.data(using: .utf8)
                    return OHHTTPStubsResponse(data: data!, statusCode: 200, headers: nil)
                } else {
                    return RpcTestConstants.getErrorOHHTTPStubsResponse(code: NSURLErrorUnknown, reason: "Unexpected call count in stub: \(callCount)")
                }
            } else {
                return RpcTestConstants.getErrorOHHTTPStubsResponse(reason: "No valid url string in request in stub")
            }
        }).name = "GetCurrencyStats stub"
        let expect = expectation(description: "getCurrencyStats")
        let requestParameters = arisenRpcCurrencyStatsRequest(code: "arisen.token", symbol: "RIX")
        rpcProvider?.getCurrencyStats(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcCurrencyStatsResponse):
                XCTAssertNotNil(arisenRpcCurrencyStatsResponse._rawResponse)
                XCTAssert(arisenRpcCurrencyStatsResponse.symbol == "RIX")
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_currency_stats")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getRawCodeAndAbi() implementation.
    func testGetRawCodeAndAbi() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetRawCodeAndAbis stub"
        let expect = expectation(description: "getRawCodeAndAbi")
        let requestParameters = arisenRpcRawCodeAndAbiRequest(accountName: "arisen.token")
        rpcProvider?.getRawCodeAndAbi(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcRawCodeAndAbiResponse):
                XCTAssertNotNil(arisenRpcRawCodeAndAbiResponse._rawResponse)
                XCTAssert(arisenRpcRawCodeAndAbiResponse.accountName == "arisen.token")
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_raw_code_and_abi")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getRawCodeAndAbi() with String signature implementation.
    func testGetRawCodeAndAbiWithStringSignature() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetRawCodeAndAbis w String stub"
        let expect = expectation(description: "testGetRawCodeAndAbiWithStringSignature")
        rpcProvider?.getRawCodeAndAbi(accountName: "arisen.token" ) { response in
            switch response {
            case .success(let arisenRpcRawCodeAndAbiResponse):
                XCTAssertNotNil(arisenRpcRawCodeAndAbiResponse._rawResponse)
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_raw_code_and_abi")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getCode() implementation.
    func testgetCode() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetCode stub"
        let expect = expectation(description: "testGetCode")
        let requestParameters = arisenRpcCodeRequest(accountName: "tropical")
        rpcProvider?.getCode(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcCodeResponse):
                XCTAssertNotNil(arisenRpcCodeResponse._rawResponse)
                XCTAssert(arisenRpcCodeResponse.accountName == "tropical")
                XCTAssert(arisenRpcCodeResponse.codeHash == "68721c88e8b04dea76962d8afea28d2f39b870d72be30d1d143147cdf638baad")
                if let dict = arisenRpcCodeResponse.abi {
                    if let version = dict["version"] as? String {
                        XCTAssert(version == "arisen::abi/1.1")
                    } else {
                        XCTFail("Should be able to get abi version as String and should equal arisen::abi/1.1.")
                    }
                } else {
                    XCTFail("Should be able to get abi as [String : Any].")
                }
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_code")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getCode() with String signature implementation.
    func testGetCodeWithStringSignature() {
         var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetCodeWithStringSignature stub"
        let expect = expectation(description: "testGetCodeWithStringSignature")
        rpcProvider?.getCode(accountName: "cryptkeeper" ) { response in
            switch response {
            case .success(let arisenRpcCodeResponse):
                XCTAssertNotNil(arisenRpcCodeResponse._rawResponse)
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_code")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getTableRows() implementation.
    func testGetTableRows() {
         var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetTableRows stub"
        let expect = expectation(description: "testGetTableRows")
        let requestParameters = arisenRpcTableRowsRequest(scope: "cryptkeeper", code: "arisen.token", table: "accounts")
        rpcProvider?.getTableRows(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcTableRowsResponse):
                XCTAssertNotNil(arisenRpcTableRowsResponse._rawResponse)
                XCTAssertNotNil(arisenRpcTableRowsResponse.rows)
                XCTAssert(arisenRpcTableRowsResponse.rows.count == 1)
                if let row = arisenRpcTableRowsResponse.rows[0] as? [String: Any],
                    let balance = row["balance"] as? String {
                    XCTAssert(balance == "986420.1921 RIX")
                } else {
                    XCTFail("Cannot get returned table row or balance string.")
                }
                XCTAssertFalse(arisenRpcTableRowsResponse.more)
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_table_rows")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getTableByScope() implementation.
    func testGetTableByScope() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetTableByScope stub"
        let expect = expectation(description: "testGetTableByScope")
        let requestParameters = arisenRpcTableByScopeRequest(code: "arisen.token")
        rpcProvider?.getTableByScope(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcTableByScopeResponse):
                XCTAssertNotNil(arisenRpcTableByScopeResponse._rawResponse)
                XCTAssertNotNil(arisenRpcTableByScopeResponse.rows)
                XCTAssert(arisenRpcTableByScopeResponse.rows.count == 10)
                let row = arisenRpcTableByScopeResponse.rows[8]
                XCTAssert(row.code == "arisen.token")
                XCTAssert(row.scope == "arisen")
                XCTAssert(row.table == "accounts")
                XCTAssert(row.payer == "arisen")
                XCTAssert(row.count == 1)
                XCTAssert(arisenRpcTableByScopeResponse.more == "arisen.ramfee")
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_table_by_scope")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getProducers implementation.
    func testGetProducers() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetProducers stub"
        let expect = expectation(description: "testGetProducers")
        let requestParameters = arisenRpcProducersRequest(limit: 10, lowerBound: "blkproducer2", json: true)
        rpcProvider?.getProducers(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcProducersResponse):
                XCTAssertNotNil(arisenRpcProducersResponse._rawResponse)
                XCTAssertNotNil(arisenRpcProducersResponse.rows)
                XCTAssert(arisenRpcProducersResponse.rows.count == 2)
                XCTAssert(arisenRpcProducersResponse.rows[0].owner == "blkproducer2")
                XCTAssert(arisenRpcProducersResponse.rows[0].unpaidBlocks.value == 0)
                XCTAssert(arisenRpcProducersResponse.rows[1].owner == "blkproducer3")
                XCTAssert(arisenRpcProducersResponse.rows[0].isActive == 1)
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_producers")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getActions implementation.
    func testGetActions() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetActions stub"
        let expect = expectation(description: "testGetActions")
        let requestParameters = arisenRpcHistoryActionsRequest(position: -1, offset: -20, accountName: "cryptkeeper")
        rpcProvider?.getActions(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcActionsResponse):
                XCTAssertNotNil(arisenRpcActionsResponse._rawResponse)
                XCTAssert(arisenRpcActionsResponse.lastIrreversibleBlock.value == 55535908)
                XCTAssert(arisenRpcActionsResponse.timeLimitExceededError == false)
                XCTAssert(arisenRpcActionsResponse.actions.first?.globalActionSequence.value == 6483908013)
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.receipt.receiverSequence.value == 1236)
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.receipt.authorizationSequence.count == 1)
                if let firstSequence = arisenRpcActionsResponse.actions.first?.actionTrace.receipt.authorizationSequence.first as? [Any] {
                    guard let accountName = firstSequence.first as? String, accountName == "powersurge22" else {
                        return XCTFail("Should be able to find account name")
                    }
                }
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.action.name == "transfer")
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.action.authorization.first?.permission == "active")
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.action.data["memo"] as? String == "l2sbjsdrfd.m")
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.action.hexData == "10826257e3ab38ad000000004800a739f3eef20b00000000044d4545544f4e450c6c3273626a736472666a2e6f")
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.accountRamDeltas.first?.delta.value == 472)
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_actions")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    func testGetActionsNegativeDelta() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            if let urlString = request.url?.absoluteString {
                if callCount == 1 && urlString == "https://localhost/v1/chain/get_info" {
                    callCount += 1
                    return RpcTestConstants.getInfoOHHTTPStubsResponse()
                } else if callCount == 2 && urlString == "https://localhost/v1/history/get_actions" {
                    return RpcTestConstants.getOHHTTPStubsResponseForJson(json: RpcTestConstants.actionsNegativeDeltaJson)
                } else {
                    return RpcTestConstants.getErrorOHHTTPStubsResponse(code: NSURLErrorUnknown, reason: "Unexpected call count in stub: \(callCount)")
                }
            } else {
                return RpcTestConstants.getErrorOHHTTPStubsResponse(reason: "No valid url string in request in stub")
            }
        }).name = "Get Actions Negative Delta stub"
        let expect = expectation(description: "testGetActionsNegativeDelta")
        let requestParameters = arisenRpcHistoryActionsRequest(position: -1, offset: -20, accountName: "cryptkeeper")
        rpcProvider?.getActions(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcActionsResponse):
                XCTAssertNotNil(arisenRpcActionsResponse._rawResponse)
                XCTAssert(arisenRpcActionsResponse.lastIrreversibleBlock.value == 55535908)
                XCTAssert(arisenRpcActionsResponse.timeLimitExceededError == false)
                XCTAssert(arisenRpcActionsResponse.actions.first?.globalActionSequence.value == 6483908013)
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.receipt.receiverSequence.value == 1236)
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.receipt.authorizationSequence.count == 1)
                if let firstSequence = arisenRpcActionsResponse.actions.first?.actionTrace.receipt.authorizationSequence.first as? [Any] {
                    guard let accountName = firstSequence.first as? String, accountName == "powersurge22" else {
                        return XCTFail("Should be able to find account name")
                    }
                }
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.action.name == "transfer")
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.action.authorization.first?.permission == "active")
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.action.data["memo"] as? String == "l2sbjsdrfd.m")
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.action.hexData == "10826257e3ab38ad000000004800a739f3eef20b00000000044d4545544f4e450c6c3273626a736472666a2e6f")
                XCTAssert(arisenRpcActionsResponse.actions.first?.actionTrace.accountRamDeltas.first?.delta.value == -1)
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_actions")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getControlledAccounts implementation.
    func testGetControlledAccounts() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetControlledAccounts stub"
        let expect = expectation(description: "testGetControlledAccounts")
        let requestParameters = ArisenRpcHistoryControlledAccountsRequest(controllingAccount: "cryptkeeper")
        rpcProvider?.getControlledAccounts(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcControlledAccountsResponse):
                XCTAssertNotNil(arisenRpcControlledAccountsResponse._rawResponse)
                XCTAssertNotNil(arisenRpcControlledAccountsResponse.controlledAccounts)
                XCTAssert(arisenRpcControlledAccountsResponse.controlledAccounts.count == 2)
                XCTAssert(arisenRpcControlledAccountsResponse.controlledAccounts[0] == "subcrypt1")
                XCTAssert(arisenRpcControlledAccountsResponse.controlledAccounts[1] == "subcrypt2")
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_controlled_accounts")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getTransaction implementation.
    func testGetTransaction() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetTransaction stub"
        let expect = expectation(description: "testGetTransaction")
        let requestParameters = ArisenRpcHistoryTransactionRequest(transactionId: "ae735820e26a7b771e1b522186294d7cbba035d0c31ca88237559d6c0a3bf00a", blockNumHint: 21098575)
        rpcProvider?.getTransaction(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcGetTransactionResponse):
                XCTAssert(arisenRpcGetTransactionResponse.id == "ae735820e26a7b771e1b522186294d7cbba035d0c31ca88237559d6c0a3bf00a")
                XCTAssert(arisenRpcGetTransactionResponse.blockNum.value == 21098575)
                guard let dict = arisenRpcGetTransactionResponse.trx["trx"] as? [String: Any] else {
                    XCTFail("Should find trx.trx dictionary.")
                    return
                }
                if let refBlockNum = dict["ref_block_num"] as? UInt64 {
                    XCTAssert(refBlockNum == 61212)
                } else {
                    XCTFail("Should find trx ref_block_num and it should match.")
                }
                if let signatures = dict["signatures"] as? [String] {
                    XCTAssert(signatures[0] == "SIG_K1_JzFA9ffefWfrTBvpwMwZi81kR6tvHF4mfsRekVXrBjLWWikg9g1FrS9WupYuoGaRew5mJhr4d39tHUjHiNCkxamtEfxi68")
                } else {
                    XCTFail("Should find trx signatures and it should match.")
                }
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_transaction")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test getKeyAccounts implementation.
    func testGetKeyAccounts() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "GetKeyAccounts stub"
        let expect = expectation(description: "testGetKeyAccounts")
        let requestParameters = ArisenRpcHistoryKeyAccountsRequest(publicKey: "PUB_K1_5j67P1W2RyBXAL8sNzYcDLox3yLpxyrxgkYy1xsXzVCw1oi9eG")
        rpcProvider?.getKeyAccounts(requestParameters: requestParameters) { response in
            switch response {
            case .success(let arisenRpcKeyAccountsResponse):
                XCTAssertNotNil(arisenRpcKeyAccountsResponse.accountNames)
                XCTAssert(arisenRpcKeyAccountsResponse.accountNames.count == 2)
                XCTAssert(arisenRpcKeyAccountsResponse.accountNames[0] == "cryptkeeper")
            case .failure(let err):
                print(err.description)
                XCTFail("Failed get_key_accounts")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }

    /// Test sendTransaction() implementation.
    func testSendTransaction() {
        var callCount = 1
        (stub(condition: isHost("localhost")) { request in
            let retVal = RpcTestConstants.getHHTTPStubsResponse(callCount: callCount, urlRelativePath: request.url?.relativePath)
            callCount += 1
            return retVal
        }).name = "Send Transaction stub"
        let expect = expectation(description: "testSendTransaction")
        // swiftlint:disable line_length
        let requestParameters = ArisenRpcSendTransactionRequest(signatures: ["SIG_K1_JzFA9ffefWfrTBvpwMwZi81kR6tvHF4mfsRekVXrBjLWWikg9g1FrS9WupYuoGaRew5mJhr4d39tHUjHiNCkxamtEfxi68"], compression: 0, packedContextFreeData: "", packedTrx: "C62A4F5C1CEF3D6D71BD000000000290AFC2D800EA3055000000405DA7ADBA0072CBDD956F52ACD910C3C958136D72F8560D1846BC7CF3157F5FBFB72D3001DE4597F4A1FDBECDA6D59C96A43009FC5E5D7B8F639B1269C77CEC718460DCC19CB30100A6823403EA3055000000572D3CCDCD0143864D5AF0FE294D44D19C612036CBE8C098414C4A12A5A7BB0BFE7DB155624800A6823403EA3055000000572D3CCDCD0100AEAA4AC15CFD4500000000A8ED32323B00AEAA4AC15CFD4500000060D234CD3DA06806000000000004454F53000000001A746865206772617373686F70706572206C69657320686561767900")
        // swiftlint:enable line_length
        rpcProvider?.sendTransaction(requestParameters: requestParameters) { response in
            switch response {
            case .success(let sentTransactionResponse):
                XCTAssertTrue(sentTransactionResponse.transactionId == "2e611730d904777d5da89e844cac4936da0ff844ad8e3c7eccd5da912423c9e9")
                if let processed = sentTransactionResponse.processed as [String: Any]?,
                    let receipt = processed["receipt"] as? [String: Any],
                    let status = receipt["status"] as? String {
                    XCTAssert(status == "executed")
                } else {
                    XCTFail("Should be able to find processed.receipt.status and verify its value.")
                }
            case .failure(let err):
                XCTFail("\(err.description)")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }
}

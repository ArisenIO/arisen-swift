//
//  ArisenKeySignatureExtensionTests.swift
//  ArisenSwiftTests
//
//  Created by Todd Bowden on 3/11/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import Foundation
import XCTest
@testable import ArisenSwift

class ArisenKeySignatureExtensionTests: XCTestCase {

    let publicKey = "RSN5AzPqKAx4caCrRSAuyojY6rRKA3KJf4A1MY3paNVqV5eADEVm2"
    let publicKeyHex = "02257784a3d0aceef73ea365ce01febaec1b671b971b9c9feb3f4901e7b773bd43"

    let publicKeyInvalid1 = "RSN5AzPqKAx4caCrRSAuyojY6rRKA3KJf4A1MY3paNVqV5eADEVm2"
    let publicKeyInvalid2 = "RSN5AzPqKAx4caCrRSAuyolY6rRKA3KJf4A1MY3paNVqV5eADEVm2"
    let publicKeyInvalid3 = "RSN5AzPqKAx4caCrRSAuyojY6rRKA3KJf4A1MY3paNVqV5eADEVm3"

    let publicKeyK1 = "PUB_K1_5AzPqKAx4caCrRSAuyojY6rRKA3KJf4A1MY3paNVqV5eGGP63Y"
    let publicKeyK1Hex = "02257784a3d0aceef73ea365ce01febaec1b671b971b9c9feb3f4901e7b773bd43"

    let publicKeyK1Invalid1 = "PUD_K1_5AzPqKAx4caCrRSAuyojY6rRKA3KJf4A1MY3paNVqV5eGGP63Y"
    let publicKeyK1Invalid2 = "PUB_X1_5AzPqKAx4caCrRSAuyojY6rRKA3KJf4A1MY3paNVqV5eGGP63Y"
    let publicKeyK1Invalid3 = "PUB_K1_5AzPqKAx4caCrRSAuyolY6rRKA3KJf4A1MY3paNVqV5eGGP63Y"
    let publicKeyK1Invalid4 = "PUB_K1_5AzPqKAx4caCrRSAuyojY6rRKA3KJf4A1MY3paNVqV5eGGP64Y"

    let privateKeyHex = "c057a9462bc219abd32c6ca5c656cc8226555684d1ee8d53124da40330f656c1"
    let privateKey = "5KGziAsYALbLJiaaynE1GyG9fAq6p5n48K1B1JTQqCDfAJnioJD"
    let privateKeyK1 = "PVT_K1_5KGziAsYALbLJiaaynE1GyG9fAq6p5n48K1B1JTQqCDfAJnioJD"
    let privateKeyInvalid1 = "5KGziAsYALbLJiaaynE1GyG9fAq6p5n48K1B1JTQqCDfAJnioJC"
    let privateKeyInvalid2 = "PVT_K1_6KGziAsYALbLJiaaynE1GyG9fAq6p5n48K1B1JTQqCDfAJnioJD"

    let privateKeyR1a = "PVT_R1_2qq22p3UUuaXC3qAE6oSjGm1GzYLykdqrYBaECa29uYJG3AByD"
    let privateKeyR1b = "PVT_R1_AYTFoQZVuqk8wDqnns9wTcPrVMKQQbnyQfYjDTyF7nkzatxy3"
    let privateKeyR1c = "PVT_R1_2neSmTc8BvXbs2F3BiQNcvgDzbh9d2hpp89n6GWuKXcUKx9Gnv"

    let message = "Hello World".data(using: .utf8)!
    let signature0Hex = "304402207b80d705cc3f57f13000d79f6972c734a42d66aa42b8f698de998ff7594551f6022039b8d83f8ceba229e3b9e1d7efd844c978436e33b5cf79c19e92fbd69de7e4a5"
    let signature1Hex = "3044022061d3c08b3727396c56db35e94debf9c899c81cf888e0e9b5b7f1881e30b370620220035c9eb0f3f4e787784fcdfefd0147e222c18d25fe368b300cf583acedebbbc1"
    let signature0K1 = "SIG_K1_EsykzHxjT3BN8nUvwsiLVddddDi6WRuYaen7sfmJxE88EjLMp4kvSRjQE1iXuRfuwiaSUJLi1xFHjUVhfbBYJDVE27uGFU8R3E1Er"

    func test_Data_arisenPublicKey_legacy() {
        guard let data = try? Data(arisenPublicKey: publicKey) else {
            return XCTFail("Failed to convert public key to Data()")
        }
        XCTAssertEqual(data.hex, publicKeyHex)
    }

    func test_Data_arisenPublicKey_invalidLegacy_shouldFail() {
        XCTAssertThrowsError(try Data(arisenPublicKey: publicKeyInvalid1))
        XCTAssertThrowsError(try Data(arisenPublicKey: publicKeyInvalid2))
        XCTAssertThrowsError(try Data(arisenPublicKey: publicKeyInvalid3))
    }

    func test_Data_arisenPublicKey_k1() {
        guard let data = try? Data(arisenPublicKey: publicKeyK1) else {
            return XCTFail("Failed to convert public K1 key to Data()")
        }
        XCTAssertEqual(data.hex, publicKeyHex)
    }

    func test_toArisenK1PublicKey() {
        let data = try? Data(hex: publicKeyK1Hex)
        XCTAssertEqual(data?.toArisenK1PublicKey, publicKeyK1)
    }

    func test_Data_arisenPublicKey_invalidK1_shouldFail() {
        XCTAssertThrowsError(try Data(arisenPublicKey: publicKeyK1Invalid1))
        XCTAssertThrowsError(try Data(arisenPublicKey: publicKeyK1Invalid2))
        XCTAssertThrowsError(try Data(arisenPublicKey: publicKeyK1Invalid3))
        XCTAssertThrowsError(try Data(arisenPublicKey: publicKeyK1Invalid4))
    }

    func test_Data_arisenPrivateKey() {
        guard let data = try? Data(arisenPrivateKey: privateKey) else {
            return XCTFail("Failed to convert private key to Data()")
        }
        XCTAssertEqual(data.hex, privateKeyHex)
    }

    func test_Data_arisenPrivateKeyK1() {
        guard let data = try? Data(arisenPrivateKey: privateKeyK1) else {
            return XCTFail("Failed to convert public K1 key to Data()")
        }
        XCTAssertEqual(data.hex, privateKeyHex)
    }

    func test_Data_arisenPrivateKey_invalid_shouldFail() {
        XCTAssertThrowsError(try Data(arisenPrivateKey: privateKeyInvalid1))
        XCTAssertThrowsError(try Data(arisenPrivateKey: privateKeyInvalid2))
    }

    func test_privateK1_round_trip() {
        guard let data = try? Data(arisenPrivateKey: privateKeyK1) else {
            return XCTFail("Failed to convert public K1 key to Data()")
        }
        XCTAssertEqual(data.toArisenK1PrivateKey, privateKeyK1)
    }

    func test_privateR1_round_trip() {
        guard let data1 = try? Data(arisenPrivateKey: privateKeyR1a) else {
            return XCTFail("Failed to convert public R1 key to Data()")
        }
        XCTAssertEqual(data1.toArisenR1PrivateKey, privateKeyR1a)

        guard let data2 = try? Data(arisenPrivateKey: privateKeyR1b) else {
            return XCTFail("Failed to convert public R1 key to Data()")
        }
        XCTAssertEqual(data2.toArisenR1PrivateKey, privateKeyR1b)

        guard let data3 = try? Data(arisenPrivateKey: privateKeyR1c) else {
            return XCTFail("Failed to convert public R1 key to Data()")
        }
        XCTAssertEqual(data3.toArisenR1PrivateKey, privateKeyR1c)
    }

    func test_toArisenK1Signature() {
        let data = try? Data(hex: signature0Hex)
        XCTAssertEqual(data?.toArisenK1Signature, signature0K1)
    }

    func test_Data_arisenSignature() {
        guard let data = try? Data(arisenSignature: signature0K1) else {
            return XCTFail("Failed to convert Arisen signature to Data()")
        }
        XCTAssertEqual(data.hex, signature0Hex)
    }

    func test_compressedPublicKey() {
        let compressedPublicKey = "02257784a3d0aceef73ea365ce01febaec1b671b971b9c9feb3f4901e7b773bd43"
        let unCompressedPublicKey = "04257784a3d0aceef73ea365ce01febaec1b671b971b9c9feb3f4901e7b773bd4366c7451a736e2921b3dfeefc2855e984d287d58a0dfb995045f339a0e8a2fd7a"
        let unCompressedKey = try? Data(hex: unCompressedPublicKey)
        XCTAssertEqual(unCompressedKey?.toCompressedPublicKey?.hex, compressedPublicKey)
    }

}

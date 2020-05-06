//
//  ArisenNameTests.swift
//  ArisenSwiftTests
//
//  Created by Todd Bowden on 2/3/19.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import XCTest
@testable import ArisenSwift

class ArisenNameTests: XCTestCase {

    struct TestStruct: Codable {
        var name: ArisenName
    }

    func testValidArisenNames() {
        XCTAssertNotNil(try? ArisenName("a"))
        XCTAssertNotNil(try? ArisenName("ab"))
        XCTAssertNotNil(try? ArisenName("abc"))
        XCTAssertNotNil(try? ArisenName("abc12345"))
        XCTAssertNotNil(try? ArisenName("1"))
        XCTAssertNotNil(try? ArisenName("12345"))
        XCTAssertNotNil(try? ArisenName("a.b"))
        XCTAssertNotNil(try? ArisenName("a.b.c"))
        XCTAssertNotNil(try? ArisenName("a.1.b.c.d"))
        XCTAssertNotNil(try? ArisenName("a..b"))
        XCTAssertNotNil(try? ArisenName("a1..b"))
        XCTAssertNotNil(try? ArisenName("a...b"))
        XCTAssertNotNil(try? ArisenName("a.1..b"))
        XCTAssertNotNil(try? ArisenName("abc1234..5"))
        XCTAssertNotNil(try? ArisenName("abcd.12345"))
        XCTAssertNotNil(try? ArisenName("abcd.12345.z"))
    }

    func testInvalidArisenNames() {
        XCTAssertNil(try? ArisenName(""))
        XCTAssertNil(try? ArisenName("."))
        XCTAssertNil(try? ArisenName(".a"))
        XCTAssertNil(try? ArisenName("1."))
        XCTAssertNil(try? ArisenName("0"))
        XCTAssertNil(try? ArisenName("6"))
        XCTAssertNil(try? ArisenName("A"))
        XCTAssertNil(try? ArisenName("abc123456"))
        XCTAssertNil(try? ArisenName("abC12345"))
        XCTAssertNil(try? ArisenName("abc12345."))
        XCTAssertNil(try? ArisenName("abc.def.12345"))
        XCTAssertNil(try? ArisenName("abc.!"))
        XCTAssertNil(try? ArisenName("@"))
    }

    func testDeocdeEncodeArisenName() {
        let decoder = JSONDecoder()

        let jsonValid = """
        {"name":"abc"}
        """
        guard let structValid = try? decoder.decode(TestStruct.self, from: jsonValid.data(using: .utf8)!) else {
            return XCTFail("Failed to decode JSON")
        }
        XCTAssert(structValid.name.string == "abc")
        XCTAssert(try structValid.name == ArisenName("abc"))

        let jsonInvalid = """
        {"name":"abc."}
        """
        XCTAssertNil(
            try? decoder.decode(TestStruct.self, from: jsonInvalid.data(using: .utf8)!)
        )

        let encoder = JSONEncoder()

        guard let json = try? encoder.encode(structValid) else {
            return XCTFail("Failed to encode JSON")
        }
        XCTAssert(String(data: json, encoding: .utf8) == jsonValid)
    }

}

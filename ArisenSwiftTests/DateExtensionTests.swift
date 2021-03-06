//
//  DateExtensionTests.swift
//  ArisenSwiftTests
//
//  Created by Serguei Vinnitskii on 4/1/19.
//  Copyright (c) 2017-2019 peepslabs and its contributors. All rights reserved.
//

import XCTest
import ArisenSwift

class DateExtensionTests: XCTestCase {

    func test_formattedForJSONEncoder() {

        // create a date in required format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")

        // create a date with extension
        let dateFormatterForJSONEncoder = Date.asTransactionTimestamp

        // compare
        XCTAssertTrue(formatter.dateFormat == dateFormatterForJSONEncoder.dateFormat)
    }

}

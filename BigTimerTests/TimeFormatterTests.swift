//
//  TimeFormatterTests.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/4/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import XCTest

class TimeFormatterTests: XCTestCase {
    
    func testThatTimeIsFormattedCorrectly() {
        let formatter = TimeFormatter(separator: ":")
        let tenSeconds = 10
        let tenSecondsFormattedString = formatter.formatTime(tenSeconds).formattedString
        XCTAssertTrue(tenSecondsFormattedString == "10")
        
        let oneMinuteInSeconds = 60
        let oneMinuteFormattedString = formatter.formatTime(oneMinuteInSeconds).formattedString
        XCTAssertTrue(oneMinuteFormattedString == "1:00")
        
        let oneHourInSeconds = 60 * oneMinuteInSeconds
        let oneHourFormattedString = formatter.formatTime(oneHourInSeconds).formattedString
        XCTAssertTrue(oneHourFormattedString == "1:00:00")
        
        let oneHourOneMintuteAndTenSeconds = oneHourInSeconds + oneMinuteInSeconds + tenSeconds
        let oneHourOneMinuteAndTenSecondsFormattedString = formatter.formatTime(oneHourOneMintuteAndTenSeconds).formattedString
        XCTAssertTrue(oneHourOneMinuteAndTenSecondsFormattedString == "1:01:10")
    }
    
    func testThatOneMinuteHasTwoTimeSections() {
        let formatter = TimeFormatter(separator: ":")
        let oneMinuteInSeconds = 60
        XCTAssert(formatter.formatTime(oneMinuteInSeconds).timeSections == 2)
    }
    
    func testThatOneHourHasThreeTimeSections() {
        let formatter = TimeFormatter(separator: ":")
        let oneHourInSeconds = 60 * 60
        XCTAssert(formatter.formatTime(oneHourInSeconds).timeSections == 3)
    }
    
    func testThatTimeFormatterUsesTheRightSeparator() {
        let formatter = TimeFormatter(separator: "#")
        let oneMinute = 60
        let oneMinuteFormattedString = formatter.formatTime(oneMinute).formattedString
        XCTAssert(oneMinuteFormattedString == "1#00")
    }
}

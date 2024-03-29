//
//  TimerStateArchiverTests.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/4/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import XCTest

class TimerStateArchiverTests: XCTestCase {
    
    let key = "key"

    func testThatTimerStateCanBeSavedAndRetrieved() {
        let timerState = TimerState.zero
        TimerStateArchiver.archive(timerState, key: key)
        let retrievedState = TimerStateArchiver.retrieve(key: key)
        XCTAssert(timerState == retrievedState)
    }
    
    func testThatRetrievedTimerCanBeUpdated() {
        let timerState = runningZeroTimerState()
        TimerStateArchiver.archive(timerState, key: key)
        let retrievedTimerState = TimerStateArchiver.retrieve(key: key)
        if let updatedTimerState = TimerStateArchiver.update(retrievedTimerState!, forDate: Date(timeIntervalSince1970: 1)) {
            XCTAssert(updatedTimerState.timerValue == 1)
        } else {
            XCTFail()
        }
    }
    
    func testThatNilIsReturnedWhenTimerHasPassedZero() {
        var timerState = runningZeroTimerState()
        timerState.timerValue = 1
        timerState.direction = .Down
        TimerStateArchiver.archive(timerState, key: key)
        let retrievedTimerState = TimerStateArchiver.retrieve(key: key)
        if let _ = TimerStateArchiver.update(retrievedTimerState!, forDate: Date(timeIntervalSince1970: 10)) {
            XCTFail()
        }
    }
    
    func testThatTimerStateIsntUpdatedWhenNotRunning() {
        let timerState = TimerState.zero
        TimerStateArchiver.archive(timerState, key: key)
        let retrievedTimerState = TimerStateArchiver.retrieve(key: key)
        if let newTimerState = TimerStateArchiver.update(retrievedTimerState!, forDate: Date(timeIntervalSince1970: 1)) {
            XCTAssert(timerState.timerValue == newTimerState.timerValue)
            XCTAssert(timerState.isRunning == newTimerState.isRunning)
            XCTAssert(newTimerState.timeStamp == Date(timeIntervalSince1970: 1))
        } else {
            XCTFail("Should not have updated time")
        }
    }
    
    private func runningZeroTimerState() -> TimerState {
        var timerState = TimerState.zero
        timerState.timeStamp = Date(timeIntervalSince1970: 0)
        timerState.isRunning = true
        return timerState
    }
    
}

//
//  TimeArchive.swift
//  Big Timer
//
//  Created by Joel Klabo on 3/25/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation

public class TimerState: NSObject, NSCoding {
    
    var timeStamp: NSDate!
    var timerValue: CFTimeInterval!
    var direction: TimerDirection!
    var isRunning: Bool!
    
    required convenience public init(coder decoder: NSCoder) {
        self.init()
        self.timeStamp = decoder.decodeObjectForKey("timeStamp") as! NSDate?
        self.timerValue = decoder.decodeObjectForKey("timerValue") as! CFTimeInterval?
        self.direction = TimerDirection(rawValue:decoder.decodeObjectForKey("direction") as! TimerDirection.RawValue)
        self.isRunning = false
    }
    
    class func newState(timeStamp: NSDate, timerValue: CFTimeInterval, direction: TimerDirection, isRunning: Bool) -> TimerState {
        var newTimerState = TimerState()
        newTimerState.timeStamp = timeStamp
        newTimerState.timerValue = timerValue
        newTimerState.direction = direction
        newTimerState.isRunning = isRunning
        return newTimerState
    }
    
    class func zeroState() -> TimerState {
        return TimerState.newState(NSDate(), timerValue: 0, direction: .Up, isRunning: false)
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.timeStamp, forKey: "timeStamp")
        coder.encodeObject(self.timerValue, forKey: "timerValue")
        coder.encodeObject(self.direction.rawValue, forKey: "direction")
        coder.encodeObject(self.isRunning, forKey: "isRunning")
    }
    
    override public func isEqual(object: AnyObject?) -> Bool {
        if ((object?.isKindOfClass(TimerState)) == true) {
            let timeState = object as! TimerState
            if (timeState.timeStamp == self.timeStamp
            &&  timeState.timerValue == self.timerValue
            &&  timeState.direction == self.direction
            &&  timeState.isRunning == self.isRunning) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
}

enum TimerDirection : String {
    case Up = "up"
    case Down = "down"
}
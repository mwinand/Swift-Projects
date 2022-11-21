//
//  AnimationStepper.swift
//

import Cocoa


/*
 The AnimationStepper class provides an object that can keep track of
 the passage of time for an animation. The length property stores a
 value for the duration of the animation sequence - the value represents
 how many frames long the animation lasts.
 
 The step function should be called once per frame while the animation is running.
 
 The time function returns a Double value in the range 0 to 1. This indicates
 how far along in percentage of time the animation has progressed.
 
 The reset function can be used to prepare the object for another run.
 */

class AnimationStepper {
    // count is the current frame number
    var count: Int
    // length is duration of the animation in frames
    var length: Int
    
    
    init(length: Int) {
        self.length = length
        count = 0
    }
    
    
    // if count hasn't reached length, advance by 1
    // returns true if advancing, false otherwise
    @discardableResult func step() -> Bool {
        if count < length {
            count += 1
            return true
        }
        else {
            return false
        }
    }
    
    
    // calculate and return the time value.
    // A value between 0 - 1 as count advances from 0 to length
    func time() -> Double {
        if count <= 0 {
            return 0.0
        }
        else if count < length {
            return Double(count) / Double(length)
        }
        else {
            return 1.0
        }
    }
    
    
    func reset() {
        count = 0
    }
}

//
//  Box.swift
//  TheHatch
//
//

import Foundation
import Tin


// Possible states for the Box lid
enum LidState {
    case closed
    case opening
    case open
    case closing
}


class Box {
    var x = 400.0
    var y = 150.0
    var width = 200.0
    var wallThickness = 20.0
    var angle = 0.0
    var state = LidState.closed //closed openning open
    var color = 0.7
    
    
    
    // Update the movement of the lid.
    func update() {
        if state == .opening {
            angle += 0.1
            if angle >= .pi {
                angle = .pi
                nextState()
            }
        }
        else if state == .closing {
            angle -= 0.1
            if angle <= 0.0 {
                angle = 0.0
                nextState()
            }
        }
    }
    
    
    // Render the box and the lid.
    func render() {
        // FIX 2. ADD CODE HERE ****************************************
        // What is needed here:
        //    a. Draw the colored background of the box.
        //    b. Draw the left, bottom, and right edges of box.
        //    c. Draw the box lid. (remember, it rotates!)
        //       - save the transformation state
        //       - translate to the correct position
        //       - rotate the lid
        //       - draw the lid so the pivot point is at 0,0
        //       - restore the transformation state
        if state == .closed  {
            fillColor(gray: color)
        } else if state == .open {
            fillColor(red: 0.5, green: 0.4, blue: 1.0, alpha: 1.0)
        } else if state == .opening {
            fillColor(gray: color)
        } else if state == .closing {
            fillColor(red: 0.5, green: 0.4, blue: 1.0, alpha: 1.0)
        }
        
        rect(x: x, y: y, width: width, height: width)
        fillColor(gray: color)
        rect(x: x, y: y, width: wallThickness, height: width)
        rect(x: x, y: y - 20.0, width: width + 20.0, height: wallThickness)
        rect(x: x + width, y: y, width: wallThickness, height: width)
        //lid
        pushState()
        translate(dx: x, dy: y + width)
        rotate(by: angle)
        rect(x: 0.0, y: 0.0, width: width + wallThickness, height: wallThickness)
        popState()
    }
    
    
    // Change the box to the next state.
    func nextState() {
        
        // FIX 3. ADD CODE HERE ****************************************
        // What is needed here:
        //    Change the value of the property state, to transition it to its next value.
        //    Note, there are only 4 valid transitions possible.
        // The possible state transitions are:
        //    closed to opening
        //    opening to open
        //    open to closing
        //    closing to closed
        //only 4 possible transitions allowed
        switch state {
        case .closed:
            state = .opening
        case .opening:
            state = .open
        case .open:
            state = .closing
        case .closing:
            state = .closed
        }
        
    }
    
    
   
}

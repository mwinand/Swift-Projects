//
//  Paddle.swift
//  Breakout
//  Programming for Media Arts
//

import Foundation
import Tin


// Represents the paddle
class Paddle {
    var x: Double
    var y: Double
    var velocityX: Double
    var width: Double
    var height: Double
    
    
    init(x: Double, y: Double, width: Double, height: Double) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        velocityX = 0.0
    }
    
    
    func render() {
        strokeDisable()
        fillColor(gray: 0.95)
        rect(x: x, y: y, width: width, height: height)
    }
    
    
    // Check to see if the paddle overlaps with the puck.
    func intersect(puck: Puck) -> Bool {
        let bx2 = x + width
        let by2 = y + height
        let px2 = puck.x + puck.width
        let py2 = puck.y + puck.width
        if x < px2 && bx2 > puck.x &&
            by2 > puck.y && y < py2 {
            return true
        }
        else {
            return false
        }
    }
    
    
}

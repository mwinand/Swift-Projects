//
//  Puck.swift
//  Breakout
//  Programming for Media Arts
//
//

import Foundation
import Tin


// This class represents the puck (ball).
class Puck {
    var x: Double
    var y: Double
    var velocityX: Double
    var velocityY: Double
    var width: Double
    
    
    init() {
        x = tin.midX
        y = tin.midY + 100
        velocityX = random(min: -4.0, max: 4.0)
        velocityY = random(min: -3.0, max: -4.0)
        width = 10.0
    }
    
    
    func render() {
        strokeDisable()
        fillColor(gray: 1.0)
        rect(x: x, y: y, width: width, height: width)
    }
    
    
    func move() {
        x += velocityX
        y += velocityY
    }
}

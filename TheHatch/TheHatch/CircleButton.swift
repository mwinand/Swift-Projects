//
//  CircleButton.swift
//  TheHatch
//
//

import Foundation
import Tin


// This class represents a button, shaped like a circle, which
// can rotate in either direction.
class CircleButton {
    var x: Double
    var y: Double
    var radius: Double
    var angle: Double
    var speed: Double
    
    // Initializer.
    // Inputs are the position and radius of the button.
    init(x: Double, y: Double, radius: Double) {
        self.x = x
        self.y = y
        self.radius = radius
        angle = 0.0
        speed = 0.08
    }
    
    
    // Updates the angle (rotation) of the button,
    // needs the lidState value as input.
    func update(lidState: LidState) {
        if lidState == .opening {
            angle -= speed
        }
        else if lidState == .closing {
            angle += speed
        }
    }
    
    
    // Draw the button.
    func render() {
        pushState()
        
        fillColor(gray: 0.8)
        strokeColor(gray: 0.1)
        translate(dx: x, dy: y)
        rotate(by: angle)
        ellipse(centerX: 0, centerY: 0, width: radius*2.0, height: radius*2.0)
        line(x1: 0, y1: -radius, x2: 0, y2: radius)
        line(x1: -radius, y1: 0, x2: radius, y2: 0)
        
        popState()
    }
    
    
    // Answers the question: is the input point inside the button?
    // Returns Bool value.
    func isPointInside(positionX: Double, positionY: Double) -> Bool {
        let d = dist(x1: x, y1: y, x2: positionX, y2: positionY)
        if d <= radius {
            return true
        }
        else {
            return false
        }
    }
}

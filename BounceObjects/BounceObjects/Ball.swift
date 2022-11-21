//
//  Ball.swift
//  BounceObjects
//
//  Created by Matheus Winand on 10/28/19.
//  Copyright © 2019 ASU. All rights reserved.
//

import Foundation
import Tin

class Ball {
    var positionX = random(min: 100.0, max: tin.width - 100.0)
    var positionY = random(min: 100.0, max: tin.height - 100.0)
    var radius = 30.0
    var velocityX = 4.5
    var velocityY = -3.0
    var gravity = -0.5
    var bounciness = 0.95
    var colorR = random(max: 1.0)
    var colorG = random(max: 1.0)
    var colorB = random(max: 1.0)
    
    func move(){
        // **********************************************
        // Move the ball
        //
        velocityY = velocityY + gravity
        positionX = positionX + velocityX
        positionY = positionY + velocityY
        
        let rightEdge = tin.width
        let leftEdge = 0.0
        let topEdge = tin.height
        let bottomEdge = 0.0
        
        // Check to see if the ball hit any edge
        if positionX + radius > rightEdge {
            // Hit the right edge
            positionX = rightEdge - radius
            velocityX = velocityX * -1.0 * bounciness
            velocityY *= bounciness
        }
        else if positionX - radius < leftEdge {
            // Hit the left edge
            positionX = radius + leftEdge
            velocityX = velocityX * -1.0 * bounciness
            velocityY *= bounciness
        }
        
        if positionY + radius > topEdge {
            // Hit the top edge
            positionY = topEdge - radius
            velocityY = velocityY * -1.0 * bounciness
            velocityX *= bounciness
        }
        else if positionY - radius < bottomEdge {
            // Hit the bottom edge
            positionY = radius + bottomEdge
            velocityY = velocityY * -1.0 * bounciness
            velocityX *= bounciness
        }
    }
    
    func render() {
        // **********************************************
        // Draw the ball
        //
        strokeColor(gray: 0.0)
        fillColor(red: colorR, green: colorG, blue: colorB, alpha: 1)
        ellipse(centerX: positionX, centerY: positionY, width: radius * 2, height: radius * 2)
    }
}

//
//  Block.swift
//  Breakout
//  Programming for Media Arts
//

import Foundation
import Tin


// This class represents one block. (The game makes 6 rows of blocks)
class Block {
    var x: Double
    var y: Double
    var width: Double
    var height: Double
    var colorR: Double
    var colorG: Double
    var colorB: Double
    var colorA: Double
    
    
    init(x: Double, y: Double, width: Double, height: Double, red: Double, green: Double, blue: Double) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        colorR = red
        colorG = green
        colorB = blue
        colorA = 1.0
    }
    
    
    func render() {
        strokeDisable()
        fillColor(red: colorR, green: colorG, blue: colorB, alpha: colorA)
        rect(x: x, y: y, width: width, height: height)
    }
    
    
    // Check to see if this block overlaps with the puck.
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


// make the Block class adopt the Equatable protocol.
extension Block: Equatable {
    // This is here so that we can use the index(of:) Array method.
    // That is used in the collision function in Scene, when we
    // want to delete a block.
    // It makes it possible to use the == operator with Block objects.
    static func ==(lhs: Block, rhs: Block) -> Bool {
        return lhs === rhs
    }
}

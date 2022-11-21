//
//  ViewController.swift
//  Loops
//


import Cocoa
import Tin


class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "Loops"
        makeView(width: 800.0, height: 600.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    } // End of viewWillAppear function.

} // End of the ViewController class.


class Scene: TScene {
    //
    // The update function is called to draw the view automatically.
    //
    override func update() {
        // *************************************************
        // Insert your drawing code here, below this comment
        background(gray: 0.5)
        
        strokeDisable()
        
        var count = 0.0
        var count2 = 0.0
        while count <= 1000 {
            let w = cos(count) * 100.0
            let x = random(min: 100.0, max: 600.0)
            let y = random(min: 100.0, max: 400.0)
            
            let r = random(min: 0, max: 1)
            let g = random(min: 0, max: 1)
            let b = random(min: 0, max: 1)
            
            //paints the shapes randomly
            fillColor(red: r, green: g, blue: b, alpha: 1.0)
            //create ellipse with random dimensions
            ellipse(centerX: x, centerY: y, width: w, height: w)
            //create rectangle with random dimensions
            rect(x: y, y: x, width: w, height: w)
            
            count += 1
        }
        
        while count2 <= 350 {
            let x2 = random(min: 100.0, max: 600.0)
            let y2 = random(min: 100.0, max: 400.0)
            let x3 = random(min: 100.0, max: 600.0)
            let y3 = random(min: 100.0, max: 400.0)
            
            // create line with random dimensions
            line(x1: x2, y1: y2, x2: x3, y2: y3)
            
            count2 += 1
        }
            
        
        
        
        // Your drawing code should be above this comment.
        // *************************************************
        view?.stopUpdates()
    } // End of the update function.
    
} // End of the Scene class.


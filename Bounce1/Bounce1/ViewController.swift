//
//  ViewController.swift
//  Drawing
//


import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Bounce"
        makeView(width: 800.0, height: 600.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    // ****** PLEASE NOTE ******
    // Variables that are declared here, inside the Scene class block,
    // but outside of the update function, will remember their values
    // for the entire run of the program.
    var positionX = 400.0
    var positionY = 300.0
    var radius = 30.0
    var velocityX = 4.5
    var velocityY = -1.5
    
    
    
    //
    // The update function is called to draw the view automatically.
    //
    override func update() {
        // background erases the view and sets the entire view to one flat
        // color. If you want a different background color, change it here.
        drawBackground()
        moveBall()
        drawBall()
        
    } // End of the update function.
    
    func drawBackground(){
        background(gray: 0.5)
    }
    
    func moveBall(){
        positionX = positionX + velocityX
        positionY = positionY + velocityY
        
        if positionX + radius > tin.width {
            // ran off the right edge
            positionX = tin.width - radius
            velocityX = velocityX * -1.0
        }
        else if positionX - radius < 0 {
            // ran off the left edge
            positionX = radius
            velocityX = velocityX * -1.0
        }
        
        if positionY + radius > tin.height {
            // ran off the top edge
            positionY = tin.height - radius
            velocityY = velocityY * -1.0
        }
        else if positionY - radius < 0 {
            // ran off the bottom edge
            positionY = radius
            velocityY = velocityY * -1.0
        }
    }
    
    func drawBall(){
        positionX = positionX + velocityX
        positionY = positionY + velocityY
        changeColor()
        ellipse(centerX: positionX, centerY: positionY, width: radius * 2, height: radius * 2)
    }
    
    func changeColor(){
        strokeColor(gray: 0)
        fillColor(gray: 1.0)
    }
    
} // End of the Scene class.


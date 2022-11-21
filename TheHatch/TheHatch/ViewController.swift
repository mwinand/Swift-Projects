//
//  ViewController.swift
//  


import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "The Hatch"
        makeView(width: 1000.0, height: 600.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    override func mouseUp(with event: NSEvent) {
        scene.checkForButtonPress()
    }
    
}




class Scene: TScene {
    // scene properties here
    var box = Box()
    var button = CircleButton(x: 800, y: 300, radius: 30)
    
    override func update() {
        background(gray: 0.5)
        // FIX 1. ADD CODE HERE ****************************************
        // What is needed here:
        //    a. Update the box lid position. Use the box object's
        //       update method to change the property that has the
        //       value for how much the lid is rotated.
        //    b. Render the box
        //    c. Update the button rotation. Use the button object's
        //       update method. The lid state is available from the state
        //       property of the box object.
        //    d. Render the button
        box.update()
        box.render()
        button.update(lidState: box.state)
        button.render()
        
        
    }
    
    
    // In this function, check to see if the mouse position is inside
    // the button, if it is, advance the box to its next lid state.
    func checkForButtonPress() {
        
        // FIX 4. ADD CODE HERE ****************************************
        // What is needed here:
        //     a. Test to see if the mouse position is inside the button.
        //     b. if it is, change the box lid to its next lid state.
        //        using the appropriate method of the box object.
        //overrise func mouseDragged(with event: NSEvent){
        //super.mouseDragged(with: event)
        //let mouseDx = tin.mouseX(where the mouse is) - tin.pmouseX(where the mouse was)
        //scene.moveCart(dx: mouseDx) (click drag)
        if button.isPointInside(positionX: tin.mouseX, positionY: tin.mouseY) {
            box.nextState()
            
        }
     }
    
}


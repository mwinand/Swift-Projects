//
//  ViewController.swift
//  Drawing
//


import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Drawing"
        makeView(width: 600.0, height: 600.0)
        let scene = Scene()
        present(scene: scene)
    }

}


class Scene: TScene {
    
    //
    // The update function is called to draw the view automatically.
    //
    override func update() {
        // background erases the view and sets the entire view to one flat
        // color. If you want a different background color, change it here.
        background(gray: 0.5)
        
        // *************************************************
        // Insert your drawing code here, below this comment
          //foot L
        fillColor(red: 1, green: 0.1569, blue: 0.4784, alpha: 1.0)
        ellipse(centerX: 200, centerY: 200, width: 60, height: 120)
          //foot R
        fillColor(red: 1, green: 0.1569, blue: 0.4784, alpha: 1.0)
        ellipse(centerX: 400, centerY: 200, width: 60, height: 120)
          //hand L
        fillColor(red: 1, green: 0.6392, blue: 0.9216, alpha: 1.0)
        ellipse(centerX: 450, centerY: 300, width: 85, height: 65)
          //hand R
        fillColor(red: 1, green: 0.6392, blue: 0.9216, alpha: 1.0)
        ellipse(centerX: 150, centerY: 300, width: 85, height: 65)
           //body
        fillColor(red: 1, green: 0.6392, blue: 0.9216, alpha: 1.0)
        ellipse(centerX: 300, centerY: 300, width: 300, height: 300)
          //eyes
        fillColor(red: 0.2392, green: 0.4784, blue: 1, alpha: 1.0)
        ellipse(centerX: 265, centerY: 350, width: 35, height: 73)
        fillColor(red: 0.2392, green: 0.4784, blue: 1, alpha: 1.0)
        ellipse(centerX: 330, centerY: 350, width: 35, height: 73)
        fillColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        ellipse(centerX: 265, centerY: 371, width: 25.5, height: 30)
        fillColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        ellipse(centerX: 330, centerY: 371, width: 25.5, height: 30)
          //blush
        fillColor(red: 0.9176, green: 0, blue: 0.5647, alpha: 1.0)
        ellipse(centerX: 225, centerY: 300, width: 35, height: 20)
        fillColor(red: 0.9176, green: 0, blue: 0.5647, alpha: 1.0)
        ellipse(centerX: 375, centerY: 300, width: 35, height: 20)
          //mouth(close enough)
        arc(x: 300, y: 275, radius: 3.14, startAngle: 90, endAngle: 180)
        
        
        // Your drawing code should be above this comment.
        // *************************************************
        
        view?.stopUpdates()
    }
    
}


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
        let footWidth = 60.0
        let footHeight = 120.0
        let handWidth = 85.0
        let handHeight = 65.0
        let eyeWidth = 35.0
        let eyeHeight = 73.0
        let retinaWidth = 25.5
        let retinaHeight = 30.0
        let blushWidth = 35.0
        let blushHeight = 20.0
        
          //Variables to catch mouse movement
           //pupil height
        var pupilH = tin.mouseY
           //right pupil controller
        var pupilR = tin.mouseX
          //left pupil controller
        var pupilL = tin.mouseX - 65
        
          //If statements to keep the retine within the eye
        if pupilH > 371 {
            pupilH = 371
        }
        if pupilH < 330 {
            pupilH = 330
        }
        if pupilR > 336 {
            pupilR = 336
            pupilL = pupilR - 65
        }
        if pupilR < 324.75 {
            pupilR = 324.75
            pupilL = pupilR - 65
        }
          //foot L
        fillColor(red: 1, green: 0.1569, blue: 0.4784, alpha: 1.0)
        ellipse(centerX: 200, centerY: 200, width: footWidth, height: footHeight)
          //foot R
        fillColor(red: 1, green: 0.1569, blue: 0.4784, alpha: 1.0)
        ellipse(centerX: 400, centerY: 200, width: footWidth, height: footHeight)
          //hand L
        fillColor(red: 1, green: 0.6392, blue: 0.9216, alpha: 1.0)
        ellipse(centerX: 450, centerY: 300, width: handWidth, height: handHeight)
          //hand R
        fillColor(red: 1, green: 0.6392, blue: 0.9216, alpha: 1.0)
        ellipse(centerX: 150, centerY: 300, width: handWidth, height: handHeight)
           //body
        fillColor(red: 1, green: 0.6392, blue: 0.9216, alpha: 1.0)
        ellipse(centerX: 300, centerY: 300, width: 300, height: 300)
          //eyes
        fillColor(red: 0.2392, green: 0.4784, blue: 1, alpha: 1.0)
        ellipse(centerX: 265, centerY: 350, width: eyeWidth, height: eyeHeight)
        fillColor(red: 0.2392, green: 0.4784, blue: 1, alpha: 1.0)
        ellipse(centerX: 330, centerY: 350, width: eyeWidth, height: eyeHeight)
        //ask how to move eyes within range.
        fillColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        ellipse(centerX: pupilR, centerY: pupilH, width: retinaWidth, height: retinaHeight)
        fillColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        ellipse(centerX: pupilL, centerY: pupilH, width: retinaWidth, height: retinaHeight)
          //blush
        fillColor(red: 0.9176, green: 0, blue: 0.5647, alpha: 1.0)
        ellipse(centerX: 225, centerY: 300, width: blushWidth, height: blushHeight)
        fillColor(red: 0.9176, green: 0, blue: 0.5647, alpha: 1.0)
        ellipse(centerX: 375, centerY: 300, width: blushWidth, height: blushHeight)
          //mouth(close enough)
        arc(x: 300, y: 275, radius: 3.14, startAngle: 90, endAngle: 180)
        
        
        // Your drawing code should be above this comment.
        // *************************************************
        
    }
    
}


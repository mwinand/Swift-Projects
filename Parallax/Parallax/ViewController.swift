//
//  ViewController.swift

//

import Cocoa
import Tin


class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.title = "Parallax"
        makeView(width: 1000.0, height: 600.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

} // end of ViewController class


class Scene: TScene {
    // The ! after TImage is important here.
    // We don't create the TImage object until the setup function runs.
    var bird: TImage!
    
    
    override func setup() {
        // The image must be added to the Xcode project.
        // The image also needs to be part of the "target membership"
        // of this application. Select the image, and look at the
        // File inspector to verify the membership.
        bird = TImage(contentsOfFileInBundle: "puffin_medium.jpg")
    } // end of setup function
    
    
    override func update() {
        background(gray: 0.5)
        
        // Draw the image centered in the view.
        // x,y is the bottom, left corner of the image.
        let x = tin.midX - (bird.width / 2.0)
        let y = tin.midY - (bird.height / 2.0)
        bird.draw(x: x, y: y)
        
        
        // Draw the image again, this time, resize it to be smaller.
        // Draw it near the bottom, left corner of view.
        bird.draw(x: 60, y: 60, width: 241, height: 160)
        // Put a white border around the smaller image
        fillDisable()
        strokeColor(gray: 1.0)
        lineWidth(3)
        rect(x: 60, y: 60, width: 241, height: 160)

    } // end of update function
    
} // end of Scene class


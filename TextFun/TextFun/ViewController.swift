//
//  ViewController.swift
//


import Cocoa
import Tin


class ViewController: TController {
    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "Text Fun"
        makeView(width: 800.0, height: 600.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    //
    // press the s key to start the animation
    //
    override func keyUp(with event: NSEvent) {
        if event.characters == "s" {
            scene.startAnimation()
        }
        else if event.characters == "r" {
            scene.reset()
        }
    }

}


class Scene: TScene {
    
    var font1 = TFont(fontName: "Times New Roman", ofSize: 60.0)
    
    var isAnimationRunning = false
    var stepper1 = AnimationStepper(length: 120)
    
    
    override func setup() {
        reset()
    } // end of setup function
    
    
    override func update() {
        background(gray: 0.5)
        
        if isAnimationRunning {
            animationStep()
        }

        
        let time1 = stepper1.time()
        let startX1 = -300.0
        let endX1 = -10.0
        let x1 = easeInQuad(value: time1, start: startX1, stop: endX1)
        let y1 = 50.0
        
        translate(dx: tin.midX, dy: tin.midY)
        rotate(by: Double.pi / 6.0)
        pushState()
        translate(dx: x1, dy: 0.0)
        fillColor(gray: 0.8)
        text(message: "CODING", font: font1, x: x1, y: y1)
        popState()
        
        pushState()
        translate(dx: x1, dy: 0.0)
        fillColor(gray: 1.0)
        text(message: "IS", font: font1, x: x1 - 50, y: y1 - 50)
        popState()
        
        pushState()
        translate(dx: x1, dy: 0.0)
        fillColor(red: 1.0, green: 0, blue: 0, alpha: 0.5)
        text(message: "FUN", font: font1, x: x1 - 100, y: y1 - 100)
        popState()
        
        pushState()
        translate(dx: x1, dy: 0.0)
        fillColor(gray: 0.6)
        text(message: "SOMETIMES", font: font1, x: x1 - 150, y: y1 - 150)
        popState()
        

    } // end of update function
    
    
    // Set the values for any variables to position
    // the text for the beginning of the animation.
    func reset() {
        stepper1.reset()
    }
    
    
    // Start the animation running
    func startAnimation() {
        isAnimationRunning = true
        
        // Add code to here to setup
        // any values for the start of the
        // animation.
        stepper1.reset()
        
    } // end of startAnimation function
    

    // Move the values forward one frame
    func animationStep() {
        // call step() for any AnimationStepper objects here
        
        if stepper1.step() == false {
            isAnimationRunning = false
        }
        
        
    } // end of animationStep function
    
}


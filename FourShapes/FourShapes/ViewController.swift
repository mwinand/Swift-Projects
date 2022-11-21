//
//  ViewController.swift
//  FourShapes
//
//

import Cocoa
import Tin


class ViewController: TController {

    var scene: Scene!
    
    //
    // viewWillAppear will be called once, just before the view is placed on screen.
    //
    override func viewWillAppear() {
        view.window?.title = "Four Shapes"
        makeView(width: 800.0, height: 400.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    } // End of viewWillAppear function.

} // End of the ViewController class.



class Scene: TScene {
    // ****** PLEASE NOTE ******
    // Variables that are declared here, inside the Scene class block,
    // but outside of the update function, will remember their values
    // for the entire run of the program.
    
    //square size
    var size = 120.0
    //square coordinate Y
    var sqrY = 150.0
    //coordinates X for squares A to D
    var sqrA = 50.0
    var sqrB = 250.0
    var sqrC = 450.0
    var sqrD = 650.0
    //Validators for mouse over function to work easier.
    var conditionA = false
    var conditionB = false
    var conditionC = false
    var conditionD = false
    
    
    
    //
    // The update function is called to draw the view automatically.
    //
    override func update() {
        // ****** IMPORTANT - PLEASE NOTE ******
        // Variables declared here, inside the update function,
        // only remember values for one call (execution) to the update function.
        // When update is called again to redraw the view, a variable
        // declared inside the function will not remember its previous value.
        
        //mouse X and Y points on canvas
        let MouseX = tin.mouseX
        let MouseY = tin.mouseY
        
        
        background(gray: 0.5)
        
        // *************************************************
        // Insert your drawing code here, below this comment

        //checks if mouse is over D square
        if MouseX >= sqrD && MouseX <= sqrD + size && MouseY >= sqrY && MouseY <= sqrY + size && conditionC == true && conditionB == true && conditionA == true {
            conditionD = true
        }
        //Draws D
        rect(x: sqrD, y: sqrY, width: size, height: size)
        
        //checks if mouse is over C square and if A and B are colored
        if MouseY >= sqrY && MouseY <= sqrY + size && MouseX >= sqrC && MouseX <= sqrC + size && conditionB == true && conditionA == true {
            conditionC = true
        }
        //changes color in case conditions are met.
        if conditionC == true {
            fillColor(red: 0.1, green: 1.0, blue: 0.1, alpha: 1.0)
        }
        //if mouse over D paint C white
        if conditionD == true {
            fillColor(red: 1, green: 1, blue: 1, alpha: 1.0)
            conditionC = false
        }
        //draws C
        rect(x: sqrC, y: sqrY, width: size, height: size)
        
        //Checks if A is colored and if mouse is over B
        if MouseY >= sqrY && MouseY <= sqrY + size && MouseX >= sqrB && MouseX <= sqrB + size && conditionA == true {
            conditionB = true
        }
        //changes color in case mouse over B and A is colored
        if conditionB == true {
            fillColor(red: 0.1, green: 0.1, blue: 1.0, alpha: 1.0)
        }
        //if mouse over D paint B white white
        if conditionD == true {
            fillColor(red: 1, green: 1, blue: 1, alpha: 1.0)
            conditionB = false
        }
        //draws B
        rect(x: sqrB, y: sqrY, width: size, height: size)
        
        //checks if mouse is over A
        if MouseY >= sqrY && MouseY <= sqrY + size && MouseX >= sqrA && MouseX <= sqrA + size {
            conditionA = true
        }
        //if true paint A red
        if conditionA == true {
            fillColor(red: 1.0, green: 0.1, blue: 0.1, alpha: 1.0)
        }
        //if mouse over D paint A white
        if conditionD == true {
            fillColor(red: 1, green: 1, blue: 1, alpha: 1.0)
            conditionA = false
        }
        //draws A
        rect(x: sqrA, y: sqrY, width: size, height: size)
        
        conditionD = false
        // Your drawing code should be above this comment.
        // *************************************************
        
    } // End of the update function.
    
    
} // End of the Scene class.

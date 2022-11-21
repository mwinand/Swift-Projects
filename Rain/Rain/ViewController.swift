//
//  ViewController.swift
//


import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Rain"
        makeView(width: 800.0, height: 600.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    // These four arrays hold all data about the rain drops.
    // xList, yList are the (x,y) position values respectivly.
    // radiusList is the size of the drops.
    // speedList is rate of movement (y axis)
    var xList: [Double] = []
    var yList: [Double] = []
    var radiusList: [Double] = []
    var speedList: [Double] = []
    
    
    // noiseOffset is used by the wind function.
    // It creates movement in the wind noise values.
    var noiseOffset = 0.0
    
    override func update() {
        background(gray: 0.3)
        
        noiseOffset = Double(tin.frameCount) / 60.0
        
        // TODO #2 ******************************************************
        //
        // Add new drop(s) here.
        // Call the addDrop function to make a new drop.
        addDrop()
        
        // A loop to move, then draw all drops.
        for i in 0..<xList.count {
            
            moveDrop(index: i)
            
            // TODO #4 ******************************************************
            //
            // Draw a drop here.
            // Call the drawDrop function to render a drop.
            drawDrop(index: i)
            
        }
        
        // A loop to remove any drops that fell below the view.
        var i = yList.count - 1
        while i >= 0 {
            if yList[i] < -5.0 {
                removeDrop(index: i)
            }
            i -= 1
        }
        
    } // End of the update function
    
    
    // TODO #1 ******************************************************
    //
    // Define the addDrop function here. no parameters.
    // The function's job is to create a new drop, just above top of the view.
    // It should add data for one new drop to the arrays.
    func addDrop(){
        xList.append(random(max: 800.0))
        yList.append(random(max: 600.0))
        radiusList.append(random(max: 10.0))
        speedList.append(50.0)
    }
    
    // TODO #3 ******************************************************
    //
    // Define the drawDrop function here.
    // one parameter - the index of a drop in the arrays.
    // (See the moveDrop function below for an example function with
    // one parameter used for the index of a drop in the arrays.)
    // The function's job is to render (draw) the drop at index value.
    // That means that one call to this function will draw one drop.
    //
    func drawDrop(index: Int){
        let x = xList[index]
        let y = yList[index]
        let radius = radiusList[index]
        strokeDisable()
        fillColor(red: 0, green: 0, blue: 0.3, alpha: 1)
        ellipse(centerX: x, centerY: y, width: radius * 2, height: radius * 2)
    }
    
    
    
    // change the position of drop at index value.
    func moveDrop(index: Int) {
        xList[index] += wind(index: index)
        yList[index] -= speedList[index]
    } // End of moveDrop function
    
    
    // remove the drop at index value.
    func removeDrop(index: Int) {
        xList.remove(at: index)
        yList.remove(at: index)
        radiusList.remove(at: index)
        speedList.remove(at: index)
    } // End of removeDrop function
    
    
    // compute a wind force at drop location.
    func wind(index: Int) -> Double {
        let scale = 1000.0
        let amplitude = 3.0
        let u = xList[index] / scale + noiseOffset
        let v = yList[index] / scale
        let force = noise(x: u, y: v) * amplitude
        return force
    } // End of wind function
}

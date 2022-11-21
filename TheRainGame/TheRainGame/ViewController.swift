//
//  ViewController.swift
//  TheRainGame
//
//  Created by Matheus Winand on 12/11/20.
//

import Cocoa
import SpriteKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let size = CGSize(width: view.frame.width, height: view.frame.height)
        let myScene = Menu(size: size)
        
        
        if let myView = view as? SKView {
            myView.presentScene(myScene)
        }
    }
}

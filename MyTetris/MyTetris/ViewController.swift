//
//  ViewController.swift
//  MyTetris
//
//  Created by Matheus Winand on 30/11/20.
//

import Cocoa
import SpriteKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let size = CGSize(width: 640, height: 800)
        let myScene = Menu(size: size)
        
        
        if let myView = view as? SKView {
            myView.presentScene(myScene)
        }
    }
}


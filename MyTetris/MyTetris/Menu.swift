//
//  Menu.swift
//  MyTetris
//
//  Created by Matheus Winand on 30/11/20.
//

import Cocoa
import SpriteKit

class Menu: SKScene {

    var message = "MyTris"
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.lightGray
        
        let textNode = SKLabelNode(fontNamed: "Arial")
        textNode.text = message
        textNode.fontSize = 48;
        textNode.position = CGPoint(x: frame.midX, y: frame.midY);
        textNode.fontColor = SKColor.black
        addChild(textNode)
        
        let textNode2 = SKLabelNode(fontNamed: "Arial")
        textNode2.text = "Click anywhere to start!"
        textNode2.fontSize = 30;
        textNode2.position = CGPoint(x: frame.midX, y: frame.midY - 100);
        textNode2.fontColor = SKColor.black
        addChild(textNode2)
        
    }
    
    
    override func mouseUp(with event: NSEvent) {
        if (message == "MyTris") {
            guard let view = view else { return }
            let myGame = GameScene(size: size)
            let transition = SKTransition.crossFade(withDuration: 0.5)
            view.presentScene(myGame, transition: transition)
        }
    }
}

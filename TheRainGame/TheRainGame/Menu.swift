//
//  Menu.swift
//  TheRainGame
//
//  Created by Matheus Winand on 12/11/20.
//

import Cocoa
import SpriteKit

class Menu: SKScene {

    var message = "The Rain Game"
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.lightGray
        
        let textNode = SKLabelNode(fontNamed: "Arial")
        textNode.text = message
        textNode.fontSize = 48;
        textNode.position = CGPoint(x: frame.midX, y: frame.midY);
        textNode.fontColor = SKColor.black
        addChild(textNode)
        
        if (message == "The Rain Game") {
            let startTexture = SKTexture(imageNamed: "start")
            let node = SKSpriteNode(texture: startTexture)
            node.position = CGPoint(x: frame.midX, y: 300)
            node.size = CGSize(width: 100, height: 100)
            addChild(node)
        }
    }
    
    
    override func mouseUp(with event: NSEvent) {
        guard let view = view else { return }
        let myGame = Game(size: size)
        let transition = SKTransition.crossFade(withDuration: 0.5)
        view.presentScene(myGame, transition: transition)
    }
}

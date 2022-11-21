//
//  Game.swift
//  TheRainGame
//
//  Created by Matheus Winand on 12/11/20.
//

import Cocoa
import SpriteKit


class Game: SKScene, SKPhysicsContactDelegate {
    
    let DropTexture = SKTexture(imageNamed: "rain_drop")
    var score = 0 {
        didSet{
            updateScoreboard()
        }
    }
    //for some reason my drops did not get deleted if I removed the code related to these variables, even though I switched back to the example in the didBegin method.
    let WorldCategory :UInt32 = 0x1 << 1
    let RainDropCategory :UInt32 = 0x1 << 2
    let FloorCategory :UInt32 = 0x1 << 3

    override func didMove(to view: SKView) {
        createScene()
        
        physicsWorld.contactDelegate = self
        
       var worldFrame = frame
        worldFrame.origin.x -= 100
        worldFrame.origin.y -= 100
        worldFrame.size.height += 200
        worldFrame.size.width += 200
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: worldFrame)
        self.physicsBody?.categoryBitMask = WorldCategory
    }
    
    
    func createScene() {
        backgroundColor = SKColor.black
        
        let playerTexture = SKTexture(imageNamed: "player")
        let node = SKSpriteNode(texture: playerTexture)
        node.position = CGPoint(x: frame.midX, y: 50)
        node.size = CGSize(width: 80, height: 80)
        node.name = "Player"
        let body = SKPhysicsBody(texture: playerTexture, size: node.size)
        body.isDynamic = false
        node.physicsBody = body
        addChild(node)
        
        let floor = SKSpriteNode(color: SKColor.green, size: CGSize(width: frame.width, height: 10))
        floor.position = CGPoint(x: frame.midX, y: 5)
        floor.name = "Floor"
        let floorBody = SKPhysicsBody(rectangleOf: floor.size)
        floorBody.isDynamic = false
        floor.physicsBody = floorBody
        addChild(floor)
        
        let spawnDropsAction = SKAction.sequence([
            SKAction.wait(forDuration: 1.0, withRange: 0.2),
            SKAction.run{
                self.spawnDrop()
            }
        ])
        run(SKAction.repeatForever(spawnDropsAction))
        
        makeScoreboard()
    }
    
    func makeScoreboard(){
        let node = SKLabelNode(fontNamed: "Menlo Bold")
        node.text = "\(score)"
        node.fontSize = 48;
        node.horizontalAlignmentMode = .left
        node.verticalAlignmentMode = .top
        node.position = CGPoint(x: 10, y: frame.height - 10);
        node.name = "Score"
        addChild(node)
    }
    
    func updateScoreboard() {
        guard let node = childNode(withName: "Score") as? SKLabelNode else {return}
        node.text = "\(score)"
        
        if (score >= 25){
            playerWinsTheGame()
        }
    }
    
    func spawnDrop() {
        let raindrop = SKSpriteNode(texture: DropTexture)
        raindrop.name = "Drop"
        raindrop.size = CGSize(width: 50, height: 50)
        raindrop.physicsBody = SKPhysicsBody(texture: DropTexture, size: raindrop.size)
        let xPosition = CGFloat.random(in: 0...frame.width)
        let yPosition = size.height + raindrop.size.height
        raindrop.position = CGPoint(x: xPosition, y: yPosition)
        
        raindrop.physicsBody?.categoryBitMask = RainDropCategory
        raindrop.physicsBody?.contactTestBitMask = FloorCategory | WorldCategory
 
        addChild(raindrop)
    }
    
    override func keyDown(with event: NSEvent) {
        guard let player = childNode(withName: "Player") else { return }
        let char = Int(event.keyCode)
        if (char == 123) {
            player.run(SKAction.moveBy(x: -100, y: 0, duration: 0.1))
        } else if (char == 124){
            player.run(SKAction.moveBy(x: 100, y: 0, duration: 0.1))
        } else if (event.characters == "0") {
            playerWinsTheGame()
        }

    }
    
    func playerWinsTheGame(){
        let myScene = Menu(size: size)
        myScene.message = "You Win"
        view?.presentScene(myScene, transition: SKTransition.crossFade(withDuration: 0.5))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else {
            print("Contact does not have two nodes")
            return
        }
        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }
        
        if nameA == "Floor" && nameB == "Drop" {
            nodeB.run(SKAction.removeFromParent())
            score -= 1
            updateScoreboard()
        } else if nameA == "Player" {
            nodeB.run(SKAction.removeFromParent())
            score += 1
            updateScoreboard()
        } else if nameB == "Player" {
            nodeA.run(SKAction.removeFromParent())
            score += 1
            updateScoreboard()
        }
    }
}

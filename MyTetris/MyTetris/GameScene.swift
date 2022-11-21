//
//  GameScene.swift
//  MyTetris
//
//  Created by Matheus Winand on 30/11/20.
//
// It's hard to get help without being able to be at office hours, but I tried my best with the emails we were able to exchange
// Thank you for the semester and your help.

import Cocoa
import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let shapeCategory: UInt32 = 0x1 << 0
    let floorCategory: UInt32 = 0x1 << 1
	let restingCategory: UInt32 = 0x1 << 2
    let loadSndEffects = true
	public var shapeName: String?
    var soundEffectActions: [String: SKAction]!
    var mute = false
    var score = 0 {
        didSet{
            updateScoreboard()
        }
    }
    
    override func didMove(to view: SKView) {
        createScene()
        
		physicsWorld.contactDelegate = self
		physicsWorld.gravity = CGVector(dx: 0, dy: -0.5)
        
        if loadSndEffects && soundEffectActions == nil {
            soundEffectActions = [
                "land":   SKAction.playSoundFileNamed("land.wav",   waitForCompletion: true),
                "clear":  SKAction.playSoundFileNamed("clear.wav",  waitForCompletion: false)
            ]
        } else {
            soundEffectActions = [String: SKAction]()
        }
    }
    
    func createScene() {
        backgroundColor = SKColor.black
        
		let floor = SKSpriteNode(color: SKColor.green, size: CGSize(width: frame.width, height: 10))
		floor.position = CGPoint(x: 200, y: 5)
		floor.name = "Floor"
		let floorBody = SKPhysicsBody(rectangleOf: floor.size)
		floorBody.isDynamic = false
		floor.physicsBody = floorBody
		floorBody.allowsRotation = false
		floorBody.categoryBitMask = floorCategory
		floorBody.contactTestBitMask = shapeCategory | restingCategory
		addChild(floor)
        
        let top = SKSpriteNode(color: SKColor.black, size: CGSize(width: frame.width, height: 10))
		top.position = CGPoint(x: 200, y: 800)
        top.name = "top"
        let topBody = SKPhysicsBody(rectangleOf: top.size)
        topBody.isDynamic = false
        top.physicsBody = topBody
		topBody.allowsRotation = false
        addChild(top)
		
		let left = SKSpriteNode(color: SKColor.green, size: CGSize(width: 10, height: 800))
		left.position = CGPoint(x: 5, y: 400)
		left.name = "left"
		let leftBody = SKPhysicsBody(rectangleOf: left.size)
		leftBody.isDynamic = false
		left.physicsBody = leftBody
		leftBody.allowsRotation = false
		addChild(left)
		
		let right = SKSpriteNode(color: SKColor.green, size: CGSize(width: 10, height: 800))
		right.position = CGPoint(x: 525, y: 400)
		right.name = "right"
		let rightBody = SKPhysicsBody(rectangleOf: right.size)
		rightBody.isDynamic = false
		right.physicsBody = rightBody
		rightBody.allowsRotation = false
		addChild(right)
        
        SpawnShape()
        makeScoreboard()
    }
    
    func makeScoreboard(){
		let text = SKLabelNode(fontNamed: "Menlo Bold")
		text.text = "Score:"
		text.fontSize = 24;
		text.horizontalAlignmentMode = .left
		text.verticalAlignmentMode = .top
		text.position = CGPoint(x: frame.width - 100, y: frame.height - 50);
		text.name = "text"
		addChild(text)
        let node = SKLabelNode(fontNamed: "Menlo Bold")
        node.text = "\(score)"
        node.fontSize = 48;
        node.horizontalAlignmentMode = .left
        node.verticalAlignmentMode = .top
        node.position = CGPoint(x: frame.width - 100, y: frame.height - 100);
        node.name = "Score"
        addChild(node)
    }
    
    func updateScoreboard() {
        guard let node = childNode(withName: "Score") as? SKLabelNode else {return}
        node.text = "\(score)"
    }
    
    
    func SpawnShape(){
        var shapeTexture: SKTexture
        let SquareTexture = SKTexture(imageNamed: "Square")
        let TTexture = SKTexture(imageNamed: "T")
        let ZTexture = SKTexture(imageNamed: "Z")
        let LTexture = SKTexture(imageNamed: "L")
        let ITexture = SKTexture(imageNamed: "I")

            let randomN = Int.random(in: 0..<5)

            switch randomN {

            case 0:

                shapeTexture = SquareTexture

                shapeName = "Square"

            case 1:

                shapeTexture = TTexture

                shapeName = "T"

            case 2:

                shapeTexture = ZTexture

                shapeName = "Z"
                
            case 4:

                shapeTexture = ITexture

                shapeName = "I"
                
            case 5:

                shapeTexture = LTexture

                shapeName = "L"

            default:

                shapeTexture = SquareTexture

                shapeName = "Square"

            }

            
        //guard let bg = childNode(withName: "Background") as? SKLabelNode else {return}
            let node = SKSpriteNode(texture: shapeTexture)
            node.position = CGPoint(x: 100, y: frame.height - 50)
            node.name = shapeName
            node.size = CGSize(width: 80, height: 80)
            let body = SKPhysicsBody(texture: shapeTexture, size: node.size) //rectangleof doesn't really work here since
            body.isDynamic = true											//the shapes should fit
            node.physicsBody = body
			body.allowsRotation = false
			body.categoryBitMask = shapeCategory
			body.contactTestBitMask = floorCategory | restingCategory
			body.restitution = 0.0
			body.angularDamping = 0
			body.linearDamping = 0
			body.friction = 0
			node.speed = 0.2
            addChild(node)
    }
    
    override func keyDown(with event: NSEvent) {
		guard let player = childNode(withName: shapeName!) as? SKLabelNode else {return}
        let char = Int(event.keyCode)
        if (char == 123) {
            player.run(SKAction.moveBy(x: -100, y: 0, duration: 0.1))
        } else if (char == 124){
            player.run(SKAction.moveBy(x: 100, y: 0, duration: 0.1))
        } else if (char == 125){
            player.run(SKAction.moveBy(x: 0, y: -100, duration: 0.1))
        } else if (char == 126){
            player.zRotation = CGFloat.pi / 2.0
        } else if (event.characters == "0") {
            playerLosesTheGame()  //skip to lose screen
        } else if (event.characters == "9"){
            Backtomenu() //back to menu screen
        }
    }
    
    func Backtomenu(){
        let myScene = Menu(size: size)
        myScene.message = "MyTris"
    }
    func playerLosesTheGame(){
        let myScene = Menu(size: size)
        myScene.message = "You Lose"
        view?.presentScene(myScene, transition: SKTransition.crossFade(withDuration: 0.5))
    }
    
    func playSoundEffect(_ name: String) {
        if loadSndEffects && !self.mute {
            if let sndEffectAction = self.soundEffectActions[name] {
                self.run(sndEffectAction)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeB = contact.bodyB.node else { return }
        guard let nodeA = contact.bodyA.node else { return }
        guard let nameB = nodeB.name else { return }
        guard let nameA = nodeA.name else { return }
		//var rightcheck = false
		//var leftcheck = false
		
		if nameA == "top" && nameB == shapeName{
			playerLosesTheGame()
		}
		
		/*if nameA == "right" && (nameB == shapeName || nameB == "staticNode") {
			rightcheck = true
		} else {
			rightcheck = false
		}
		
		if nameA == "left" && (nameB == shapeName || nameB == "staticNode") {
			leftcheck = true
		} else {
			leftcheck = false
		}
        
		if leftcheck == true && rightcheck == true {
			nodeB.position.x
		}*/
		
        if ((nameA == "Floor" || nameA == "staticNode") && nameB == shapeName) {
			nodeB.physicsBody?.isResting = true
            nodeB.physicsBody?.isDynamic = false
            nodeB.physicsBody?.allowsRotation = false
			nodeB.speed = 0.0
			nodeB.name = "staticNode"
			nodeB.physicsBody?.categoryBitMask = restingCategory
			nodeB.physicsBody?.contactTestBitMask = shapeCategory | floorCategory
			playSoundEffect("land")
			SpawnShape()
		} else if (nameA == shapeName && nameB == "staticNode") {
			nodeA.physicsBody?.isResting = true
			nodeA.physicsBody?.isDynamic = false
			nodeA.physicsBody?.allowsRotation = false
			nodeA.speed = 0.0
			nodeA.name = "staticNode"
			nodeA.physicsBody?.categoryBitMask = restingCategory
			nodeA.physicsBody?.contactTestBitMask = shapeCategory | floorCategory
			playSoundEffect("land")
			SpawnShape()
		}
		
    }
}

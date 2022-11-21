//
//  ViewController.swift
//  Breakout
//  Programming for Media Arts
//
//  Inspired by the classic Atari video game from 1976.
//  https://en.wikipedia.org/wiki/Breakout_(video_game)
//
//  This game is pretty straight forward, but compared to what
//  we have looked at so far, its a larger, more complete program.
//  Still, this is a small, simple program.
//
//  There are three custom classes used: Block, Paddle, and Puck.

import Cocoa
import Tin
import AVFoundation


class ViewController: TController {

    var scene: Scene!
    
    //
    // viewWillAppear will be called once, just before the view is placed on screen.
    //
    override func viewWillAppear() {
        view.window?.title = "Breakout"
        makeView(width: 600.0, height: 800.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    // MARK: - NSResponder methods
    
    //
    // keyDown event happens when the user first presses down on keyboard key.
    // The event parameter has detailed info about what key(s) are pressed.
    override func keyDown(with event: NSEvent) {
        if event.characters == " " {
            // spacebar
            if scene.state == .demo || scene.state == .over || scene.state == .won {
                scene.startGame()
            }
            else if scene.state == .ready {
                scene.state = .play
            }
            return
        }
        else if event.characters == "j" {
            scene.movePaddle(amount: -15.0)
            return
        }
        else if event.characters == "k" {
            scene.movePaddle(amount: 15.0)
            return
        }
        
        // Ask Cocoa framework to look at event, and generate
        // one of the standard responses.
        // This will allow the use of the arrow keys on the keyboard.
        // The moveLeft and moveRight functions below get called.
        interpretKeyEvents([event])
    }
    
    
    override func moveLeft(_ sender: Any?) {
        scene.movePaddle(amount: -15.0)
    }
    
    override func moveRight(_ sender: Any?) {
        scene.movePaddle(amount: 15.0)
    }

}


// an enumeration to define possible game states.
enum GameMode {
    case demo     // The game begins in demo mode, to attract players!
    case ready    // Waiting for the player to resume, after loosing a puck.
    case play     // The player is playing!
    case over     // Game over, the player lost.
    case won      // Game over, the player cleared all the blocks, and won.
}


class Scene: TScene {
    
    var leftBorder = 0.0
    var rightBorder = 0.0
    var topBorder = 0.0
    var bottomBorder = 0.0
    var demoFloor = 0.0
    
    // Following are the primary objects that implement the game elements.
    var puck: Puck!
    var paddle: Paddle!
    var blocks: [Block] = []
    
    // playerLives really represents how many pucks the player gets.
    var playerLives = 3
    
    // score one point for each block that the player hits.
    var playerScore = 0
    
    // TFont is used for drawing text in the view.
    var font = TFont(fontName: "Courier New Bold", ofSize: 40.0)
    var msgFont = TFont(fontName: "Helvetica Neue Light", ofSize: 18.0)
    
    // AVAudioPlayer is part of AVFoundation, its used to play a sound file.
    var paddleSound: AVAudioPlayer!
    var edgeSound: AVAudioPlayer!
    var blockSound: AVAudioPlayer!
    
    var state = GameMode.demo

    
    // The setup function is called once, before any drawing.
    override func setup() {
        setupAudio()
        gameReset()
    }
    
    //
    // The update function is called to draw the view automatically.
    //
    override func update() {
        background(gray: 0.25)
        
        if state == .play || state == .demo {
            puck.move()
            collisions()
        }
        
        drawBorder()
        drawInfo()
        for b in blocks {
            b.render()
        }
        paddle.render()
        puck.render()
    }
    
    
    // Should be called before each new game.
    func startGame() {
        state = .play
        gameReset()
    }
    
    
    // Prepare the audio for playback.
    // This only needs to happen one time, when the program starts.
    func setupAudio() {
        let paddleURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Sound2.wav", ofType: "")!)
        paddleSound = try! AVAudioPlayer(contentsOf: paddleURL)
        paddleSound.prepareToPlay()
        
        let edgeURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Sound3.wav", ofType: "")!)
        edgeSound = try! AVAudioPlayer(contentsOf: edgeURL)
        edgeSound.prepareToPlay()
        
        let blockURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Block.wav", ofType: "")!)
        blockSound = try! AVAudioPlayer(contentsOf: blockURL)
        blockSound.prepareToPlay()
    }
    
    
    // Set all elements to default starting values.
    func gameReset() {
        leftBorder = 10.0
        rightBorder = tin.width - 10.0
        topBorder = tin.height - 10.0
        bottomBorder = 0.0
        demoFloor = 50.0
        puck = Puck()
        paddle = Paddle(x: tin.midX - 25, y: 75.0, width: 50, height: 8)
        blocksReset()
        playerLives = 3
        playerScore = 0
    }
    
    
    // Clear and reset all blocks.
    func blocksReset() {
        let numberOfRows = 6
        let blocksInOneRow = 10
        let rowWidth = rightBorder - leftBorder
        let margin = 5.0
        let w =  (rowWidth - Double(blocksInOneRow + 1) * margin) / Double(blocksInOneRow)
        let h = 20.0
        
        blocks.removeAll()
        
        var hue = 15.0 / 360.0
        let saturation = 0.89
        let brightness = 0.95
        var y = tin.height - 200.0
        for _ in 1...numberOfRows {
            var x = leftBorder + margin
            let color = NSColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: CGFloat(brightness), alpha: 1.0)
            for _ in 1...blocksInOneRow {
                let b = Block(x: x, y: y, width: w, height: h, red: Double(color.redComponent), green: Double(color.greenComponent), blue: Double(color.blueComponent))
                blocks.append(b)
                x += w + margin
            }
            y += h + margin
            hue += 0.14
        }
    }
    
    
    // Draw the text elements in the view. (score, lives, special messages)
    func drawInfo() {
        font.horizontalAlignment = .left
        text(message: "\(playerScore)", font: font, x: leftBorder + 10.0, y: tin.height - 55.0)
        
        font.horizontalAlignment = .right
        text(message: "\(playerLives)", font: font, x: rightBorder - 10.0, y: tin.height - 55.0)
        
        msgFont.horizontalAlignment = .center
        if state == .demo {
            text(message: "Press the spacebar to start", font: msgFont, x: tin.midX, y: tin.midY)
        }
        else if state == .ready {
            text(message: "Press the spacebar to resume", font: msgFont, x: tin.midX, y: tin.midY)
        }
        else if state == .over {
            text(message: "Game over", font: msgFont, x: tin.midX, y: tin.midY)
        }
        else if state == .won {
            text(message: "You won!", font: msgFont, x: tin.midX, y: tin.midY)
        }
    }
    
    
    func drawBorder() {
        strokeDisable()
        if state == .demo {
            fillColor(red: 0.7, green: 0.9, blue: 0.7, alpha: 1)
            rect(x: 0, y: demoFloor - 10.0, width: tin.width, height: 10.0)
        }
        fillColor(gray: 0.9)
        rect(x: 0, y: 0, width: leftBorder, height: tin.height)
        rect(x: 0, y: topBorder, width: tin.width, height: tin.height - topBorder)
        rect(x: rightBorder, y: 0, width: tin.width - rightBorder, height: tin.height)
    }
    
    
    func blockCollision() -> Bool {
        // Puck collides with blocks?
        // We could probably easily optimize this to improve perfomance.
        // The current approach is very naive - and simple.
        for block in blocks {
            if block.intersect(puck: puck) {
                if puck.velocityY > 0 {
                    puck.y = block.y - puck.width
                }
                else {
                    puck.y = block.y + block.height
                }
                puck.velocityY *= -1
                
                if let index = blocks.firstIndex(of: block) {
                    blocks.remove(at: index)
                    blockSound.play()
                }
                playerScore += 1
                if blocks.count == 0 {
                    state = .won
                }
                return true
            }
        }
        return false
    }
    
    
    func paddleCollision() -> Bool {
        // Puck collides with paddle?
        if paddle.intersect(puck: puck) {
            paddleSound.play()
            puck.y = paddle.y + paddle.height
            let distanceFromCenter = (puck.x + puck.width/2.0) - (paddle.x + paddle.width/2.0)
            let d = constrain(value: distanceFromCenter / paddle.width, min: -1.0, max: 1.0) * -1
            puck.velocityY *= -1
            let temp = puck.velocityX
            puck.velocityX = puck.velocityX * cos(d) - puck.velocityY * sin(d)
            puck.velocityY = temp * sin(d) + puck.velocityY * cos(d)
            return true
        }
        return false
    }
    
    
    func edgeCollision() {
        // Puck collides with edges?
        if puck.x < leftBorder {
            puck.x = leftBorder
            puck.velocityX *= -1
            edgeSound.play()
        }
        else if puck.x + puck.width > rightBorder {
            puck.x = rightBorder - puck.width
            puck.velocityX *= -1
            edgeSound.play()
        }
        
        if puck.y < bottomBorder {
            // player missed!
            playerLives -= 1
            if playerLives > 0 {
                state = .ready
            }
            else {
                state = .over
            }
            puck = Puck()
        }
        else if puck.y + puck.width > topBorder {
            puck.y = topBorder - puck.width
            puck.velocityY *= -1
            edgeSound.play()
        }
        
        if state == .demo && puck.y < demoFloor {
            // Only in demo mode, don't let the puck hit the bottom.
            puck.y = demoFloor
            puck.velocityY *= -1
            edgeSound.play()
        }
    }
    
    
    // Check for all puck collisions
    func collisions() {
        if blockCollision() {
            return
        }
        if paddleCollision() {
            return
        }
        
        edgeCollision()
    }
    
    
    
    func movePaddle(amount: Double) {
        paddle.x += amount
    }
    
    
    
    
}





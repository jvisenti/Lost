//
//  LevelScene.swift
//  Lost
//
//  Created by Rob Visentin on 2/22/16.
//  Copyright © 2016 Rob Visentin. All rights reserved.
//

import SpriteKit

final class LevelScene : SKScene {

    private let background = SKSpriteNode(imageNamed: "bg-pink")

    private let player = Player()
    private let blackHoles = [BlackHole(), BlackHole()]
    private let touchNode = SKNode()

    private var lastUpdate: NSTimeInterval?

    private var moving: Bool = false {
        didSet {
            player.constraints?.first?.enabled = moving
            player.movementSpeed = moving ? 150.0 : 0.0
        }
    }

    private var gameOver = false

    override init(size: CGSize) {
        super.init(size: size)

        scaleMode = .ResizeFill

        configurePhysicsWorld()

        // Sprite Kit rendering obeys children order, unless told to ignore it
        // This means the render order is background -> black holes -> player -> etc...
        addChild(background)
        blackHoles.forEach { self.addChild($0) }
        addChild(player)
        addChild(touchNode)

        player.position = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)

        // Always point the player towards the touch location
        player.constraints = [
            SKConstraint.orientToNode(touchNode, offset: SKRange(constantValue: 0.0)),
        ]
        player.constraints?.first?.enabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Fixed layout should occur in this function
    override func didChangeSize(oldSize: CGSize) {
        super.didChangeSize(oldSize)

        physicsBody = {
            let body = SKPhysicsBody(edgeLoopFromRect: frame)
            body.categoryBitMask = PhysicsCategory.world
            body.restitution = 0.0
            body.friction = 0.0

            return body
        }()

        background.size = size
        background.position = CGPoint(0.5 * size)

        blackHoles.forEach { $0.radius = 0.15 * min(size) }

        blackHoles[0].position = CGPoint(x: 0.25 * size.width, y: 0.5 * size.height)
        blackHoles[1].position = CGPoint(x: 0.75 * size.width, y: 0.5 * size.height)
    }

    override func update(currentTime: NSTimeInterval) {
        // This block of code will execute just before the function exits, no matter where the return occurs
        defer {
            lastUpdate = currentTime
        }

        guard let lastUpdate = lastUpdate where !gameOver else {
            return
        }

        // Tell the player to update itself with the given time delta
        player.update(currentTime - lastUpdate)

        // When player is removed from the scene, the game ends
        gameOver = (player.parent == nil)

        if gameOver {
            // Delay 1 sec before presenting the Game Over screen
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                self.view?.presentScene(GameOverScene(size: self.size), transition: SKTransition.crossFadeWithDuration(1.0))
            }
        }
    }

}

// MARK: - Contact Handling

extension LevelScene : SKPhysicsContactDelegate {

    func didBeginContact(contact: SKPhysicsContact) {
        // Maintain strong references so the nodes aren't deallocated before the end of this function
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node

        if let nodeB = nodeB {
            nodeA?.didBeginContactWithNode(nodeB)
        }

        if let nodeA = nodeA {
            nodeB?.didBeginContactWithNode(nodeA)
        }
    }

    func didEndContact(contact: SKPhysicsContact) {
        // Maintain strong references so the nodes aren't deallocated before the end of this function
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node

        if let nodeB = nodeB {
            nodeA?.didEndContactWithNode(nodeB)
        }

        if let nodeA = nodeA {
            nodeB?.didEndContactWithNode(nodeA)
        }
    }
}

// MARK: - Touch Handling

extension LevelScene {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)

        if let touch = touches.first {
            touchNode.position = touch.locationInNode(self)
            moving = true
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)

        if let touch = touches.first {
            touchNode.position = touch.locationInNode(self)
            moving = true
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        moving = false
    }

    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        moving = false
    }

}

// MARK: - Private

private extension LevelScene {

    func configurePhysicsWorld() {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }

}

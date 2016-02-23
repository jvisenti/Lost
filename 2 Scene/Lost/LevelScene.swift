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

    override init(size: CGSize) {
        super.init(size: size)

        scaleMode = .ResizeFill

        configurePhysicsWorld()

        // Sprite Kit rendering obeys children order, unless told to ignore it
        addChild(background)
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

// MARK: - Private

private extension LevelScene {

    func configurePhysicsWorld() {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }

}

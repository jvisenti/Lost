//
//  LevelScene.swift
//  Lost
//
//  Created by Rob Visentin on 2/22/16.
//  Copyright © 2016 Rob Visentin. All rights reserved.
//

import SpriteKit

final class LevelScene : SKScene {

    override init(size: CGSize) {
        super.init(size: size)

        scaleMode = .ResizeFill

        configurePhysicsWorld()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

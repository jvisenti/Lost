//
//  BlackHole.swift
//  Lost
//
//  Created by Rob Visentin on 2/22/16.
//  Copyright © 2016 Rob Visentin. All rights reserved.
//

import SpriteKit

final class BlackHole : SKNode {

    var radius: CGFloat {
        didSet {
            gravity.minimumRadius = Float(radius)
            configureBackground()
            configurePhysicsBody()
        }
    }

    var attraction: CGFloat {
        didSet {
            gravity.strength = Float(attraction)
        }
    }

    private let gravity: SKFieldNode = {
        let gravity = SKFieldNode.radialGravityField()
        gravity.categoryBitMask = FieldCategory.blackHole

        // Not quite the quadratic falloff of actual gravity
        gravity.falloff = 1.5

        return gravity
    }()

    private var background: SKShapeNode?

    init(radius: CGFloat = 0.0, attraction: CGFloat = 1.0) {
        self.radius = radius
        self.attraction = attraction
        super.init()

        addChild(gravity)
        gravity.minimumRadius = Float(radius)
        gravity.strength = Float(attraction)
        
        configureBackground()
        configurePhysicsBody()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Collision Handling

extension BlackHole {

    override func didBeginContactWithNode(contactedNode: SKNode) {
        // No more physics will occur, node will be managed by SKAction until it is removed
        contactedNode.physicsBody = nil

        // Black holes have a lot of gravity, so the compress things, right?
        contactedNode.runAction(SKAction.sequence([
            SKAction.group([
                SKAction.scaleTo(0.0, duration: 0.3),
                SKAction.moveTo(position, duration: 0.4)
            ]),
            SKAction.removeFromParent()
        ]))
    }
    
}

// MARK: - Private

private extension BlackHole {

    func configureBackground() {
        background?.removeFromParent()

        if radius > 0.0 {
            background = {
                let bg = SKShapeNode(circleOfRadius: radius)
                bg.fillColor = .blackColor()
                bg.strokeColor = .blackColor()

                addChild(bg)
                return bg
            }()
        }
    }

    func configurePhysicsBody() {
        if radius > 0.0 {
            physicsBody = {
                // Allow objects to overlap with the black hole a bit before actually coming in contact with it
                let body = SKPhysicsBody(circleOfRadius: 0.6 * radius)

                body.categoryBitMask = PhysicsCategory.obstacle
                body.contactTestBitMask = PhysicsCategory.all

                body.friction = 1.0
                body.restitution = 0.0
                body.dynamic = false
                
                return body
                }()
        }
        else {
            physicsBody = nil
        }
    }

}

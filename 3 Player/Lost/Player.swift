//
//  Player.swift
//  Lost
//
//  Created by Rob Visentin on 2/22/16.
//  Copyright © 2016 Rob Visentin. All rights reserved.
//

import SpriteKit

final class Player : SKNode {

    var movementSpeed = CGFloat(0.0)

    private let background: SKSpriteNode = {
        let bg = SKSpriteNode(imageNamed: "spaceship")

        // Offset the anchor point to better match the center of the spaceship in the texture
        bg.anchorPoint = CGPoint(x: 0.71, y: 0.5)

        return bg
    }()

    override init () {
        super.init()

        addChild(background)

        configurePhysicsBody()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(dt: NSTimeInterval) {
        // Move
        if let physicsBody = physicsBody {
            physicsBody.velocity += CGVector(x: movementSpeed * CGFloat(dt), y: 0.0).rotatedBy(zRotation)
        }
        else {
            configurePhysicsBody()
        }
    }

}

// MARK: - Private

private extension Player {

    func configurePhysicsBody() {
        physicsBody = {
            // A rectangle comprising most of the ship's body, aside from wing tips
            let chassis = SKPhysicsBody(rectangleOfSize: 0.4 * background.size, center: .zero)

            // A circle representing the ship's cockpit
            let cockpit = SKPhysicsBody(circleOfRadius: 0.12 * background.size.height, center: CGPoint(x: 0.2 * background.size.width + 0.12 * background.size.height, y: 0.0))

            // The entire ship body is the union of the chassis and cockpit physics bodies
            let body = SKPhysicsBody(bodies: [chassis, cockpit])

            body.categoryBitMask = PhysicsCategory.player
            body.collisionBitMask  = PhysicsCategory.world | PhysicsCategory.obstacle

            body.affectedByGravity = false
            body.linearDamping = 0.4
            body.restitution = 0.0

            return body
        }()
    }

}

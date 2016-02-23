//
//  CoinSpawn.swift
//  Lost
//
//  Created by Rob Visentin on 2/22/16.
//  Copyright © 2016 Rob Visentin. All rights reserved.
//

import SpriteKit

final class CoinSpawn : SKNode {

    func spawnCoin() {
        if let parent = parent {
            spawnCoinInNode(parent)
        }
    }

    func spawnCoinInNode(node: SKNode) {
        let coin = Coin()

        if let parent = parent {
            coin.position = parent.convertPoint(position, toNode: node)
        }
        else {
            coin.position = position
        }

        node.addChild(coin)
    }

}

private class Coin : SKNode {

    override init() {
        super.init()

        let background = SKSpriteNode(imageNamed: "coin")
        addChild(background)

        physicsBody = {
            let body = SKPhysicsBody(circleOfRadius: 0.5 * max(background.size))

            body.categoryBitMask = PhysicsCategory.coin
            body.collisionBitMask = PhysicsCategory.obstacle

            body.affectedByGravity = false
            body.restitution = 0.0

            return body
        }()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

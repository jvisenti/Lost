//
//  GameOverScene.swift
//  Lost
//
//  Created by Rob Visentin on 2/22/16.
//  Copyright © 2016 Rob Visentin. All rights reserved.
//

import SpriteKit

final class GameOverScene : SKScene {

    private let gameOverLabel: SKLabelNode = {
        let label = SKLabelNode(text: "GAME OVER")
        label.color = .whiteColor()
        label.verticalAlignmentMode = .Bottom

        return label
    }()

    override init(size: CGSize) {
        super.init(size: size)

        scaleMode = .ResizeFill
        backgroundColor = .blackColor()

        addChild(gameOverLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Fixed layout should occur in this function
    override func didChangeSize(oldSize: CGSize) {
        super.didChangeSize(oldSize)

        gameOverLabel.position = CGPoint(0.5 * size)
    }

}

// MARK: - Touch Handling

extension GameOverScene {

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)

        view?.presentScene(LevelScene(size: size), transition: SKTransition.crossFadeWithDuration(0.3))
    }

}

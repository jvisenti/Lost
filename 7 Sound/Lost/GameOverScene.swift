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

    private let scoreLabel: SKLabelNode = {
        let label = SKLabelNode()
        label.color = .whiteColor()
        label.fontSize = 26.0
        label.verticalAlignmentMode = .Top

        return label
    }()

    init(size: CGSize, score: Int) {
        super.init(size: size)

        scaleMode = .ResizeFill
        backgroundColor = .blackColor()

        addChild(gameOverLabel)
        addChild(scoreLabel)

        scoreLabel.text = String(format: "Score: %i", score)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)

        // Duck the music during game over sequence
        MusicManager.sharedInstance.volume = 0.4
    }

    // Fixed layout should occur in this function
    override func didChangeSize(oldSize: CGSize) {
        super.didChangeSize(oldSize)

        // Stacks Game Over label above score label
        // Remeber that in Sprite Kit, (0, 0) is in the bottom left of the screen and Y+ is up
        gameOverLabel.position = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height + 10.0)
        scoreLabel.position = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height - 10.0)
    }

}

// MARK: - Touch Handling

extension GameOverScene {

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)

        view?.presentScene(LevelScene(size: size), transition: SKTransition.crossFadeWithDuration(0.3))
    }

}

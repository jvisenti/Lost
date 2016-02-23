//
//  SceneViewController.swift
//  Lost
//
//  Created by Rob Visentin on 2/22/16.
//  Copyright © 2016 Rob Visentin. All rights reserved.
//

import SpriteKit

final class SceneViewController: UIViewController {

    var skView: SKView {
        return view as! SKView
    }

    override func loadView() {
        view = SKView(frame: UIScreen.mainScreen().bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        skView.presentScene(LevelScene(size: skView.bounds.size))
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}


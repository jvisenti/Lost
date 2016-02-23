//
//  MusicManager.swift
//  Lost
//
//  Created by Rob Visentin on 2/23/16.
//  Copyright © 2016 Rob Visentin. All rights reserved.
//

import AVFoundation

class MusicManager {

    static let sharedInstance = MusicManager()

    var volume: Float {
        get { return musicPlayer.volume }
        set { musicPlayer.volume = newValue }
    }

    // Much force unwrapping, such bad.
    // But for now we want to crash if music can't be loaded properly
    private let musicPlayer: AVAudioPlayer = {
        let player = try! AVAudioPlayer(contentsOfURL: NSBundle.mainBundle().URLForResource("theme", withExtension: "caf")!)

        // Repeat forever
        player.numberOfLoops = -1

        return player
    }()

    func startMusic(fromBeginning fromBeginning: Bool = false) {
        if fromBeginning {
            musicPlayer.currentTime = 0.0
        }

        musicPlayer.play()
    }

    func stopMusic() {
        musicPlayer.stop()
    }

}

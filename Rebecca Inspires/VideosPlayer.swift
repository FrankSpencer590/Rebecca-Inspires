//
//  VideosPlayer.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 13/05/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

func viewDidLoad() {
    let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
    let player = AVPlayer(url: videoURL!)
    let playerViewController = AVPlayerViewController()
    playerViewController.player = player
    self.present(playerViewController, animated: true) {
        playerViewController.player!.play()
    }
}

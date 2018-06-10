//
//  GiphyCollectionViewCell.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/10/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import AVKit

class GiphyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var player: AVPlayer?
    
    
    func video(){
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!
        player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.bounds
        self.layer.addSublayer(playerLayer)
        player?.autoplay()
        player?.play()
    }
}

// TODO: find a better place for this extension
private extension AVPlayer {
    func autoplay() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.currentItem, queue: .main) { _ in
            self.seek(to: kCMTimeZero)
            self.play()
        }
    }
}

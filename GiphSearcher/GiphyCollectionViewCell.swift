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
    
    static let DEFAULT_VIDEO_URL = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
    var player: AVPlayer?
    
    var _url : String?
    var url : String {
        get {
            return _url ?? GiphyCollectionViewCell.DEFAULT_VIDEO_URL
        }
        set {
            if let _ = URL(string: newValue) {
                _url = newValue // Store new string value if it's a valid url..
            }
            let videoURL = URL(string: url)! // Use getter to get extra validations
            player = AVPlayer(url: videoURL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.bounds
            self.layer.addSublayer(playerLayer)
            player?.volume = 0.0
            player?.autoplay()
            player?.play()
        }
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

//
//  GiphyCollectionViewCell.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/10/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import AVKit
import Kingfisher

class GiphyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    static let DEFAULT_GIF_URL = "https://media3.giphy.com/media/Cmr1OMJ2FN0B2/giphy-downsized.gif"
    static let DEFAULT_VIDEO_URL = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    let processor = GifProcessor()
    
    var _url : String?
    var url : String {
        get {
            return _url ?? GiphyCollectionViewCell.DEFAULT_GIF_URL
        }
        set {
            if let url = URL(string: newValue) {
                _url = newValue // Store new string value if it's a valid url..
                imageView.kf.setImage(with: url, options: [.processor(processor)])
            }
        }
    }
}

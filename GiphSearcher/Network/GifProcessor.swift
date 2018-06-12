//
//  GifProcessor.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/11/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftGifOrigin

struct GifProcessor: ImageProcessor {
    // `identifier` should be the same for processors with same properties/functionality
    // It will be used when storing and retrieving the image to/from cache.
    let identifier = "com.jugutier.gifprocessor"
    
    // Convert input data/image to target image and return it.
    func process(item: ImageProcessItem, options: KingfisherOptionsInfo) -> Image? {
        switch item {
        case .image(let image):
            print("already an image")
            return image
        case .data(let data):
            print("received gif data")
            return UIImage.gif(data: data)
        }
    }
}

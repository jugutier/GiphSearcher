//
//  GiphyDownsizedImage.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/11/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import Mapper

struct GiphyDownsizedImage: Mappable , Decodable {
    var downsized_small : GiphyImage?
    
    init(map: Mapper) throws {
        downsized_small = map.optionalFrom("downsized_small")
    }
    
    init() {
    }
}

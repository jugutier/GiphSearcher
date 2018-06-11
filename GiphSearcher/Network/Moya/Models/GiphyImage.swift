//
//  GiphyImages.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/11/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import Mapper

/*
 i.e:
 
 "url": "https://media2.giphy.com/media/3o8dFj3yXVsDMsg0oM/200_s.gif",
 "width": "356",
 "height": "200",
 "size": "22783"
 
 OR
 
 "width": "430",
 "height": "242",
 "mp4": "https://media2.giphy.com/media/3o8dFj3yXVsDMsg0oM/giphy-downsized-small.mp4",
 "mp4_size": "85947"
 
 */
struct GiphyImage: Mappable , Decodable {
    var width : String?
    var height : String?
    var url : String? //Either url & size
    var size : String?
    var mp4 : String? // or mp4 & mp4_size
    var mp4_size : String?
    
    init(map: Mapper) throws {
        url = map.optionalFrom("url")
        width = map.optionalFrom("width")
        height = map.optionalFrom("height")
        size = map.optionalFrom("size")
        mp4 = map.optionalFrom("mp4")
        mp4_size = map.optionalFrom("mp4_size")
    }
    
    init() {
    }
}

//
//  GiphyResponse.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/10/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import Mapper

struct GiphyResponse: Mappable , Decodable {
    var pagination: [String: Int]?
    var data: [GiphyItem]?
    var meta: GiphyMeta?
    
    init(map: Mapper) throws {
        pagination = map.optionalFrom("pagination")
        data = map.optionalFrom("data")
        meta = map.optionalFrom("meta")
    }
    
    init() {
    }
}

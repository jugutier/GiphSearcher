//
//  GiphyMeta.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/10/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import Mapper

struct GiphyMeta: Mappable , Decodable {
    var status : Int?
    var msg : String?
    var response_id: String?
    
    init(map: Mapper) throws {
        status = map.optionalFrom("status")
        msg = map.optionalFrom("msg")
        response_id = map.optionalFrom("response_id")
    }
    
    init() {
    }
}

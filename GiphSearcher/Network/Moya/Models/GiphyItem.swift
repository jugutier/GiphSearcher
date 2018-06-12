//
//  GiphyItem.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/10/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import Differentiator
import RxDataSources
import Mapper
import SwiftDate

struct GiphyItem : Mappable , Decodable {
    var id: String?
    var images: GiphyDownsizedImage?
    var import_datetime: String?
    var date: Date?
    
    var url: String? {
        return images?.downsized?.url ?? GiphyCollectionViewCell.DEFAULT_VIDEO_URL
    }

    // Mapper init
    init(map: Mapper) throws {
        id = map.optionalFrom("id")
        images = map.optionalFrom("images")
        import_datetime = map.optionalFrom("import_datetime")
        let currentRegion = Region(tz: TimeZoneName.current, cal: CalendarName.gregorian, loc: LocaleName.english)
        //Example date format: 2016-12-10 00:31:43
         date = (DateInRegion(string: import_datetime ?? "", format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: currentRegion)?.absoluteDate)!
    }
    
    init() {
    }
}

extension GiphyItem : IdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: String {
        return id ?? ""
    }
    
    static func == (lhs: GiphyItem, rhs: GiphyItem) -> Bool {
        return lhs.id == rhs.id && lhs.import_datetime == rhs.import_datetime
    }
}


// MARK: Debugging
extension GiphyItem : CustomDebugStringConvertible {
    var debugDescription: String {
        let debug_id = id ?? ""
        let debug_url = url ?? ""
        let debug_date = date?.timeIntervalSince1970 ?? 0
        return "GiphyItem(identifier: \(debug_id), url: \(debug_url), date: \(debug_date))"
    }
}

extension GiphyItem : CustomStringConvertible {
    var description: String {
        return "\(String(describing: id)), \(String(describing: url))"
    }
}

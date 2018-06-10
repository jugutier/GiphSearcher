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

struct GiphyItem : Mappable {
    let identifier: String
    let url: String
    let date: Date
    
    // Manual init
    init(identifier: String, url: String, date: Date) {
        self.identifier = identifier
        self.url = url
        self.date = date
    }
    // Mapper init
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try url = map.from("url")
        let currentRegion = Region(tz: TimeZoneName.current, cal: CalendarName.gregorian, loc: LocaleName.english)
        //2016-12-10 00:31:43
        try date = (DateInRegion(string: map.from("import_datetime"), format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: currentRegion)?.absoluteDate)!
    }
}

extension GiphyItem : IdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: String {
        return identifier
    }
    
    static func == (lhs: GiphyItem, rhs: GiphyItem) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.date == rhs.date
    }
}


// MARK: Debugging
extension GiphyItem : CustomDebugStringConvertible {
    var debugDescription: String {
        return "GiphyItem(identifier: \(identifier), url: \(url), date: \(date.timeIntervalSince1970))"
    }
}

extension GiphyItem : CustomStringConvertible {
    var description: String {
        return "\(identifier), \(url)"
    }
}

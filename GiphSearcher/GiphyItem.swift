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

struct GiphyItem {
    let identifier: String
    let url: String
    let date: Date
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

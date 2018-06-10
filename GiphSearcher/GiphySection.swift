//
//  GiphySection.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/10/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import Foundation
import Differentiator
import RxDataSources

// MARK: Data
struct GiphySection {
    var header: String
    
    var items: [GiphyItem]
    
    var updated: Date
    
    init(header: String, items: [Item], updated: Date) {
        self.header = header
        self.items = items
        self.updated = updated
    }
}

extension GiphySection : AnimatableSectionModelType {
    typealias Item = GiphyItem
    typealias Identity = String
    
    var identity: String {
        return header
    }
    
    init(original: GiphySection, items: [Item]) {
        self = original
        self.items = items
    }
}

extension GiphySection: Equatable {
    static func == (lhs: GiphySection, rhs: GiphySection) -> Bool {
        return lhs.header == rhs.header && lhs.items == rhs.items && lhs.updated == rhs.updated
    }
}

// MARK: Debugging
extension GiphySection : CustomDebugStringConvertible {
    var debugDescription: String {
        let interval = updated.timeIntervalSince1970
        let itemsDescription = items.map { "\n\($0.debugDescription)" }.joined(separator: "")
        return "GiphySection(header: \"\(self.header)\", items: \(itemsDescription)\n, updated: \(interval))"
    }
}

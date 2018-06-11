//
//  SectionManager.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/10/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import RxSwift

class SectionManager {
    var sections : Variable<[GiphySection]> = Variable([])
    let disposeBag = DisposeBag()
    
    init() {
        initialSections().forEach({ section in
            self.sections.value.append(section)
        })
    }
    
    func bind(to collectionView: UICollectionView) {
        sections.asObservable()
            .bind(to: collectionView.rx.items(dataSource: GiphyCollectionViewController.datasource()))
            .disposed(by: disposeBag)
        //TODO... something like this?
//        sections.value.forEach({ section in
//            section.rxItems.asObservable()
//                .bind(to: collectionView.rx.items(dataSource: GiphySection.datasource()))
//                .disposed(by: disposeBag)
//        })
    }
    
    // MARK: Initial value
    fileprivate func initialSections() -> [GiphySection] {
        let nSections = 1
        let nItems = 2
        return (0 ..< nSections).map { (i: Int) in
            GiphySection(header: "GiphySection \(i + 1)", items: `$`(Array(i * nItems ..< (i + 1) * nItems)), updated: Date())
        }
    }
}

func `$`(_ items: [Int]) -> [GiphyItem] {
    // While they all have a different identifier, all our stubbed videos contain the same video url.
    return items.map {
        var item = GiphyItem()
        item.id = String(describing:$0)
        item.date = Date()
        return item
    }
}

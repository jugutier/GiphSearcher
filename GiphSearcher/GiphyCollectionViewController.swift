//
//  GiphyCollectionViewController.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/10/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

private let reuseIdentifier = "GiphyCollectionCell"
private let sectionReuseIdentifier = "GiphySection"
private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
private let itemsPerRow: CGFloat = 3

class GiphyCollectionViewController: UICollectionViewController {

    @IBOutlet weak var refreshButton : UIBarButtonItem?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.dataSource = nil
        self.collectionView!.delegate = nil // needs to be nil because for some reason storyboard will set it to this class even though I removed the outlets.
        let initialSections = initialValue()
        
        let ticks = Observable<Int>.interval(1, scheduler: MainScheduler.instance).map { _ in () }
        let randomSections = Observable.of(ticks, (refreshButton?.rx.tap.asObservable())!)
            .merge()
            .scan(initialSections) { a, _ in
                return a
            }
//            .map { a in
//                return a.sections
//            }
            .share(replay: 1)
        
        let (configureCollectionViewCell, configureSupplementaryView) =  GiphyCollectionViewController.collectionViewDataSourceUI()
        let cvAnimatedDataSource = RxCollectionViewSectionedAnimatedDataSource(
            configureCell: configureCollectionViewCell,
            configureSupplementaryView: configureSupplementaryView
        )
        
        randomSections
            .bind(to: collectionView!.rx.items(dataSource: cvAnimatedDataSource))
            .disposed(by: disposeBag)
        
        // touches
        Observable.of(
            collectionView!.rx.modelSelected(GiphyItem.self)
            )
            .merge()
            .subscribe(onNext: { item in
                print("Tapped on: \(item)")
            })
            .disposed(by: disposeBag)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension GiphyCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: RxDatasources Styling
extension GiphyCollectionViewController {
    
    static func collectionViewDataSourceUI() -> (
        CollectionViewSectionedDataSource<GiphySection>.ConfigureCell,
        CollectionViewSectionedDataSource<GiphySection>.ConfigureSupplementaryView
        ) {
            return (
                { (_, cellview, indexpath, item) in
                    let cell = cellview.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexpath) as! GiphyCollectionViewCell
                    cell.url = item.url ?? ""
                    return cell
                    
            },
                { (ds ,cellview, kind, indexpath) in
                    let section = cellview.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionReuseIdentifier, for: indexpath) as! GiphyCollectionSectionView
                    section.label!.text = "\(ds[indexpath.section].header)"
                    return section
            }
            )
    }
    
    // MARK: Initial value
    
    func initialSections() -> [GiphySection] {
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
        item.url = GiphyCollectionViewCell.DEFAULT_VIDEO_URL
        item.date = Date()
        return item
    }
}

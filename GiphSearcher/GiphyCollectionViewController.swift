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

    let sectionManager = SectionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let collectionView = collectionView else { return }
        collectionView.dataSource = nil
        // needs to be nil because for some reason storyboard will set it to this class even though I removed the outlets.
        

        sectionManager.bind(to: collectionView)

        GiphyApiManager.getTrending(completion: { items in
            self.sectionManager.sections.value[0].items.append(contentsOf: items)
            debugPrint("Received \(items.count) trending values")
        })
        
        
        // touches
        Observable.of(
            collectionView.rx.modelSelected(GiphyItem.self)
            )
            .merge()
            .subscribe(onNext: { item in
                print("Tapped on: \(item)")
            })
            .disposed(by: sectionManager.disposeBag)
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


extension GiphyCollectionViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        let searchQuery = textField.text ?? ""
        /**
         TODO: Understand how to get bindings to work here.
         **/
        GiphyApiManager.search(query: searchQuery) {
            items in
            activityIndicator.removeFromSuperview()
            
            print("Found \(items.count) matching \(searchQuery)")
            self.sectionManager.sections.value[0].items.append(contentsOf: items)
            self.collectionView?.reloadData()
        }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}

// MARK: RxDatasources Styling
extension GiphyCollectionViewController {
    
    typealias GiphyDatasourceUI = (
        CollectionViewSectionedDataSource<GiphySection>.ConfigureCell,
        CollectionViewSectionedDataSource<GiphySection>.ConfigureSupplementaryView
    )
    
    static func collectionViewDataSourceUI() -> GiphyDatasourceUI {
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
    
    static func datasource() -> RxCollectionViewSectionedReloadDataSource<GiphySection> {
        let (configureCollectionViewCell, configureSupplementaryView) =  GiphyCollectionViewController.collectionViewDataSourceUI()
        let cvAnimatedDataSource = RxCollectionViewSectionedReloadDataSource(
            configureCell: configureCollectionViewCell,
            configureSupplementaryView: configureSupplementaryView
        )
        return cvAnimatedDataSource
    }
    
    
    
    
}

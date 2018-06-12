//
//  GiphyApiManager.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/10/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import Moya
import Moya_ModelMapper
import RxSwift

class GiphyApiManager: NSObject {
    
    static let provider = MoyaProvider<GiphyService>()
    public typealias GiphyItemRequestCompletion = (_ items: [GiphyItem]) -> Void
    
    static func getTrending(completion: @escaping GiphyItemRequestCompletion) {
        let _ = provider.rx.request(.trending)
            .map(GiphyResponse.self)
            .subscribe { event in
                switch event {
                case let .success(response):
                    let items = response.data ?? [GiphyItem]()
                    completion(items)
                    debugPrint("Received \(items.count) new items" )
                    
                case let .error(error):
                    print(error)
                }
            }
    }
    
    static func rxSearch(query: String) -> Observable<[GiphyItem]>{
        provider.request
        return Observable.create { [weak provider] observer in
            let cancellableToken = provider?.rx.request(.search(query: query))
                .map(GiphyResponse.self)
                .subscribe { event in
                    switch event {
                case let .success(response):
                    let items = response.data ?? [GiphyItem]()
                    observer.onNext(items)
                    observer.onCompleted()
                    break
                case let .error(error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create() {
                cancellableToken?.dispose()
            }
            }.observeOn(SerialDispatchQueueScheduler(qos: .background))
    }
    
    static func search(query: String, completion: @escaping GiphyItemRequestCompletion) {
        let _ = provider.rx.request(.search(query: query))
            .map(GiphyResponse.self)
            .subscribe { event in
            switch event {
                case let .success(response):
                    let items = response.data ?? [GiphyItem]()
                    completion(items)
                    debugPrint("Received search data \(items.count)-- : \(items)")
                case let .error(error):
                    debugPrint("error! -- \(error)")
            }
        }
    }

}


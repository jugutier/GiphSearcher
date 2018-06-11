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
    
    static func search(query: String, completion: @escaping GiphyItemRequestCompletion) {
        provider.request(.search(query: query)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                let dataString = data.prettyJSON() // Using convenience method we created
                debugPrint("Received search data \(statusCode)-- : \(dataString)")
            case let .failure(error):
                debugPrint("error! -- \(error)")
            }
        }
    }

}


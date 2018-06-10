//
//  GiphyApiManager.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/10/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import Moya

class GiphyApiManager: NSObject {
    
    static let provider = MoyaProvider<GiphyService>()
    
    static func getTrending() {
        provider.request(.trending) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                let dataString = data.decodedString // Using convenience method we created
                debugPrint("Received data \(statusCode)-- : \(dataString)")
            case let .failure(error):
                debugPrint("error! -- \(error)")
            }
        }
    }
    
    static func search(query: String) {
        provider.request(.search(query: query)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                let dataString = data.decodedString // Using convenience method we created
                debugPrint("Received search data \(statusCode)-- : \(dataString)")
            case let .failure(error):
                debugPrint("error! -- \(error)")
            }
        }
    }

}


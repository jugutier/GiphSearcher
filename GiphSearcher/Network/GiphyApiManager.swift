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
    
    static func getTrending() {
        let provider = MoyaProvider<GiphyService>()
        provider.request(.helloworld) { result in
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

}


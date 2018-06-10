//
//  GiphyService+Implementation.swift
//  GiphSearcher
//
//  Created by Julian Gutierrez on 6/10/18.
//  Copyright © 2018 Jugutier. All rights reserved.
//

import UIKit
import Moya

// MARK: - TargetType Protocol Implementation
extension GiphyService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.giphy.com")!
    }
    
    var path: String {
        switch self {
        default:
            return "/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data("Hello world!".utf8)
        }
    }
    
    var task: Task {
        switch self {
        default: // Send no parameters
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
}

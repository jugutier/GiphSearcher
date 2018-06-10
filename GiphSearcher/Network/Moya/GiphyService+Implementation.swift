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
            return "Hello world!".utf8Encoded
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



// MARK: - Helpers
extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

extension Data {
    var decodedString: String {
        return String(decoding: self, as: UTF8.self)
    }
}

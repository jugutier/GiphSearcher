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
    static let API_KEY = "WpgNbhh0Tk4s9gYygbOjIH7z9XpmPX3A" //API Keys would never be on a tracked source file, they should be obfuscated and filled in through an environment variable in the build server.
    
    var baseURL: URL {
        return URL(string: "https://api.giphy.com")!
    }
    
    var path: String {
        switch self {
        case .trending:
            return "/v1/gifs/trending"
        case .search(_):
            return "/v1/gifs/search"
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
        case .trending: // Always sends parameters in URL, regardless of which HTTP method is used
            return .requestParameters(parameters: ["api_key": GiphyService.API_KEY], encoding: URLEncoding.queryString)
        case let .search(query):
            return .requestParameters(parameters: ["api_key": GiphyService.API_KEY, "q" : query], encoding: URLEncoding.queryString)
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
    
    // This function is for debugging only and should not be used in production.
    func prettyJSON() -> String {
        let value = self
        let readingOptions = JSONSerialization.ReadingOptions.allowFragments
        let writingOptions = JSONSerialization.WritingOptions.prettyPrinted
        
        do{
            let jsonObject = try JSONSerialization.jsonObject(with: value, options: readingOptions)
            if JSONSerialization.isValidJSONObject(jsonObject) {
                let data = try JSONSerialization.data(withJSONObject: jsonObject, options: writingOptions)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }
        }
        catch {
            debugPrint("error parsing json")
        }
        debugPrint("data is not a valid json")
        return ""
        
    }
}

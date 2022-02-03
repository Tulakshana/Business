//
//  API.swift
//  Business
//
//  Created by Tulakshana Weerasooriya on 2022-02-02.
//

import Foundation
import CoreLocation
import UIKit

struct API {
    static let timeOutInterval: TimeInterval = 30.0
    
    struct BaseURL {
        static func value() -> String {
            #if IS_PRODUCTION
            return "https://api.yelp.com/v3"
            #else
            return "https://api.yelp.com/v3"
            #endif
        }
    }
    
    enum Path: String {
        case search = "/businesses/search"
    }
    
    enum Language: String {
        case enUS = "en_US"
        case enCA = "en_CA"
        case frCA = "fr_CA"
    }
    
    enum Method: String {
        case GET
    }
    
    enum Header {
        case authorization
        
        func field() -> String {
            switch self {
            case .authorization:
                return "Authorization"
            }
        }
        
        func value() -> String {
            switch self {
            case .authorization:
                guard let key = Plist.object(key: "Yelp_API_Key") as? String else {
                    return ""
                }
                return key
            }
        }
    }
    
    static func request(request: URLRequest, method: API.Method, completion: @escaping ((_ error: Error?, _ response: Data?) -> Void)) {

        var request = request
        request.addValue(API.Header.authorization.value(),
                         forHTTPHeaderField: API.Header.authorization.field())
        request.httpMethod = method.rawValue

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          if let data = data {
            completion(nil, data)
          } else {
            completion(error, nil)
          }
        }
        task.resume()
    }
}

extension API {
    static func search(term: String, location: CLLocation, completion: @escaping ((_ error: Error?, _ response: SearchResponse?) -> Void)) {
        guard let urlEncodedTerm = term.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        let deviceLocale = Locale.preferredLanguages.first?.replacingOccurrences(of: "-", with: "_") ?? ""
        let language = API.Language.init(rawValue: deviceLocale)?.rawValue ?? API.Language.enUS.rawValue
        let urlString = "\(API.BaseURL.value())\(API.Path.search.rawValue)?\(SearchParam.term)=\(urlEncodedTerm)&\(SearchParam.latitude)=\(location.coordinate.latitude)&\(SearchParam.longitude)=\(location.coordinate.longitude)&\(SearchParam.locale)=\(language)"

        let request = URLRequest(url: URL(string: urlString)!,timeoutInterval: API.timeOutInterval)
        
        API.request(request: request, method: .GET) { (error: Error?, data: Data?) in
            guard let data = data else {
              completion(error, nil)
              return
            }
            
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(SearchResponse.self, from: data)
                completion(nil, decoded)
            } catch {
                completion(error, nil)
            }
        }
    }
}

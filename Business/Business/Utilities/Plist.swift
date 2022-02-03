//
//  Plist.swift
//  Business
//
//  Created by Tulakshana Weerasooriya on 2022-02-02.
//

import Foundation

struct Plist {
    
    private var dic: [String: AnyObject]?
    
    init() {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            dic = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
        }
    }
    
    static func object(key: String) -> AnyObject? {
        guard let dic = Plist.init().dic else {
            return nil
        }
        return dic[key]
    }
}

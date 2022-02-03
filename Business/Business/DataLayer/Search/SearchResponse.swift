//
//  SearchResponse.swift
//  Business
//
//  Created by Tulakshana Weerasooriya on 2022-02-02.
//

import Foundation

struct SearchResponse: Codable {
    var businesses: [Business]?
}

struct Business: Codable {
    var rating: Double?
    var name: String?
    var imageURLString: String?
    
    enum CodingKeys: String, CodingKey {
        case rating
        case name
        case imageURLString = "image_url"
    }
}

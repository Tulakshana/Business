//
//  Style.swift
//  Business
//
//  Created by Tulakshana Weerasooriya on 2022-02-01.
//

import UIKit

struct Style {
    enum Size: String {
        case S
        case M
        case L
        case XL
        
        func value() -> CGFloat {
            switch self {
            case .S:
                return 8.0
            case .M:
                return 12.0
            case .L:
                return 20.0
            case .XL:
                return 36.0
            }
        }
    }
    
    enum Font {
        case paragraph
        case title
        case subtitle
        
        func value() -> UIFont {
            switch self {
            case .paragraph:
                return UIFont.systemFont(ofSize: 15.0)
            case .title:
                return UIFont.boldSystemFont(ofSize: 20.0)
            case .subtitle:
                return UIFont.systemFont(ofSize: 18.0)
            }
        }
    }
    
    enum Color {
        case text
        case error
        case placeholder
        
        func value() -> UIColor {
            switch self {
            case .text:
                return UIColor.black
            case .error:
                return UIColor.red
            case .placeholder:
                return UIColor.lightGray
            }
        }
    }
}

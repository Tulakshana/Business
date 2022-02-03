//
//  LayoutConstraint.swift
//  Business
//
//  Created by Tulakshana Weerasooriya on 2022-02-01.
//

import UIKit

class LayoutConstraint: NSLayoutConstraint {
    @IBInspectable var style: String? {
        willSet {
            if let s = newValue, let v = Style.Size.init(rawValue: s)?.value() {
                constant = v
            }
        }
    }
}

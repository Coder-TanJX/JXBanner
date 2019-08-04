//
//  IndexPath+JXCalculate.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/6/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension IndexPath {
    /// Reload the "+" operator
    static func + (left: IndexPath,
                   right: Int)
        -> IndexPath {
            return IndexPath.init(row: left.row + right,
                                  section: left.section)
    }
    
    /// Reload the "-" operator
    static func - (left: IndexPath,
                   right: Int)
        -> IndexPath {
            return IndexPath.init(row: left.row - right,
                                  section: left.section)
    }
}


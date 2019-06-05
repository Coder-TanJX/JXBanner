//
//  JXBannerPageControlType.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public protocol JXBannerPageControlType {
    
    /// How many pages does PageControl have?
    var numberOfPages: Int { get set }
    
    /// default is 0. value pinned to 0..numberOfPages-1
    var currentPage: Int { get set }
    
}

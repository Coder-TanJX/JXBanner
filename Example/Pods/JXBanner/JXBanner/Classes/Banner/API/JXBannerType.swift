//
//  JXBaseBanner.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public protocol JXBannerType: UIView {

    /// Data source protocol for JXBannerType
    var dataSource: JXBannerDataSource? { get set }
                                                                                           
    /// Delegate protocol for JXBannerType
    var delegate: JXBannerDelegate? { get set }
    
    /// Distinguish the banner
    var identify: String? { get set }
    
    /// The refresh UI
    func reloadView()
    
}

/// A structure that registers cells so that
/// we can distinguish and retrieve reused cells from the cache pool
public struct JXBannerCellRegister {
    
    var type: JXBannerBaseCell.Type
    var reuseIdentifier: String
    
    public init(type: JXBannerBaseCell.Type, reuseIdentifier: String) {
        self.type = type
        self.reuseIdentifier = reuseIdentifier
    }
}

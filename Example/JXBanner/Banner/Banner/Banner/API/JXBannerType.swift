//
//  JXBaseBanner.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public struct JXBannerCellRegister {
    
    var type: JXBannerBaseCell.Type
    var reuseIdentifier: String
    
    init(type: JXBannerBaseCell.Type, reuseIdentifier: String) {
        self.type = type
        self.reuseIdentifier = reuseIdentifier
    }
}


public protocol JXBannerType: UIView {

    /// Data source protocol for JXBannerType
    var dataSource: JXBannerDataSource? { get set }
                                                                                           
    /// Delegate protocol for JXBannerType
    var delegate: JXBannerDelegate? { get set }
    
    /// Outside of pageControl
//    var outerPageControl: (UIView & JXBannerPageControlType)? { get set }
    
}

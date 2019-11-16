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
    var indentify: String? { get set }
    
    /// The refresh UI
    func reloadView()
    
}

/// A structure that registers cells so that
/// we can distinguish and retrieve reused cells from the cache pool

public struct JXBannerCellRegister {
    
    var type: UICollectionViewCell.Type?
    var reuseIdentifier: String
    var nib: UINib?
    
    /**
    Register cells so that we can distinguish and retrieve reused cell cache pools from the cache pool
    
    - parameters:
    - type:             When you are not using the nib cell file, you must set the  'type' to the cell class!!
    - reuseIdentifier:                   If you use multiple jxbanners in your app, please set different values to facilitate the differentiation
    - nib:                                   The nib parameter assignment must be done when using the nib cell file !!!
     
    - returns: Number Of Items
    */
    public init(type: UICollectionViewCell.Type?,
                reuseIdentifier: String,
                nib: UINib? = nil) {
        self.type = type
        self.reuseIdentifier = reuseIdentifier
        self.nib = nib
    }
}

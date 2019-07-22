//
//  JXBannerDataSource.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/6/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import JXPageControl

public protocol JXBannerDataSource {
    
    /// Register the bannerCell and reuseIdentifier
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister)
    
    /// How many pages does banner View have?
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int
    
    /// Set the closure of the banner item information
    func jxBanner(_ banner: JXBannerType,
                  cellForItemAt index: Int,
                  cell: JXBannerBaseCell)
        -> JXBannerBaseCell
    
    /// Set the closure of the banner Params
    func jxBanner(_ banner: JXBannerType,
                  params: JXBannerParams)
        -> JXBannerParams
    
    /// Set the closure of the banner layout Params
    func jxBanner(_ banner: JXBannerType,
                  layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams
    
    /// External pageControl replaces the default pageControl
    func jxBanner(pageControl banner: JXBannerType,
                  numberOfPages: Int,
                  coverView: UIView,
                  builder: pageControlBuilder) -> pageControlBuilder
}

public class pageControlBuilder {
    var pageControl: (UIView & JXPageControlType)?
    var layout: (() -> ())?
}

extension JXBannerDataSource {
    
    /// Set the closure of the banner Params
    public func jxBanner(_ banner: JXBannerType,
                         params: JXBannerParams)
        -> JXBannerParams {
        return params
    }
    
    /// Set the closure of the banner layout Params
    public func jxBanner(_ banner: JXBannerType,
                             layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
        return layoutParams
    }

    /// External pageControl replaces the default pageControl
    func jxBanner(pageControl banner: JXBannerType,
                  numberOfPages: Int,
                  coverView: UIView,
                  builder: pageControlBuilder) -> pageControlBuilder {
        let pageControl = JXPageControlJump()
        pageControl.contentMode = .bottom
        pageControl.activeSize = CGSize(width: 15, height: 6)
        pageControl.inactiveSize = CGSize(width: 6, height: 6)
        pageControl.columnSpacing = 0
        pageControl.contentMode = .right
        builder.pageControl = pageControl
        builder.layout = {
            pageControl.snp.makeConstraints { (maker) in
                maker.left.bottom.equalTo(coverView)
                maker.right.equalTo(coverView).offset(-20)
                maker.height.equalTo(20)
            }
        }
        return builder
    }
    
}

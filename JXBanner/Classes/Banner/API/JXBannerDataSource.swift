//
//  JXBannerDataSource.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/6/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public protocol JXBannerDataSource: class {
    
    /**
     Use reuseIdentifier to register bannerCell for reuse.
     
     - parameter banner: An instance of JXBannerType.
     - returns: the JXBannerCellRegister instance
     */
    
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister)
    
    /**
     How many pages does banner View have?
     
     - parameter banner: An instance of JXBannerType.
     - returns: Number Of Items
     */
    
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int
    
    /**
     This callback changes the banner item
     by setting the JXBannerCell
     
     - parameters:
     - banner: An instance of JXBannerType.
     - index: index that the cell will display
     - cell: UICollectionViewCell or a subclass of UICollectionViewCell
     
     - returns: UICollectionViewCell or a subclass of UICollectionViewCell
     */
    func jxBanner(_ banner: JXBannerType,
                  cellForItemAt index: Int,
                  cell: UICollectionViewCell)
        -> UICollectionViewCell
    
    /**
     This callback changes the banner
     by setting Params
     
     - parameters:
     - banner: An instance of JXBannerType.
     - params: JXBannerParams is a collection of properties that banner can set
     
     - returns: JXBannerParams
     */
    func jxBanner(_ banner: JXBannerType,
                  params: JXBannerParams)
        -> JXBannerParams
    
    /**
     This callback changes the banner layout
     by setting "JXBannerLayoutParams"
     
     - parameters:
     - banner: An instance of JXBannerType.
     - params: JXBannerLayoutParams is a collection of properties that banner layout can set
     
     - returns: JXBannerLayoutParams
     */
    func jxBanner(_ banner: JXBannerType,
                  layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams
    
    /**
     This callback function changes the banner default pageControl
     by creating "JXBannerPageControlBuilder"
     
     - parameters:
     - banner: An instance of JXBannerType.
     - numberOfPages: page count
     - coverView: The uppermost UIView covered
     - builder: "JXBannerPageControlBuilder"
     
     - returns: JXBannerPageControlBuilder
     */
    func jxBanner(pageControl banner: JXBannerType,
                  numberOfPages: Int,
                  coverView: UIView,
                  builder: JXBannerPageControlBuilder) -> JXBannerPageControlBuilder
    
    /**
     Returns the centerIndex/centerCell of the item in the middle of the bannerview
     
     - parameters:
     - banner: An instance of JXBannerType.
     - centerIndex: the index of the item in the middle of the bannerview
     - centerCell: the cell of the item in the middle of the bannerview
     */
    
    func jxBanner(_ banner: JXBannerType,
                  centerIndex: Int,
                  centerCell: UICollectionViewCell)
    
    
    /**
     Returns the lastCenterIndex/lastCenterCell of the item in the middle of the bannerview
     
     - parameters:
     - banner: An instance of JXBannerType.
     - lastCenterIndex: Last index of the middle item in bannerview
     - lastCenterCell: Last cell of the middle item in bannerview
     */
    
    func jxBanner(_ banner: JXBannerType,
                  lastCenterIndex: Int?,
                  lastCenterCell: UICollectionViewCell?)
}

/// The default implementation
public extension JXBannerDataSource {
    
    /// Default JXBannerParams
    func jxBanner(_ banner: JXBannerType,
                         params: JXBannerParams)
        -> JXBannerParams {
        return params
    }
    
    /// Default JXBannerLayoutParams
    func jxBanner(_ banner: JXBannerType,
                             layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
        return layoutParams
    }

    /// Default pageControl
    func jxBanner(pageControl banner: JXBannerType,
                  numberOfPages: Int,
                  coverView: UIView,
                  builder: JXBannerPageControlBuilder) -> JXBannerPageControlBuilder {
        let pageControl = JXBannerPageControlDefault()
        pageControl.frame = CGRect(x: 0,
                                   y: coverView.bounds.height - 24,
                                   width: coverView.bounds.width,
                                   height: 24)
        pageControl.autoresizingMask = [
            .flexibleWidth,
            .flexibleTopMargin
        ]
        builder.pageControl = pageControl
        
        return builder
    }
    
    /// Returns the centerIndex/centerCell of the item in the middle of the bannerview
    func jxBanner(_ banner: JXBannerType,
                  centerIndex: Int,
                  centerCell: UICollectionViewCell) {}
    
    /// Returns the lastCenterIndex/lastCenterCell of the item in the middle of the bannerview
    func jxBanner(_ banner: JXBannerType,
                  lastCenterIndex: Int?,
                  lastCenterCell: UICollectionViewCell?) {}
    
}

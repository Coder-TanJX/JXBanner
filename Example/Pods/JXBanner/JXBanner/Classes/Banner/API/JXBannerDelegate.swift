//
//  JXBannerDelegate.swift
//  Alamofire
//
//  Created by Code_JX on 2019/6/1.
//

import UIKit

public protocol JXBannerDelegate: class {
    
    /**
     Called when the cell is clicked
     
     - parameters:
     - banner: An instance of JXBannerType.
     - index: The index of the cell is clicked
     */
    
    func jxBanner(_ banner: JXBannerType,
                      didSelectItemAt index: Int)
    
    /**
     Returns the index of the item in the middle of the bannerview
     
     - parameters:
     - banner: An instance of JXBannerType.
     - index: the index of the item in the middle of the bannerview
     */
    
    func jxBanner(_ banner: JXBannerType,
                  center index: Int)
    
    /**
     This is a view to add mask subview
     
     - parameters:
     - banner: An instance of JXBannerType.
     - coverView: This is a view to add mask subview
     */
    
    func jxBanner(_ banner: JXBannerType,
                  coverView: UIView)
}

/// The default implementation
public extension JXBannerDelegate {
    
    func jxBanner(_ banner: JXBannerType,
                      didSelectItemAt index: Int) {
        print(" -- jxBanner select item -- \(index)  -- ")
    }

    func jxBanner(_ banner: JXBannerType,
                  center index: Int) {}
    
    func jxBanner(_ banner: JXBannerType,
                  coverView: UIView) {}
}

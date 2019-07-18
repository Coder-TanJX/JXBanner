//
//  JXBannerDelegate.swift
//  Alamofire
//
//  Created by Code_JX on 2019/6/1.
//

import UIKit

public protocol JXBannerDelegate {
    
    /// This is a call-back to select banner item
    func jxBanner(_ banner: JXBannerType,
                      didSelectItemAt index: Int)
    
    /// Returns the index of the item in the middle of the bannerview
    func jxBanner(_ banner: JXBannerType,
                  center index: Int)
    
    /// This is a view to add mask subview
    func jxBanner(_ banner: JXBannerType,
                  contentView: UIView)
    
}

extension JXBannerDelegate {
    
    /// This is a call-back to select banner item
    func jxBanner(_ banner: JXBannerType,
                      didSelectItemAt index: Int) {
        print(" --  select item -- \(index)  -- ")
    }
    
    /// Returns the index of the item in the middle of the bannerview
    func jxBanner(_ banner: JXBannerType,
                  center index: Int) {
        print(" --  current item -- \(index)  -- ")
    }
    
    /// This is a view to add mask subview
    func jxBanner(_ banner: JXBannerType,
                  contentView: UIView) {
        
    }
}

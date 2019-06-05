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
    
    /// This is a view to add mask subview
    func jxBanner(_ banner: JXBannerType,
                  contentView: UIView) {
        
    }
}

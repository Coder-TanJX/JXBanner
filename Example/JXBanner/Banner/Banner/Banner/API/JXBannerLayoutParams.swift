//
//  JXBannerLayoutParams.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public class JXBannerLayoutParams {
    
    var itemSize: CGSize?
    var itemSpacing: CGFloat = 0.0
    var sectionInset: UIEdgeInsets = UIEdgeInsets.zero
    var layoutType: JXBannerTransformable?
    
    var minimumScale: CGFloat = 0.8
    var minimumAlpha: CGFloat = 1.0
    var maximumAngle: CGFloat = 0.2
    
    var rateOfChange: CGFloat = 0.4
    var adjustSpacingWhenScroling: Bool = true
    
    
    var itemVerticalCenter: Bool = true
    var itemHorizontalCenter: Bool = true

}

// MARK: - Set function
extension JXBannerLayoutParams {
    
    func itemSize(_ itemSize: CGSize) -> JXBannerLayoutParams {
        self.itemSize = itemSize
        return self
    }
    
    func itemSpacing(_ itemSpacing: CGFloat) -> JXBannerLayoutParams {
        self.itemSpacing = itemSpacing
        return self
    }
    
    func sectionInset(_ sectionInset: UIEdgeInsets) -> JXBannerLayoutParams {
        self.sectionInset = sectionInset
        return self
    }
    
    func layoutType(_ layoutType: JXBannerTransformable) -> JXBannerLayoutParams {
        self.layoutType = layoutType
        return self
    }
    
    
    func minimumScale(_ minimumScale: CGFloat) -> JXBannerLayoutParams {
        self.minimumScale = minimumScale
        return self
    }
    
    func minimumAlpha(_ minimumAlpha: CGFloat) -> JXBannerLayoutParams {
        self.minimumAlpha = minimumAlpha
        return self
    }
    
    func maximumAngle(_ maximumAngle: CGFloat) -> JXBannerLayoutParams {
        self.maximumAngle = maximumAngle
        return self
    }
    
    func rateOfChange(_ rateOfChange: CGFloat) -> JXBannerLayoutParams {
        self.rateOfChange = rateOfChange
        return self
    }
    
    func adjustSpacingWhenScroling(_ adjustSpacingWhenScroling: Bool) -> JXBannerLayoutParams {
        self.adjustSpacingWhenScroling = adjustSpacingWhenScroling
        return self
    }
    
    func itemVerticalCenter(_ itemVerticalCenter: Bool) -> JXBannerLayoutParams {
        self.itemVerticalCenter = itemVerticalCenter
        return self
    }
    
    func itemHorizontalCenter(_ itemHorizontalCenter: Bool) -> JXBannerLayoutParams {
        self.itemHorizontalCenter = itemHorizontalCenter
        return self
    }
}

//
//  JXBannerLayoutParams.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public class JXBannerLayoutParams {
    
    // base
    public var itemSize: CGSize?
    public var itemSpacing: CGFloat = 0.0
    public var layoutType: JXBannerTransformable?
    public var scrollDirection: UICollectionView.ScrollDirection = .horizontal
    
    // JXBannerTransformable
    public var minimumScale: CGFloat = 0.8
    public var minimumAlpha: CGFloat = 1.0
    public var maximumAngle: CGFloat = 0.2
    public var rateOfChange: CGFloat = 0.4
    public var rateHorisonMargin: CGFloat = 0.2

}

// MARK: - Set function
public extension JXBannerLayoutParams {
    
    func itemSize(_ itemSize: CGSize) -> JXBannerLayoutParams {
        self.itemSize = itemSize
        return self
    }
    
    func itemSpacing(_ itemSpacing: CGFloat) -> JXBannerLayoutParams {
        self.itemSpacing = itemSpacing
        return self
    }
    
    func layoutType(_ layoutType: JXBannerTransformable?) -> JXBannerLayoutParams {
        self.layoutType = layoutType
        return self
    }
    
    func scrollDirection(_ scrollDirection: UICollectionView.ScrollDirection) -> JXBannerLayoutParams {
        self.scrollDirection = scrollDirection
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
    
    func rateHorisonMargin(_ rateHorisonMargin: CGFloat) -> JXBannerLayoutParams {
        self.rateHorisonMargin = rateHorisonMargin
        return self
    }

}

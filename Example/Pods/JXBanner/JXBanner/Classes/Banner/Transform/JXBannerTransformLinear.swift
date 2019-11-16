//
//  JXBannerTransformLinear.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/14.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public struct JXBannerTransformLinear: JXBannerTransformable {
    
    public init() {}
    
    public func transformToAttributes(collectionView: UICollectionView,
                               params: JXBannerLayoutParams,
                               attributes: UICollectionViewLayoutAttributes) {
        
        let collectionViewWidth = collectionView.frame.width
        if collectionViewWidth <= 0 { return }
        let centetX = collectionView.contentOffset.x + collectionViewWidth * 0.5
        let delta = abs(attributes.center.x - centetX)
        let scale = max(1 - delta / collectionViewWidth * params.rateOfChange, params.minimumScale)
        let alpha = max(1 - delta / collectionViewWidth, params.minimumAlpha)
        
        var transform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
        var _alpha = alpha
        
        // Adjust spacing When Scroling
        let location = JXBannerTransfrom.itemLocation(viewCentetX: centetX,
                                                      itemCenterX: attributes.center.x)
        let rate = 1.05 + params.rateHorisonMargin
        var translate: CGFloat = 0
        switch location {
        case .left:
            translate = rate * attributes.size.width * (1 - scale) / 2
        case .right:
            translate = -rate * attributes.size.width * (1 - scale) / 2
        case .center:
            _alpha = 1.0
        }
        transform = transform.translatedBy(x: translate, y: 0)
        
        // Set transform
        attributes.transform = transform;
        attributes.alpha = _alpha;
    }
}





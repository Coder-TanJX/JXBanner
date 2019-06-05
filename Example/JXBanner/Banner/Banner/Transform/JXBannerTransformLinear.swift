//
//  JXBannerTransformLinear.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/14.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

struct JXBannerTransformLinear: JXBannerTransformable {
    
    enum JXTransformLocation {
        case left
        case center
        case right
    }
    
    func transformToAttributes(collectionView: UICollectionView,
                               params: JXBannerLayoutParams,
                               attributes: UICollectionViewLayoutAttributes) {
        
        let collectionViewWidth = collectionView.frame.size.width
        if collectionViewWidth <= 0 { return }
        let centetX = collectionView.contentOffset.x + collectionViewWidth * 0.5
        let delta = abs(attributes.center.x - centetX)
        let scale = max(1 - delta / collectionViewWidth * params.rateOfChange, params.minimumScale)
        let alpha = max(1 - delta / collectionViewWidth, params.minimumAlpha)
        
        
        var transform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
        var _alpha = alpha
        if params.adjustSpacingWhenScroling {
            
            let location = cellLocation(viewCentetX: centetX,
                                        itemCenterX: attributes.center.x)
            var translate: CGFloat = 0
            switch location {
            case .left:
                translate = 1.24 * attributes.size.width * (1 - scale) / 2
            case .right:
                translate = -1.24 * attributes.size.width * (1 - scale) / 2
            case .center:
                _alpha = 1.0
            }
            
            transform = transform.translatedBy(x: translate, y: 0)
            
        }
        attributes.transform = transform;
        attributes.alpha = _alpha;

    }
    
    func cellLocation(viewCentetX: CGFloat,
                      itemCenterX: CGFloat) -> JXTransformLocation {
        var location: JXTransformLocation = .right
        if abs(itemCenterX - viewCentetX) < 0.5 {
            location = .center
        }else if (itemCenterX - viewCentetX) < 0 {
            location = .left
        }
        return location
    }
    
}





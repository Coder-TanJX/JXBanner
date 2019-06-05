//
//  JXBannerTransformCoverflow.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/14.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

struct JXBannerTransformCoverflow: JXBannerTransformable {
    
    enum JXCellLocation {
        case left
        case center
        case right
    }
    
    func transformToAttributes(collectionView: UICollectionView,
                               params: JXBannerLayoutParams,
                               attributes: UICollectionViewLayoutAttributes) {
        
        let collectionViewWidth = collectionView.frame.size.width
        if collectionViewWidth <= 0 { return }
        
        let centetX = collectionView.contentOffset.x + collectionViewWidth * 0.5;
        let delta = abs(attributes.center.x - centetX)
        let angle = min(delta / collectionViewWidth * (1 - params.rateOfChange), params.maximumAngle)
        let alpha = max(1 - delta / collectionViewWidth, params.minimumAlpha)
        
        applyCoverflowTransformToAttributes(viewCentetX: centetX,
                                            params: params,
                                            attributes: attributes,
                                            angle: angle,
                                            alpha: alpha)
    }
    
    
//    func applyCoverflowTransformToAttributes(viewCentetX: CGFloat,
//                                             params: JXBannerLayoutParams,
//                                             attributes: UICollectionViewLayoutAttributes,
//                                             angle: CGFloat,
//                                             alpha: CGFloat) -> Void {
//        var transform3D: CATransform3D = CATransform3DIdentity
//        transform3D.m34 = -0.002
//        var _angle: CGFloat = angle
//        var _alpha: CGFloat = alpha
//        let location = cellLocation(viewCentetX: viewCentetX,
//                                    itemCenterX: attributes.center.x)
//        switch location {
//        case .left:
//            _angle = angle
//        case .right:
//            _angle = -angle
//        case .center:
//            _angle = 0
//            _alpha = 1
//        }
//        attributes.alpha = _alpha
//        attributes.transform3D = CATransform3DRotate(transform3D,
//                                                     CGFloat(Double.pi) * _angle,
//                                                     0, 1, 0)
//
//    }
    
    func applyCoverflowTransformToAttributes(viewCentetX: CGFloat,
                                             params: JXBannerLayoutParams,
                                             attributes: UICollectionViewLayoutAttributes,
                                             angle: CGFloat,
                                             alpha: CGFloat) -> Void {
        var transform3D: CATransform3D = CATransform3DIdentity
        transform3D.m34 = -0.002
        var _angle: CGFloat = angle
        var _alpha: CGFloat = alpha
        let location = cellLocation(viewCentetX: viewCentetX,
                                    itemCenterX: attributes.center.x)
        
        var translate: CGFloat = 0.0
        switch location {
        case .left:
            _angle = angle
            translate = (1.0 - cos(_angle * 1.15 * CGFloat.pi)) * attributes.size.width
        case .right:
            _angle = -angle
            translate = -(1.0 - cos(_angle * 1.15 * CGFloat.pi)) * attributes.size.width
        case .center:
            _angle = 0
            _alpha = 1
        }
        attributes.alpha = _alpha
        transform3D = CATransform3DRotate(transform3D,
                                                     CGFloat.pi * _angle,
                                                     0, 1, 0)
        
        
//        transform3D = CATransform3DRotate(transform3D, M_PI*_angle, 0, 1, 0);
//        if (_layout.adjustSpacingWhenScroling) {
            attributes.transform3D = CATransform3DTranslate(transform3D, translate, 0, 0)
//        }
        
    }
    
    func cellLocation(viewCentetX: CGFloat,
                  itemCenterX: CGFloat) -> JXCellLocation {
        var location: JXCellLocation = .right
        if abs(itemCenterX - viewCentetX) < 0.5 {
            location = .center
        }else if (itemCenterX - viewCentetX) < 0 {
            location = .left
        }
        return location
    }
    


}

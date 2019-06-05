//
//  JXBannerTransformContext.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/14.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

struct JXBannerTransformContext: JXBannerTransformable {

    var transform: JXBannerTransformable?
    
    init() {}
    
    init(transform: JXBannerTransformable) {
        self.transform = transform
    }
    
    func transformToAttributes(collectionView: UICollectionView,
                               params: JXBannerLayoutParams,
                               attributes: UICollectionViewLayoutAttributes) {
        transform?.transformToAttributes(collectionView: collectionView,
                                         params: params,
                                         attributes: attributes)
    }

}

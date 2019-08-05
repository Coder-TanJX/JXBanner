//
//  JXBannerTransformable.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/14.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public protocol JXBannerTransformable {

    /**
     This callback will provide all the UICollectionViewLayoutAttributes,
     you can change his "transform" change the presentation
     
     */

    func transformToAttributes(collectionView: UICollectionView,
                               params: JXBannerLayoutParams,
                               attributes: UICollectionViewLayoutAttributes)
}

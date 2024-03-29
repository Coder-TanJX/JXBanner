//
//  JXBannerLayout.swift
//  NewBanner
//
//  Created by Code_JX on 2019/5/12.
//  Copyright © 2019 China. All rights reserved.
//

import UIKit

class JXBannerLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var params: JXBannerLayoutParams? {
        didSet {
            if let params = params {
                itemSize = params.itemSize ?? collectionView?.bounds.size ?? CGSize(width: 2, height: 2)
                minimumLineSpacing = params.itemSpacing
                minimumInteritemSpacing = params.itemSpacing
            }
        }
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) ->
        Bool {
        if let _ = params?.layoutType { return true }
        return super.shouldInvalidateLayout(forBoundsChange: newBounds)
    }
    
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        
        // Set the margins
        let inset: CGFloat = (collectionView!.frame.width - itemSize.width) * 0.5
        sectionInset = UIEdgeInsets(top: 0,
                                    left: inset,
                                    bottom: 0,
                                    right: inset)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) ->
        [UICollectionViewLayoutAttributes]? {
  
        if let layoutType = params?.layoutType {

            let attributesArray: [UICollectionViewLayoutAttributes] =
                NSArray(array: super.layoutAttributesForElements(in: rect) ?? [],
                        copyItems: true) as! [UICollectionViewLayoutAttributes]
            let visibleRect = CGRect(origin: collectionView!.contentOffset,
                                     size: collectionView!.bounds.size)

            for attributes in attributesArray {
                if !visibleRect.intersects(attributes.frame) { continue }
                applyTransformToAttributes(attributes: attributes,
                                           layoutType: layoutType)
            }
            return attributesArray

        }
        return super.layoutAttributesForElements(in: rect)
    }
    
    //MARK:- Transform
    func applyTransformToAttributes(attributes: UICollectionViewLayoutAttributes,
                                    layoutType: JXBannerTransformable) -> Void {
        let transformContext: JXBannerTransformContext = JXBannerTransformContext(transform: layoutType)
        transformContext.transformToAttributes(collectionView: collectionView!,
                                               params: params!,
                                               attributes: attributes)
    }
    
}



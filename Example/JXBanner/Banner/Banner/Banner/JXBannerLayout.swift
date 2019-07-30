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
                itemSize = params.itemSize ?? collectionView?.bounds.size ?? CGSize.zero
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
        let inset: CGFloat = (collectionView!.frame.size.width - itemSize.width) * 0.5
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
    
    /**
     * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
     */
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
//                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        // 计算出最终显示的矩形框
//        let rect: CGRect = CGRect(x: proposedContentOffset.x,
//                                  y: 0,
//                                  width: collectionView!.frame.width,
//                                  height: collectionView!.frame.height)
//
//        // 获得super已经计算好的布局属性
//        let array: [UICollectionViewLayoutAttributes]! = super.layoutAttributesForElements(in: rect) ?? []
//
//        // 计算collectionView最中心点的x值
//        let centerX: CGFloat = proposedContentOffset.x + collectionView!.frame.width * 0.5
//
//        // 存放最小的间距值
//        var minDelta: CGFloat = CGFloat(MAXFLOAT)
//        for attrs in array {
//            if abs(minDelta) > abs(attrs.center.x - centerX) {
//                minDelta = attrs.center.x - centerX;
//            }
//        }
//        // 修改原有的偏移量
//        return CGPoint(x: proposedContentOffset.x + minDelta, y: proposedContentOffset.y)
//    }
    
}



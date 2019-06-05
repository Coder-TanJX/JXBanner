//
//  XMGLineLayout.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/12.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class XMGLineLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
    * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
    * 一旦重新刷新布局，就会重新调用下面的方法：
    1.prepareLayout
    2.layoutAttributesForElementsInRect:方法
    */
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
    
    /**
     * 用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
     */
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        
        // 设置内边距
        let inset: CGFloat = (collectionView!.frame.size.width - itemSize.width) * 0.5
        sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    /**
     UICollectionViewLayoutAttributes *attrs;
     1.一个cell对应一个UICollectionViewLayoutAttributes对象
     2.UICollectionViewLayoutAttributes对象决定了cell的frame
     */
    /**
     * 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
     * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 获得super已经计算好的布局属性
        let array: [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect) ?? []
        
        // 计算collectionView最中心点的x值
        let centerX: CGFloat = collectionView!.contentOffset.x + collectionView!.frame.size.width * 0.5;
        
        let visibleRect = CGRect(origin: collectionView!.contentOffset,
                                 size: collectionView!.bounds.size)
        
        // 在原有布局属性的基础上，进行微调
        for attrs in array {
            
            if !visibleRect.intersects(attrs.frame) { continue }
            
            // cell的中心点x 和 collectionView最中心点的x值 的间距
            let delta: CGFloat = abs(attrs.center.x - centerX)
            
            // 根据间距值 计算 cell的缩放比例
            let scale: CGFloat = 1 - delta / collectionView!.frame.size.width
            
            // 设置缩放比例
            attrs.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return array;
    }

    /**
     * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
     */
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // 计算出最终显示的矩形框
        let rect: CGRect = CGRect(x: proposedContentOffset.x,
                                  y: 0,
                                  width: collectionView!.frame.width,
                                  height: collectionView!.frame.height)

        // 获得super已经计算好的布局属性
        let array: [UICollectionViewLayoutAttributes]! = super.layoutAttributesForElements(in: rect) ?? []

        // 计算collectionView最中心点的x值
        let centerX: CGFloat = proposedContentOffset.x + collectionView!.frame.width * 0.5;

        // 存放最小的间距值
        var minDelta: CGFloat = CGFloat(MAXFLOAT)
        for attrs in array {
            if abs(minDelta) > abs(attrs.center.x - centerX) {
                minDelta = attrs.center.x - centerX;
            }
        }

        // 修改原有的偏移量
        return CGPoint(x: proposedContentOffset.x + minDelta, y: proposedContentOffset.y)
    }
    



    
}

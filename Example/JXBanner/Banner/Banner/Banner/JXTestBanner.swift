//
//  JXTestBanner.swift
//  JXBanner_Example
//
//  Created by 谭家祥 on 2019/6/6.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

private let kMultiplier = 1000

class JXTestBanner: JXBaseBanner, JXBannerType {

    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBase()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBase()
    }
    
    private func setupBase() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    var dataSource: JXBannerDataSource? { didSet { reloadView() }}
    
    var delegate: JXBannerDelegate?
    
    /// The refresh UI, get data from
    func reloadView() {
        
        // Stop Animation
        stop()
        
        // DataSource
        if let count = dataSource?.jxBanner(numberOfItems: self),
            let tempDataSource = dataSource {
            
            // Register cell
            if let register = dataSource?.jxBanner(self) {
                collectionView.register(
                    register.type,
                    forCellWithReuseIdentifier: register.reuseIdentifier)
                cellRegister = register
            }
            
            // numberOfItems
            pageCount = tempDataSource.jxBanner(numberOfItems: self)
            
            // params
            params = dataSource?.jxBanner(self,
                                          params: params) ?? params
            
            // layoutParams
            layout.params = tempDataSource.jxBanner(self,
                                                    layoutParams: layout.params!)
            
            // PageControl
            if var tempPageControl = dataSource?.jxBanner(pageControl: self,
                                                          numberOfPages: count,
                                                          contentView: contentView) {
                tempPageControl.currentPage = 0
                contentView.addSubview(tempPageControl)
                self.pageControl = tempPageControl
            }
            
        }
        
        // Dalegate
        if let tempDelegate = delegate {
            tempDelegate.jxBanner(self, contentView: contentView)
        }
        
        // Reinitialize data
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.bounces = params.isBounces
        collectionView.reloadData()
        reinitializeIndexPath()
        
        // Start Animation
        start()
    }
}

// MARK: - Private mothod
extension JXTestBanner {
    
    /// Reload current indexpath
    private func reinitializeIndexPath() {
        if pageCount > 0 {
            if params.isCycleChain {
                // Take the middle group and show it
                currentIndexPath = IndexPath(row: (kMultiplier * pageCount / 2),
                                             section: 0)
            }else {
                currentIndexPath = IndexPath(row: 0, section: 0)
            }
        }else {
            currentIndexPath = IndexPath(row: 0, section: 0)
        }
        
        scrollToIndexPath(currentIndexPath,
                          animated: false)
    }
    
    @objc internal override func autoScroll() {
        guard pageCount > 1 else { return }
        
        // 判断是否在屏幕中
        guard self.window != nil else { return }
        let rectInWindow = convert(frame, to: UIApplication.shared.keyWindow)
        guard (UIApplication.shared.keyWindow?.bounds.intersects(rectInWindow) ?? false)
            else { return }
        
        
        if params.isCycleChain {
            currentIndexPath = currentIndexPath + 1
            scrollToIndexPath(currentIndexPath,
                              animated: true)
        }else {
            if currentIndexPath.row == pageCount - 1 {
                currentIndexPath = IndexPath(row: 0, section: 0)
                
                self.scrollToIndexPath(self.currentIndexPath,
                                       animated: false)
                scrollViewDidEndScrollingAnimation(collectionView)
                if let transitionType = params.edgeTransitionType?.rawValue {
                    let transition = CATransition()
                    transition.duration = CFTimeInterval(0.3)
                    transition.subtype = params.edgeTransitionSubtype
                    transition.type = CATransitionType(rawValue: transitionType)
                    transition.isRemovedOnCompletion = true
                    collectionView.layer.add(transition, forKey: nil)
                }
                
            } else {
                currentIndexPath = currentIndexPath + 1
                scrollToIndexPath(currentIndexPath,
                                  animated: true)
            }
        }
        print(currentIndexPath)
    }
    
    /// cell错位检测和调整
    private func adjustErrorCell(isScroll: Bool)
    {
        let indexPaths = collectionView.indexPathsForVisibleItems
        var attriArr = [UICollectionViewLayoutAttributes?]()
        for indexPath in indexPaths {
            let attri = collectionView.layoutAttributesForItem(at: indexPath)
            attriArr.append(attri)
        }
        let centerX: CGFloat = collectionView.contentOffset.x + collectionView.frame.width * 0.5
        var minSpace = CGFloat(MAXFLOAT)
        var shouldSet = true
        if layout.params?.layoutType != nil && indexPaths.count <= 2 {
            shouldSet = false
        }
        for atr in attriArr {
            if let obj = atr, shouldSet {
                obj.zIndex = 0;
                if(abs(minSpace) > abs(obj.center.x - centerX)) {
                    minSpace = obj.center.x - centerX;
                    currentIndexPath = obj.indexPath;
                }
            }
        }
        if isScroll {
            scrollViewWillBeginDecelerating(collectionView)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension JXTestBanner {
    
    /// Began to drag and drop
    func scrollViewWillBeginDragging(
        _ scrollView: UIScrollView) { pause() }
    
    /// The drag is about to end
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        pause()
        
        if !params.isCycleChain {
            if velocity.x >= 0 ,
                currentIndexPath.row == pageCount - 1 { return }
            if velocity.x <= 0 ,
                currentIndexPath.row == 0 { return }
        }
        
        // 这里不用考虑越界问题,其他地方做了保护
        if velocity.x > 0 {
            //左滑,下一张
            currentIndexPath = currentIndexPath + 1
        }else if velocity.x < 0 {
            //右滑, 上一张
            currentIndexPath = currentIndexPath - 1
        }else {
            print("未滑动, 不翻页")
            adjustErrorCell(isScroll: true)
        }
    }
    
    /// It's going to start slowing down
    func scrollViewWillBeginDecelerating(
        _ scrollView: UIScrollView) {
        scrollToIndexPath(currentIndexPath,
                          animated: true)
    }
    
    /// End to slow down
    func scrollViewDidEndDecelerating(
        _ scrollView: UIScrollView) {}
    
    /// Scroll animation complete
    func scrollViewDidEndScrollingAnimation(
        _ scrollView: UIScrollView) {
        start()
        setCurrentIndex()
    }
    
    /// Rolling in the
    func scrollViewDidScroll(
        _ scrollView: UIScrollView) {
        pause()
    }

}

// MARK:- UICollectionViewDataSource, UICollectionViewDelegate
extension JXTestBanner:
    UICollectionViewDataSource,
UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int)
        -> Int {
            return params.isCycleChain ? kMultiplier * pageCount : pageCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellRegister.reuseIdentifier,
                for: indexPath)
            
            if let bannerViewCell = cell as? JXBannerBaseCell {
                return dataSource?.jxBanner(self,
                                            cellForItemAt: indexOfIndexPath(indexPath),
                                            cell: bannerViewCell) ?? bannerViewCell
            }
            
            return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.jxBanner(self,
                           didSelectItemAt: indexOfIndexPath(indexPath))
        adjustErrorCell(isScroll: true)
    }
    
    func indexOfIndexPath(_ indexPath : IndexPath)
        -> Int {
            return Int(indexPath.item % pageCount)
    }
}


//MARK:- Private func
extension JXTestBanner {
    
    func setCurrentIndex() {
        let point = CGPoint(x: collectionView.contentOffset.x + collectionView.frame.width * 0.5,
                            y: collectionView.contentOffset.y + collectionView.frame.height * 0.5)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            delegate?.jxBanner(self, center: indexOfIndexPath(indexPath))
        }
    }
}

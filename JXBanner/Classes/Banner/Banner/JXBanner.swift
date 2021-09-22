//
//  JXBanner.swift
//  JXBanner_Example
//
//  Created by Coder_TanJX on 2019/6/6.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import JXPageControl

// MARK: - JXBannerType
public class JXBanner: JXBaseBanner, JXBannerType {
    
    public var indentify: String? = "JXBaseBanner"
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBase()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupBase()
    }
    
    private func setupBase() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    public weak var dataSource: JXBannerDataSource? { didSet { reloadView() }}
    
    public weak var delegate: JXBannerDelegate?
    
    /// Outside of pageControl
    internal var pageControl: (UIView & JXPageControlType)?
    
    override func setCurrentIndex() {
        
        let currentPage = indexOfIndexPath(currentIndexPath)
        pageControl?.currentPage = currentPage
        delegate?.jxBanner(self, center: currentPage)

        if let cell = collectionView.cellForItem(at: currentIndexPath) {
            dataSource?.jxBanner(self,
                                 lastCenterIndex: lastCenterIndex,
                                 lastCenterCell: lastIndexPathCell)
            dataSource?.jxBanner(self,
                                 centerIndex: currentPage,
                                 centerCell: cell)
            lastCenterIndex = currentPage
            lastIndexPathCell = cell
        }
    }
    
    public func scrollToIndex(_ index: Int, animated: Bool) {
        
        guard index >= 0, index < pageCount else { return }
        
        let currentPage = indexOfIndexPath(currentIndexPath)
        
        let offset = index - currentPage
        if currentPage + offset >= 0,
           currentPage + offset < pageCount {
            currentIndexPath = currentIndexPath + offset
            pause()
            scrollToIndexPath(currentIndexPath, animated: animated)
            resume()
        }
        
    }

    /// The refresh UI, get data from
    public func reloadView() {
        
        // Stop Animation
        stop()
        
        // refresh
        refreshDataSource()
        refreshDelegate()
        refreshData()
        
        // Start Animation
        start()
    }
}

// MARK: - Private mothod
extension JXBanner {
    
    private func refreshDataSource() {
        
        // DataSource
        if let _ = dataSource?.jxBanner(numberOfItems: self),
            let tempDataSource = dataSource {
            
            // Register cell
            if let register = dataSource?.jxBanner(self) {
                
                if let nib = register.nib {
                    collectionView.register(
                        nib,
                        forCellWithReuseIdentifier: register.reuseIdentifier)
                }else {
                    collectionView.register(
                    register.type,
                    forCellWithReuseIdentifier: register.reuseIdentifier)
                    if register.type == nil {
                        print(" ------JXBanner:   When you are not using the nib cell file, ")
                        print(" ------you must set the JXBannerCellRegister-> type to the cell class!! ---------------------")
                    }
                }
                
                cellRegister = register
            }
            
            // numberOfItems
            pageCount = tempDataSource.jxBanner(numberOfItems: self)
            
            // params
            params = dataSource?.jxBanner(self,
                                          params: params) ?? params
            layout.isPagingEnabled = params.isPagingEnabled
            collectionView.contentInset = params.contentInset
            
            // layoutParams
            layout.params = tempDataSource.jxBanner(self,
                                                    layoutParams: layout.params!)
            
            // PageControl
            refreshPageControl()
        }
    }
    
    
    private func refreshPageControl() {
        self.pageControl?.removeFromSuperview()
        self.pageControl = nil
        if params.isShowPageControl {
            let pBuilder = dataSource?.jxBanner(pageControl: self,
                                                numberOfPages: pageCount,
                                                coverView: coverView,
                                                builder: JXBannerPageControlBuilder())
            if let tempPageControl = pBuilder?.pageControl{
                pageControl = tempPageControl
                pageControl?.numberOfPages = pageCount
                coverView.addSubview(tempPageControl)
            }
            if let layout = pBuilder?.layout {
                layout()
            }
        }
    }
    
    private func refreshDelegate() {
        // Dalegate
        if let tempDelegate = delegate {
            tempDelegate.jxBanner(self, coverView: coverView)
        }
    }
    
    private func refreshData() {
        
        if let cell = lastIndexPathCell {
            dataSource?.jxBanner(self,
                                 lastCenterIndex: lastCenterIndex,
                                 lastCenterCell: cell)
            lastCenterIndex = nil
            lastIndexPathCell = nil
        }
        
        // Reinitialize data
        params.currentRollingDirection = .right
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.bounces = params.isBounces
        if pageCount == 1,
            params.cycleWay == .forward {
            params.cycleWay = .skipEnd
        }
        placeholderImgView.isHidden = pageCount > 0
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        DispatchQueue.main.async {
            self.reinitializeIndexPath()
        }
    }
    
    /// Reload current indexpath
    private func reinitializeIndexPath() {
        
        var tempIndexPath = IndexPath(row: 0, section: 0)
        if pageCount > 0,
            params.cycleWay == .forward {
            // Take the middle group and show it
            tempIndexPath = IndexPath(row: (kMultiplier * pageCount / 2),
                                         section: 0)
        }

        if pageCount > 0 {
            scrollToIndexPath(tempIndexPath, animated: false)
        }
        
        collectionView.layoutIfNeeded()
        currentIndexPath = tempIndexPath
    }

    @objc internal override func autoScroll() {

        // Determine if it's on screen
        guard isShowingOnWindow() != false,
            pageCount > 1 else { return }
        
        switch params.cycleWay {
            
        case .forward:
            
            currentIndexPath = currentIndexPath + 1
            scrollToIndexPath(currentIndexPath,
                              animated: true)
        case .skipEnd:
            
            if currentIndexPath.row == pageCount - 1 {
                currentIndexPath = IndexPath(row: 0, section: 0)
                
                scrollToIndexPath(currentIndexPath, animated: false)
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
                scrollToIndexPath(currentIndexPath, animated: true)
            }
        
        case .rollingBack:

            
            switch params.currentRollingDirection {
                
            case .right:
                
                if currentIndexPath.row == pageCount - 1 {
                    currentIndexPath = currentIndexPath - 1
                    params.currentRollingDirection = .left
                }else {
                    currentIndexPath = currentIndexPath + 1
                }
                scrollToIndexPath(currentIndexPath, animated: true)
                
            case .left:
                
                if currentIndexPath.row == 0 {
                    currentIndexPath = currentIndexPath + 1
                    params.currentRollingDirection = .right
                }else {
                    currentIndexPath = currentIndexPath - 1
                }
                scrollToIndexPath(currentIndexPath, animated: true)
            }
        }
    }
    
    /// UICollectionCell rolling error detection
    private func indexPathErrorDetection() {
        let indexPaths = collectionView.indexPathsForVisibleItems
        var attriArr = [UICollectionViewLayoutAttributes?]()
        for indexPath in indexPaths {
            let attri = collectionView.layoutAttributesForItem(at: indexPath)
            attriArr.append(attri)
        }

        let centerValue = (layout.params?.scrollDirection == .vertical)
            ? collectionView.contentOffset.y + collectionView.frame.height * 0.5
            : collectionView.contentOffset.x + collectionView.frame.width * 0.5
        var minSpace = CGFloat(MAXFLOAT)
        var shouldSet = true
        if layout.params?.layoutType != nil && indexPaths.count <= 2 {
            shouldSet = false
        }
        
        var tempIndexPath: IndexPath?
        for atr in attriArr {
            if let obj = atr, shouldSet {
                obj.zIndex = 0;
                
                let objCenterValue = (layout.params?.scrollDirection == .vertical)
                    ? obj.center.y : obj.center.x
                if(abs(minSpace) > abs(objCenterValue - centerValue)) {
                    minSpace = objCenterValue - centerValue;
                    tempIndexPath = obj.indexPath;
                }
            }
        }
        // currentIndexPath != tempIndexPath : To mask multiple calls to currentIndexPath's didSet method
        if currentIndexPath != tempIndexPath,
            let indexPath = tempIndexPath {
            currentIndexPath = indexPath
        }
        scrollToIndexPath(currentIndexPath, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension JXBanner {
    
    /// Began to drag and drop
    public func scrollViewWillBeginDragging(
        _ scrollView: UIScrollView) { pause() }
    
    /// The drag is about to end
    public func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        pause()
        
        let resVelocity = (layout.params?.scrollDirection == .vertical)
            ? velocity.y : velocity.x
        
        if params.cycleWay != .forward {
            
            if resVelocity >= 0 ,
                currentIndexPath.row == pageCount - 1 {
                scrollToIndexPath(currentIndexPath, animated: true)
                return
            }
            
            if resVelocity <= 0 ,
                currentIndexPath.row == 0 {
                scrollToIndexPath(currentIndexPath, animated: true)
                return
            }
        }
        
        if resVelocity > 0 {
            // Slide left. Next slide
            currentIndexPath = currentIndexPath + 1
        }else if resVelocity < 0 {
            // Slide right. Go ahead
            currentIndexPath = currentIndexPath - 1
        }else {
            // Error detection
            indexPathErrorDetection()
        }
    }
    
    /// It's going to start slowing down
    public  func scrollViewWillBeginDecelerating(
        _ scrollView: UIScrollView) {
        scrollToIndexPath(currentIndexPath,
                          animated: true)
    }
    
    /// End to slow down
    public func scrollViewDidEndDecelerating(
        _ scrollView: UIScrollView) {}
    
    /// Scroll animation complete
    public func scrollViewDidEndScrollingAnimation(
        _ scrollView: UIScrollView) {
        start()
    }
    
    /// Rolling in the
    public func scrollViewDidScroll(
        _ scrollView: UIScrollView) {}
}

// MARK:- UICollectionViewDataSource, UICollectionViewDelegate
extension JXBanner:
    UICollectionViewDataSource,
UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int)
        -> Int {
            return params.cycleWay == .forward ? kMultiplier * pageCount : pageCount
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellRegister.reuseIdentifier,
                for: indexPath)
            return dataSource?.jxBanner(self,
                                        cellForItemAt: indexOfIndexPath(indexPath),
                                        cell: cell) ?? cell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.jxBanner(self,
                           didSelectItemAt: indexOfIndexPath(indexPath))
        indexPathErrorDetection()
    }
    
    func indexOfIndexPath(_ indexPath : IndexPath)
        -> Int {
            return pageCount > 0 ? Int(indexPath.item % pageCount) : 0
    }
}

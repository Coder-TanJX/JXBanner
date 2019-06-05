//
//  jxBanner.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


/// 用于 placeholder #F5F5F5
let PLACEHOLDER_GRAY = UIColor(white: 245.0 / 255.0, alpha: 1.0)

private let kMultiplier = 1000

//MARK: - init banner
class JXBanner: UIView, JXBannerType {

     internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        installNotifications()
        setupSubViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        installNotifications()
        setupSubViews()
    }
    
    /// Setup UI
    private func setupSubViews() {
        self.addSubview(collectionView)
        self.addSubview(contentView)
    }
    
    private func installNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidEnterBackground(_:)),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive(_:)),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    deinit {
        stop()
        NotificationCenter.default.removeObserver(self)
        print("jxBanner: \(self) is being deinitialized")
    }
    
    //MARK: - override
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.bounds
        self.collectionView.frame = self.bounds
    }
    
    override func removeFromSuperview() {
        stop()
        super.removeFromSuperview()
    }
    
    // MARK: - The property list of the banner
    private var timer: Timer?
    
    private lazy var layout: JXBannerLayout = {
        let layout = JXBannerLayout()
        layout.params = JXBannerLayoutParams()
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView =
            UICollectionView(frame: self.bounds,
                             collectionViewLayout: self.layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.01)
        collectionView.register(UICollectionViewCell.classForCoder(),
                                forCellWithReuseIdentifier: "tempCell")
        return collectionView
    }()
    
    private lazy var contentView: UIView = {
        let contentView: UIView = UIView()
        contentView.isUserInteractionEnabled = false
        return contentView
    }()

    private var pageCount: Int = 0
    private var params: JXBannerParams = JXBannerParams()
    
    var dataSource: JXBannerDataSource? { didSet { reloadView() }}
    
    var delegate: JXBannerDelegate?

    /// Outside of pageControl
    private var pageControl: (UIView & JXBannerPageControlType)?
    
    /// Current shows indexpath of cell
    var currentIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    var cellRegister: JXBannerCellRegister = JXBannerCellRegister(type: JXBannerCell.self,
                                                                  reuseIdentifier: "JXBannerCell")

    //MARK:- Outside Api
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
    
    /// Reload current indexpath
    fileprivate func reinitializeIndexPath() {
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
    
}

// MARK: - Method of timer animation
extension JXBanner {

    func pause() {
        if let timer = self.timer {
            timer.fireDate = Date.distantFuture
        }
    }
    
    func resume() {
        timer?.fireDate = Date(timeIntervalSinceNow: params.timeInterval)
    }
    
    private func start() {
        if params.timeInterval > 0 && params.isAutoPlay {
            if self.timer == nil {
                if #available(iOS 10.0, *) {
                    self.timer = Timer.scheduledTimer(
                        withTimeInterval: params.timeInterval,
                        repeats: true,
                        block: {[weak self] (timer) in
                            self?.autoScroll()
                    })
                } else {
                    self.timer = Timer.scheduledTimer(
                        timeInterval: params.timeInterval,
                        target: self, selector:
                        #selector(autoScroll),
                        userInfo: nil,
                        repeats: true)
                }
            }
            let interval =  (params.timeInterval < params.minLaunchInterval)
                ? params.minLaunchInterval : params.timeInterval
            self.timer?.fireDate = Date(timeIntervalSinceNow: interval)
        }
    }
    
    private func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func autoScroll() {
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
    
    fileprivate func scrollToIndexPath(
        _ indexPath: IndexPath, animated: Bool) {
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: animated)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: animated)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            stop()
        }
    }
    
    @objc private func applicationDidEnterBackground(
        _ notification: Notification) {
        pause()
    }
    
    @objc private func applicationDidBecomeActive(
        _ notification: Notification) {
        guard self.window != nil else { return }
        let rectInWindow = convert(frame,
                                   to: UIApplication.shared.keyWindow)
        guard (UIApplication.shared.keyWindow?.bounds.intersects(rectInWindow) ?? false)
            else { return }
        resume()
    }
}

// MARK: - UIScrollViewDelegate
extension JXBanner {
    
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
        self.pageControl?.currentPage = indexOfIndexPath(currentIndexPath)
    }
    
    /// Rolling in the
    func scrollViewDidScroll(
        _ scrollView: UIScrollView) {
        pause()
    }
    
    /// cell错位检测和调整
    fileprivate func adjustErrorCell(isScroll: Bool)
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


// MARK:- UICollectionViewDataSource, UICollectionViewDelegate
extension JXBanner:
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
        self.adjustErrorCell(isScroll: true)
    }
    
    func indexOfIndexPath(_ indexPath : IndexPath)
        -> Int {
            return Int(indexPath.item % pageCount)
    }
}


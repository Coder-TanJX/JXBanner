//
//  JXBannerBase.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/6/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class JXBannerBase: UIView {

    required init?(coder aDecoder: NSCoder) {
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
        self.addSubview(pageControl)
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
        stopAnimation()
        NotificationCenter.default.removeObserver(self)
        print("jxBanner: \(self) is being deinitialized")
    }
    
    //MARK: - override
    override func removeFromSuperview() {
        stopAnimation()
        super.removeFromSuperview()
    }
    
    // MARK: - The property list of the banner
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView =
            UICollectionView(frame: self.bounds,
                             collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.bounces = false
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.01)
        return collectionView
    }()
    
    public lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor(
            red: 85.0/255.0,
            green: 190.0/255.0,
            blue: 1.0,
            alpha: 1.0
        )
        pageControl.pageIndicatorTintColor = .white
        return pageControl
    }()
    
//    private var pageCount: Int {
//        get {
//            return dataSource?.jxBanner(numberOfItems: self)
//                ?? 0
//        }
//    }

//    private var layoutParams: JXBannerLayoutParams {
//        get {
//            return (dataSource?.jxBanner(self, layoutParams: layout.params!))
//                ?? layout.params!
//        }
//    }
    
//    var dataSource: JXBannerDataSource? {
//        didSet {
//            reloadView()
//        }
//    }
    
    var delegate: JXBannerDelegate?
    
    var duration: TimeInterval = 3.0
    
    private var timer: Timer?
    
    private lazy var layout: JXBannerLayout = {
        let layout = JXBannerLayout()
        let params = JXBannerLayoutParams()
        layout.params = params
        return layout
    }()
    
    /// Outside of pageControl
    var outerPageControl: (UIView & JXBannerPageControlType)?
    
    /// 当前居中展示的cell的下标
    var currentIndexPath: IndexPath = IndexPath.init(row: 0, section: 0)
    
    var cellRegister: JXBannerCellRegister = JXBannerCellRegister(type: JXBannerCell.self,
                                                                  reuseIdentifier: "JXBannerCell")
    
    //MARK:- Outside Api
//    func reloadView() {
//
//        if let register = dataSource?.jxBanner(self) {
//            collectionView.register(
//                register.type,
//                forCellWithReuseIdentifier: register.reuseIdentifier)
//            cellRegister = register
//        }
//
//        if let count = dataSource?.jxBanner(numberOfItems: self),
//            let tempDataSource = dataSource {
//            stopAnimation()
//            layout.params = layoutParams
//            collectionView.setCollectionViewLayout(layout, animated: true)
//            collectionView.reloadData()
//
//            if let pageControl = tempDataSource.setOuterPageControl() {
//                outerPageControl = pageControl
//                outerPageControl!.numberOfPages = count
//                outerPageControl!.currentPage = 0
//            }else {
//                pageControl.numberOfPages = count
//                pageControl.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
//                let size = pageControl.size(forNumberOfPages: pageControl.numberOfPages)
//                pageControl.center = CGPoint(x: (self.bounds.size.width - (size.width / 2) * 0.6) - 10,
//                                             y: self.bounds.maxY - 12)
//                pageControl.autoresizingMask = [
//                    .flexibleLeftMargin,
//                    .flexibleTopMargin
//                ]
//                pageControl.currentPage = 0
//            }
//            startAnimation()
//        }
//    }
    
}

// MARK: - Method of timer animation
extension JXBannerBase {
    
    func pause() {
        if let timer = self.timer {
            timer.fireDate = Date.distantFuture
        }
    }
    
    func resume() {
        timer?.fireDate = Date(timeIntervalSinceNow: 5.0)
    }
    
//    private func startAnimation() {
//        if duration > 0 {
//            if self.timer == nil {
//                if #available(iOS 10.0, *) {
//                    self.timer = Timer.scheduledTimer(
//                        withTimeInterval: duration,
//                        repeats: true,
//                        block: {[weak self] (timer) in
//                            self?.autoScroll()
//                    })
//                } else {
//                    self.timer = Timer.scheduledTimer(
//                        timeInterval: duration,
//                        target: self, selector:
//                        #selector(autoScroll),
//                        userInfo: nil,
//                        repeats: true)
//                }
//            }
//            self.timer?.fireDate = Date.init(timeIntervalSinceNow: duration)
//        }
//    }
    
    private func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }
    
//    @objc private func autoScroll() {
//        guard pageCount > 1 else { return }
//
//        // 判断是否在屏幕中
//        guard self.window != nil else { return }
//        let rectInWindow = convert(frame, to: UIApplication.shared.keyWindow)
//        guard (UIApplication.shared.keyWindow?.bounds.intersects(rectInWindow) ?? false) else { return }
//
//
//        self.currentIndexPath = self.currentIndexPath + 1;
//        print(self.currentIndexPath)
//        collectionView.scrollToItem(
//            at: self.currentIndexPath,
//            at: .centeredHorizontally,
//            animated: true
//        )
//        collectionView.scrollToItem(
//            at: self.currentIndexPath,
//            at: .centeredHorizontally,
//            animated: true
//        )
//    }
    
    fileprivate func scrollToIndexPath(
        _ indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: true)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            stopAnimation()
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
//extension JXBannerBase {
//    /// 开始拖拽
//    func scrollViewWillBeginDragging(
//        _ scrollView: UIScrollView) {
//        self.pause()
//    }
//
//    /// 将要结束拖拽
//    func scrollViewWillEndDragging(
//        _ scrollView: UIScrollView,
//        withVelocity velocity: CGPoint,
//        targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//        // 这里不用考虑越界问题,其他地方做了保护
//        if velocity.x > 0 {
//            //左滑,下一张
//            self.currentIndexPath = self.currentIndexPath + 1
//        }else if velocity.x < 0 {
//            //右滑, 上一张
//            self.currentIndexPath = self.currentIndexPath - 1
//        }else {
//            print("未滑动, 不翻页")
//        }
//    }
//
//    /// 将要开始减速
//    func scrollViewWillBeginDecelerating(
//        _ scrollView: UIScrollView) {
//        // 在这里将需要显示的cell置为居中
//        scrollToIndexPath(currentIndexPath)
//        scrollToIndexPath(currentIndexPath)
//    }
//
//    /// 结束减速
//    func scrollViewDidEndDecelerating(
//        _ scrollView: UIScrollView) {}
//
//    /// 滚动动画完成
//    func scrollViewDidEndScrollingAnimation(
//        _ scrollView: UIScrollView) {
//        startAnimation()
//    }
//
//    /// 滚动中
//    func scrollViewDidScroll(
//        _ scrollView: UIScrollView) {
//        self.pause()
//    }
//}


// MARK:- UICollectionViewDataSource, UICollectionViewDelegate
//extension JXBannerBase:
//    UICollectionViewDataSource,
//    UICollectionViewDelegate,
//UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView,
//                        numberOfItemsInSection section: Int)
//        -> Int {
//            return pageCount * kMultiplier
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath)
//        -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: cellRegister.reuseIdentifier,
//                for: indexPath)
//
//            if let bannerViewCell = cell as? JXBannerBaseCell {
//                return dataSource?.jxBanner(self,
//                                            cellForItemAt: indexOfIndexPath(indexPath),
//                                            cell: bannerViewCell) ?? bannerViewCell
//            }
//            return cell
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView,
//                        didSelectItemAt indexPath: IndexPath) {
//        delegate?.jxBanner(self,
//                           didSelectItemAt: indexOfIndexPath(indexPath))
//    }
//
//    func indexOfIndexPath(_ indexPath : IndexPath)
//        -> Int {
//            return Int(indexPath.item % pageCount)
//    }
//
//}



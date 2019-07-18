//
//  JXBaseBanner.swift
//  JXBanner_Example
//
//  Created by 谭家祥 on 2019/6/6.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class JXBaseBanner: UIView {

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
    func setupSubViews() {
        self.addSubview(collectionView)
        self.addSubview(contentView)
    }
    
    func installNotifications() {
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
    var timer: Timer?
    
    lazy var layout: JXBannerLayout = {
        let layout = JXBannerLayout()
        layout.params = JXBannerLayoutParams()
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView =
            UICollectionView(frame: self.bounds,
                             collectionViewLayout: self.layout)
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.01)
        return collectionView
    }()
    
    lazy var contentView: UIView = {
        let contentView: UIView = UIView()
        contentView.isUserInteractionEnabled = false
        return contentView
    }()
    
    var pageCount: Int = 0
    
    var params: JXBannerParams = JXBannerParams()

    /// Outside of pageControl
    var pageControl: (UIView & JXBannerPageControlType)?
    
    /// Current shows indexpath of cell
    var currentIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    var cellRegister: JXBannerCellRegister = JXBannerCellRegister(type: JXBannerCell.self,
                                                                  reuseIdentifier: "JXBannerCell")
}

// MARK: - Method of timer animation
extension JXBaseBanner {
    
    func pause() {
        if let timer = self.timer {
            timer.fireDate = Date.distantFuture
        }
    }
    
    func resume() {
        timer?.fireDate = Date(timeIntervalSinceNow: params.timeInterval)
    }
    
    func start() {
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
                RunLoop.current.add(self.timer!, forMode: .common)
            }
            let interval =  (params.timeInterval < params.minLaunchInterval)
                ? params.minLaunchInterval : params.timeInterval
            self.timer?.fireDate = Date(timeIntervalSinceNow: interval)
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func autoScroll() {}
    
    func scrollToIndexPath(
        _ indexPath: IndexPath, animated: Bool) {
        
        //FIXME: 越界bug
        
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
    
    @objc func applicationDidEnterBackground(
        _ notification: Notification) {
        pause()
    }
    
    @objc func applicationDidBecomeActive(
        _ notification: Notification) {
        guard self.window != nil else { return }
        let rectInWindow = convert(frame,
                                   to: UIApplication.shared.keyWindow)
        guard (UIApplication.shared.keyWindow?.bounds.intersects(rectInWindow) ?? false)
            else { return }
        resume()
    }
}





//
//  JXBaseBanner.swift
//  JXBanner_Example
//
//  Created by 谭家祥 on 2019/6/6.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

let kMultiplier = 1000

public class JXBaseBanner: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.autoresizingMask = []
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
        self.addSubview(placeholderImgView)
        self.addSubview(collectionView)
        self.addSubview(coverView)
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
    override public func layoutSubviews() {
        super.layoutSubviews()
        if let itemSize = layout.params?.itemSize {
            var frame = CGRect.zero
            frame.size = itemSize
            placeholderImgView.frame = frame
            placeholderImgView.center = center
        }else {
            placeholderImgView.frame = bounds
            layout.params = layout.params
        }
        if pageCount > 0 {
            scrollToIndexPath(currentIndexPath, animated: false)
        }
    }
    
    override public func removeFromSuperview() {
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
    
    public lazy var placeholderImgView: UIImageView = {
        let placeholder = UIImageView()
        return placeholder
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView =
            UICollectionView(frame: self.bounds,
                             collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.01)
        collectionView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        return collectionView
    }()
    
    lazy var coverView: UIView = {
        let coverView: UIView = UIView()
        coverView.frame = self.bounds
        coverView.isUserInteractionEnabled = false
        coverView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        return coverView
    }()
    
    var pageCount: Int = 0
    
    var params: JXBannerParams = JXBannerParams()
    
    /// Current shows indexpath of cell
    var currentIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    var cellRegister: JXBannerCellRegister = JXBannerCellRegister(type: JXBannerCell.self,
                                                                  reuseIdentifier: "JXBannerCell")
    func setCurrentIndex(){}
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
        if params.timeInterval > 0,
            params.isAutoPlay,
            pageCount > 1 {
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
        
        // Handle indexpath bounds
        if params.cycleWay == .forward {
            
            if indexPath.row >= kMultiplier * pageCount - pageCount{
                currentIndexPath = IndexPath(row: (kMultiplier * pageCount / 2),
                                             section: 0)
                scrollToIndexPath(currentIndexPath, animated: false)
                setCurrentIndex()
                start()
                return
                
            }else if indexPath.row == -1 + pageCount {
                currentIndexPath = IndexPath(row: (kMultiplier * pageCount / 2) + (pageCount - 1),
                                             section: 0)
                scrollToIndexPath(currentIndexPath, animated: false)
                
                setCurrentIndex()
                start()
                return
            }
        }
        
 
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: animated)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: animated)
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
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





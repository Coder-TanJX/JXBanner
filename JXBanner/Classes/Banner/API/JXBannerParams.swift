//
//  JXBannerParams.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

// MARK: - Property list
public class JXBannerParams {

    public var isAutoPlay: Bool = true
    
    public var isBounces: Bool = true
    
    public var isShowPageControl: Bool = true
    
    public var isPagingEnabled: Bool = true
    
    public var contentInset = UIEdgeInsets.zero
    
    public var timeInterval: TimeInterval = 5.0
    
    public var cycleWay: CycleWay = .forward
    
    public var edgeTransitionType: JXBannerTransitionType? = .fade
    
    public var edgeTransitionSubtype: CATransitionSubtype = .fromRight
    
    internal var currentRollingDirection: RollingDirection = .right
}

// MARK: - Public enum
public extension JXBannerParams {
    
    enum JXBannerTransitionType : String {
        case fade
        case push
        case reveal
        case moveIn
        case cube
        case suckEffect
        case oglFlip
        case rippleEffect
        case pageCurl
        case pageUnCurl
        case cameraIrisHollowOpen
        case cameraIrisHollowClose
        case curlDown
        case curlUp
        case flipFromLeft
        case flipFromRight
    }
    
    enum CycleWay {
        case forward
        case skipEnd
        case rollingBack
    }
    
    enum RollingDirection {
        case right
        case left
    }
}

// MARK: - Set function
public extension JXBannerParams {
    
    func isAutoPlay(_ isAutoPlay: Bool) -> JXBannerParams {
        self.isAutoPlay = isAutoPlay
        return self
    }
    
    func isBounces(_ isBounces: Bool) -> JXBannerParams {
        self.isBounces = isBounces
        return self
    }
    
    func isPagingEnabled(_ isPagingEnabled: Bool) -> JXBannerParams {
        self.isPagingEnabled = isPagingEnabled
        return self
    }
    
    func contentInset(_ contentInset: UIEdgeInsets) -> JXBannerParams {
        self.contentInset = contentInset
        return self
    }
    
    func isShowPageControl(_ isShowPageControl: Bool) -> JXBannerParams {
        self.isShowPageControl = isShowPageControl
        return self
    }
    
    func timeInterval(_ timeInterval: TimeInterval) -> JXBannerParams {
        self.timeInterval = timeInterval
        return self
    }
    
    func cycleWay(_ cycleWay: CycleWay) -> JXBannerParams {
        self.cycleWay = cycleWay
        return self
    }
    
    func edgeTransitionType(_ edgeTransitionType: JXBannerTransitionType?) -> JXBannerParams {
        self.edgeTransitionType = edgeTransitionType
        return self
    }
    
    func edgeTransitionSubtype(_ edgeTransitionSubtype: CATransitionSubtype) -> JXBannerParams {
        self.edgeTransitionSubtype = edgeTransitionSubtype
        return self
    }
    
    internal func currentRollingDirection(_ currentRollingDirection: RollingDirection) -> JXBannerParams {
        self.currentRollingDirection = currentRollingDirection
        return self
    }

}

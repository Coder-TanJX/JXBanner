//
//  JXBannerParams.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public class JXBannerParams {

    var isAutoPlay: Bool = true
    
    var isCycleChain: Bool = true
    
    var isBounces: Bool = true
    
    var timeInterval: TimeInterval = 5.0
    
    var minLaunchInterval: TimeInterval = 3.0
    
    var edgeTransitionType: JXBannerTransitionType? = .fade
    
    var edgeTransitionSubtype: CATransitionSubtype = .fromRight
    
//    var isShowPageControl: Bool = false
    
//    var pageControl: JXBannerPageControlType = JXBannerSystemPageControl()
    
    
    
}

// MARK: - Set function
extension JXBannerParams {
    
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
    
    func isAutoPlay(_ isAutoPlay: Bool) -> JXBannerParams {
        self.isAutoPlay = isAutoPlay
        return self
    }
    
    func isCycleChain(_ isCycleChain: Bool) -> JXBannerParams {
        self.isCycleChain = isCycleChain
        return self
    }
    
    func isBounces(_ isBounces: Bool) -> JXBannerParams {
        self.isBounces = isBounces
        return self
    }
    
    func timeInterval(_ timeInterval: TimeInterval) -> JXBannerParams {
        self.timeInterval = timeInterval
        return self
    }
    
    func minLaunchInterval(_ minLaunchInterval: TimeInterval) -> JXBannerParams {
        self.minLaunchInterval = minLaunchInterval
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

}

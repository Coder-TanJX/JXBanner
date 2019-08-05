//
//  Timer+JXBExtension.swift
//  JXBanner_Example
//
//  Created by Coder_TanJX on 2019/8/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class Block<T> {
    let f : T
    init(_ f: T) {
        self.f = f
    }
}

extension Timer {
    
    class func jx_scheduledTimer(
        withTimeInterval interval: TimeInterval,
        repeats: Bool,
        block: @escaping (Timer) -> Swift.Void) -> Timer {
        
        if #available(iOS 10.0, *) {
            
            return Timer.scheduledTimer(withTimeInterval: interval,
                                        repeats: repeats,
                                        block: block)
        }
        
        return Timer.scheduledTimer(timeInterval: interval,
                                    target: self,
                                    selector: #selector(jx_timerAction),
                                    userInfo: Block(block),
                                    repeats: repeats)
    }
    
    
    
    @objc class func jx_timerAction(_ sender: Timer) {
        if let block = sender.userInfo as? Block<(Timer) -> Swift.Void> {
            block.f(sender)
        }
        
    }
    
}

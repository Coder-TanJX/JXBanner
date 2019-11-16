//
//  View+JXExtension.swift
//  JXBanner_Example
//
//  Created by Coder_TanJX on 2019/8/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {
    
    // Determine if it's on screen
    func isShowingOnWindow() -> Bool {
        
        guard self.window != nil,
            isHidden != true,
            alpha > 0.01,
            superview != nil
            else {
                return false
        }
        
        // convert self to window's Rect
        var rect: CGRect = superview!.convert(frame, to: nil)
        
        // if size is CGrectZero
        if rect.isEmpty || rect.isNull || rect.size.equalTo(CGSize.zero) {
            return false
        }
        
        // set offset
        if let scorllView = self as? UIScrollView  {
            rect.origin.x += scorllView.contentOffset.x
            rect.origin.y += scorllView.contentOffset.y
        }

        // get the Rect that intersects self and window
        let screenRect: CGRect = UIScreen.main.bounds
        let intersectionRect: CGRect = rect.intersection(screenRect)
        if intersectionRect.isEmpty || intersectionRect.isNull {
            return false
        }
        
        return true
        
    }
}

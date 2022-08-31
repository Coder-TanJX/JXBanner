//
//  JXBannerTransfrom.swift
//  JXBanner_Example
//
//  Created by Coder_TanJX on 2019/6/6.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public struct JXBannerTransfrom {

    public enum JXTransformLocation {
        case left
        case center
        case right
    }
    
    public static func itemLocation(viewCenterX: CGFloat,
                      itemCenterX: CGFloat) -> JXTransformLocation {
        var location: JXTransformLocation = .right
        if abs(itemCenterX - viewCenterX) < 0.5 {
            location = .center
        }else if (itemCenterX - viewCenterX) < 0 {
            location = .left
        }
        return location
    }
}

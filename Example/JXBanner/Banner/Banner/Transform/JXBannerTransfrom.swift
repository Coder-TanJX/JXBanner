//
//  JXBannerTransfrom.swift
//  JXBanner_Example
//
//  Created by 谭家祥 on 2019/6/6.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

struct JXBannerTransfrom {

    enum JXTransformLocation {
        case left
        case center
        case right
    }
    
    static func itemLocation(viewCentetX: CGFloat,
                      itemCenterX: CGFloat) -> JXTransformLocation {
        var location: JXTransformLocation = .right
        if abs(itemCenterX - viewCentetX) < 0.5 {
            location = .center
        }else if (itemCenterX - viewCentetX) < 0 {
            location = .left
        }
        return location
    }
}

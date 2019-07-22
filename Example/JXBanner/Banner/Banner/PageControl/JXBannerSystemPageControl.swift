//
//  JXBannerSystemPageControl.swift
//  JXBanner_Example
//
//  Created by 谭家祥 on 2019/6/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import JXPageControl

class JXBannerDefaultPageControl: JXPageControlEllipse, JXBannerPageControlType {
    var delegate: JXPageControlType?
    
    override func setBase() {
        super.setBase()
        activeSize = CGSize(width: 20, height: 8)
        inactiveSize = CGSize(width: 8, height: 8)
    }
}

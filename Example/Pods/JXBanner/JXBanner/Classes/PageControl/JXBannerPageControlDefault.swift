//
//  JXBannerPageControlDefault.swift
//  JXBanner_Example
//
//  Created by Coder_TanJX on 2019/7/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import JXPageControl

class JXBannerPageControlDefault: JXPageControlJump {
    
    override func setBase() {
        super.setBase()
        
        activeSize = CGSize(width: 15, height: 6)
        inactiveSize = CGSize(width: 6, height: 6)
        columnSpacing = 0
        contentMode = .right
    }
}

//
//  JXPageControlLine.swift
//  JXPageControl_Example
//
//  Created by Coder_TanJX on 2019/6/8.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable open class JXPageControlLine: JXPageControlJump {
    
    override open func setBase() {
        super.setBase()
        indicatorSize = CGSize(width: 15, height: 2)
        isAnimation = false
    }
}

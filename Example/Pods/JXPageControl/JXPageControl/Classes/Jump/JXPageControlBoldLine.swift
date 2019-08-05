//
//  JXPageControlBoldLine.swift
//  JXPageControl_Example
//
//  Created by Coder_TanJX on 2019/6/9.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable open class JXPageControlBoldLine: JXPageControlJump {

    override open func setBase() {
        super.setBase()
        indicatorSize = CGSize(width: 15, height: 6)
        isAnimation = false
    }
}

//
//  pageControlBuilder.swift
//  JXBanner_Example
//
//  Created by 谭家祥 on 2019/7/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import JXPageControl

public class pageControlBuilder {
    
    // The JXPageControlType is the default indicator
    var pageControl: (UIView & JXPageControlType)?
    
    /// Layout of the callback
    var layout: (() -> ())?
}

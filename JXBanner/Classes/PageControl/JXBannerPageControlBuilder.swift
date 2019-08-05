//
//  JXBannerPageControlBuilder.swift
//  JXBanner_Example
//
//  Created by Coder_TanJX on 2019/7/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import JXPageControl

public class JXBannerPageControlBuilder {
    
    // The JXPageControlType is the default indicator
    public var pageControl: (UIView & JXPageControlType)?
    
    /// Layout of the callback
    public var layout: (() -> ())?
}

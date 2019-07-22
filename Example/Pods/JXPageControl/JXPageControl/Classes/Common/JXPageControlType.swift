//
//  JXPageControlType.swift
//  JXPageControl
//
//  Created by 谭家祥 on 2019/6/7.
//

import UIKit

 let kMinItemWidth: CGFloat = 2.0
 let kMinItemHeight: CGFloat = 2.0

public class JXPageControlAlignment: NSObject {
    
    public enum JXHorizonAlignment : Int {
        case left
        case center
        case right
    }
    
    public enum JXVerticalAlignment : Int {
        case top
        case center
        case bottom
    }
    
    var horizon: JXHorizonAlignment
    var vertical: JXVerticalAlignment
    
    public init(_ horizon: JXHorizonAlignment,
         _ vertical: JXVerticalAlignment) {
        self.horizon = horizon
        self.vertical = vertical
    }
}

public protocol JXPageControlType {

    /// Default is 0
    var numberOfPages: Int { get set }
    
    /// Default is 0. value pinned to 0..numberOfPages-1
    var currentPage: Int { get set }
    
    /// Default is 0.0. value pinned to 0.0..numberOfPages-1
    var progress: CGFloat { get set}
    
    /// Hide the the indicator if there is only one page. default is NO
    var hidesForSinglePage: Bool { get set }
    
    /// Inactive item tint color
    var inactiveColor: UIColor { get set }
    
    /// Active indicator ting color
    var activeColor: UIColor { get set }
    
    /// Inactive indicator size
    var inactiveSize: CGSize { get set }
    
    /// Active indicator size
    var activeSize: CGSize { get set }
    
    /// Sets the size of all indicators
    var indicatorSize: CGSize { get set }
    
    /// Column spacing
    var columnSpacing: CGFloat { get set }
    
    /// Content location
    var contentAlignment: JXPageControlAlignment { get set }
    
    /// The content location of the system UIView
    var contentMode: UIViewContentMode { get set }
    
    /// Inactive hollow figure
    var isInactiveHollow: Bool { get set }
    
    /// Active hollow figure
    var isActiveHollow: Bool { get set }
    
    /// Refresh the data and UI again
    func reload()
}







//
//  JXPageControlBase.swift
//  JXPageControl_Example
//
//  Created by 谭家祥 on 2019/7/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable open class JXPageControlBase: UIView, JXPageControlType {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setBase()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setBase()
    }
    
    open func setBase() {
        addSubview(contentView)
    }
    
    open override var contentMode: UIViewContentMode {
        didSet {
            switch contentMode {
                
            case .center:
                contentAlignment = JXPageControlAlignment(.center, .center)
            case .left:
                contentAlignment = JXPageControlAlignment(.left, .center)
            case .right:
                contentAlignment = JXPageControlAlignment(.right, .center)
                
            case .bottom:
                contentAlignment = JXPageControlAlignment(.center, .bottom)
            case .bottomLeft:
                contentAlignment = JXPageControlAlignment(.left, .bottom)
            case .bottomRight:
                contentAlignment = JXPageControlAlignment(.right, .bottom)
                
            case .top:
                contentAlignment = JXPageControlAlignment(.center, .top)
            case .topLeft:
                contentAlignment = JXPageControlAlignment(.left, .top)
            case .topRight:
                contentAlignment = JXPageControlAlignment(.right, .top)
                
            default:
                contentAlignment = JXPageControlAlignment(.center, .center)
            }
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentView()
    }
    
    // MARK: --------------------------- JXPageControlType --------------------------
    
    /// Default is 0
    @IBInspectable public var numberOfPages: Int = 0 {
        didSet { reloadData() }
    }
    
    var currentIndex: Int = 0
    public var currentPage: Int {
        set { updateCurrentPage(newValue) }
        get { return currentIndex }
    }
    
    /// Default is 0.0. value pinned to 0.0..numberOfPages-1
    @IBInspectable public var progress: CGFloat = 0.0 {
        didSet { updateProgress(progress) }
    }
    
    /// Hide the the indicator if there is only one page. default is NO
    @IBInspectable public var hidesForSinglePage: Bool = false {
        didSet { resetHidden() }
    }
    
    /// Inactive item tint color
    @IBInspectable public var inactiveColor: UIColor =
        UIColor.groupTableViewBackground.withAlphaComponent(0.5) {
        didSet { inactiveHollowLayout() }
    }
    
    /// Active item ting color
    @IBInspectable public var activeColor: UIColor =
        UIColor.white {
        didSet { activeHollowLayout() }
    }
    
    /// Inactive item size
    @IBInspectable public var inactiveSize: CGSize =
        CGSize(width: 10,
               height: 10){
        didSet {
            reloadLayout()
            updateProgress(CGFloat(currentIndex))
        }
    }
    
    /// Active item size
    @IBInspectable public var activeSize: CGSize =
        CGSize(width: 10,
               height: 10){
        didSet {
            reloadLayout()
            updateProgress(CGFloat(currentIndex))
        }
    }
    
    /// Sets the color of all indicators
    @IBInspectable public var indicatorSize: CGSize =
        CGSize(width: 10,
               height: 10) {
        didSet {
            inactiveSize = indicatorSize
            activeSize = indicatorSize
        }
    }
    
    /// Column spacing
    @IBInspectable public var columnSpacing: CGFloat = 10.0 {
        didSet {
            reloadLayout()
            updateProgress(CGFloat(currentIndex))
        }
    }
    
    /// Inactive hollow figure
    @IBInspectable public var isInactiveHollow: Bool = false {
        didSet { inactiveHollowLayout() }
    }
    
    /// Active hollow figure
    @IBInspectable public var isActiveHollow: Bool = false {
        didSet { activeHollowLayout() }
    }
    
    /// Content location
    public var contentAlignment: JXPageControlAlignment =
        JXPageControlAlignment(.center,
                               .center) {
        didSet { reloadLayout()
            updateProgress(CGFloat(currentIndex)) }
    }
    
    /// Refresh the data and UI again
    public func reload() {
        reloadData()
    }
    
    // MARK: - -------------------------- Internal property list --------------------------
    let contentView: UIView = UIView()
    
    var maxIndicatorSize: CGSize = CGSize(width: 2, height: 2)
    
    var minIndicatorSize: CGSize = CGSize(width: 2, height: 2)
    
    var inactiveLayer: [CALayer] = []
    
    var activeLayer: CALayer?
    
    // MARK: - -------------------------- Update tht data --------------------------
    func reloadData() {
        resetInactiveLayer()
        resetActiveLayer()
        resetHidden()
        reloadLayout()
        progress = 0.0
    }
    
    func reloadLayout() {
        layoutContentView()
        layoutInactiveIndicators()
        layoutActiveIndicator()
    }
    
    func updateProgress(_ progress: CGFloat) {}
    
    func updateCurrentPage(_ pageIndex: Int) {}
    
    func inactiveHollowLayout() {}
    
    
    func activeHollowLayout() {}
    
    // MARK: - -------------------------- Reset --------------------------
    func resetHidden() {
        if hidesForSinglePage,
            numberOfPages == 1 {
            contentView.isHidden = true
        }else if numberOfPages == 0 {
            contentView.isHidden = true
        }else {
            contentView.isHidden = false
        }
    }
    
    func resetInactiveLayer() {
        // clear data
        inactiveLayer.forEach() { $0.removeFromSuperlayer() }
        inactiveLayer = [CALayer]()
        // set new layers
        for _ in 0..<numberOfPages {
            let layer = CALayer()
            contentView.layer.addSublayer(layer)
            inactiveLayer.append(layer)
        }
    }
    
    func resetActiveLayer() {}
    
    // MARK: - -------------------------- Layout --------------------------
    func layoutContentView() {
        
        // MaxItem size
        var itemWidth = kMinItemWidth
        var itemHeight = kMinItemHeight
        minIndicatorSize.width = kMinItemWidth
        minIndicatorSize.height = kMinItemHeight
        
        if activeSize.width >= inactiveSize.width,
            activeSize.width > kMinItemWidth{
            itemWidth = activeSize.width
            minIndicatorSize.width = inactiveSize.width
        } else if inactiveSize.width > activeSize.width,
            inactiveSize.width > kMinItemWidth{
            itemWidth = inactiveSize.width
            minIndicatorSize.width = activeSize.width
        }
        
        if activeSize.height >= inactiveSize.height,
            activeSize.height > kMinItemHeight{
            itemHeight = activeSize.height
            minIndicatorSize.height = inactiveSize.height
        } else if inactiveSize.height > activeSize.height,
            inactiveSize.height > kMinItemHeight{
            itemHeight = inactiveSize.height
            minIndicatorSize.height = activeSize.height
        }
        maxIndicatorSize.height = itemHeight
        maxIndicatorSize.width = itemWidth
        
        // Content Size and frame
        var x: CGFloat = 0
        var y: CGFloat = 0
        let width = CGFloat(numberOfPages) * (itemWidth + columnSpacing) - columnSpacing
        let height = itemHeight
        
        // Horizon layout
        switch contentAlignment.horizon {
        case .left:
            x = 0
        case .right:
            x = (frame.width - width)
        case .center:
            x = (frame.width - width) * 0.5
        }
        
        // Vertical layout
        switch contentAlignment.vertical {
        case .top:
            y = 0
        case .bottom:
            y = frame.height - height
        case .center:
            y = (frame.height - height) * 0.5
        }
        
        contentView.frame = CGRect(x: x,
                                   y: y,
                                   width: width,
                                   height: height)
    }
    
    func layoutActiveIndicator() {}
    
    func layoutInactiveIndicators() {}
}

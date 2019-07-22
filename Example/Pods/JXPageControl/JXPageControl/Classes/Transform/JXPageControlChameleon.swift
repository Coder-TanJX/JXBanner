//
//  JXPageControlChameleon.swift
//  JXPageControl_Example
//
//  Created by 谭家祥 on 2019/7/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable open class JXPageControlChameleon: JXPageControlBase {
    
    
    // MARK: - -------------------------- JXPageControlType --------------------------

    /// Please use the property "indicatorSize"
    override public var activeSize: CGSize {
        get { return CGSize(width: actualIndicatorSize.width,
                            height: actualIndicatorSize.height) }
        set {}
    }
    
    /// Please use the property "indicatorSize"
    override public var inactiveSize: CGSize {
        get { return CGSize(width: actualIndicatorSize.width,
                            height: actualIndicatorSize.height) }
        set {}
    }
    
    var actualIndicatorSize: CGSize = CGSize(width: 10, height: 10)
    override public var indicatorSize: CGSize {
        get { return actualIndicatorSize }
        set {
            actualIndicatorSize = CGSize(
                width: newValue.width > minIndicatorSize.width ?
                    newValue.width : minIndicatorSize.width ,
                height: newValue.height > minIndicatorSize.height ?
                    newValue.height : minIndicatorSize.height )
            reloadLayout()
            updateProgress(CGFloat(currentIndex))
        }
    }
    
    // MARK: - -------------------------- Custom property list --------------------------

    /// When isAnimation is false, the animation time is shorter;
    /// when isAnimation is true, the animation time is longer.
    @IBInspectable public var isAnimation: Bool = true
    
    // MARK: - -------------------------- Update tht data --------------------------

    
    override func updateProgress(_ progress: CGFloat) {
        guard progress >= 0 ,
            progress <= CGFloat(numberOfPages - 1)
            else { return }

        let leftIndex = Int(floor(progress))
        let rightIndex = leftIndex + 1 > numberOfPages - 1 ? leftIndex : leftIndex + 1
        
        if leftIndex == rightIndex {
            for index in 0 ..< numberOfPages {
                let layer = inactiveLayer[index]
                if index != leftIndex{
                    hollowLayout(layer: layer, isActive: false)
                    
                }else {
                    hollowLayout(layer: layer, isActive: true)
                }
            }
        }else {
            
            let leftLayer = inactiveLayer[leftIndex]
            let rightLayer = inactiveLayer[rightIndex]
            let rightScare = progress - floor(progress)
            let leftScare = 1 - rightScare

            CATransaction.begin()
            CATransaction.setDisableActions(!isAnimation)
            CATransaction.setAnimationDuration(0.2)
            
            let tempInactiveColor = isInactiveHollow ? UIColor.clear : inactiveColor
            leftLayer.backgroundColor = UIColor.transform(originColor: tempInactiveColor,
                                                          targetColor: activeColor,
                                                          proportion: leftScare).cgColor
            rightLayer.backgroundColor = UIColor.transform(originColor: tempInactiveColor,
                                                           targetColor: activeColor,
                                                           proportion: rightScare).cgColor
            for index in 0 ..< numberOfPages {
                if index != leftIndex,
                    index != rightIndex {
                    let layer = inactiveLayer[index]
                    hollowLayout(layer: layer, isActive: false)
                }
            }
            CATransaction.commit()
        }
        currentIndex = Int(progress)
    }
    
    override func updateCurrentPage(_ pageIndex: Int) {
        guard pageIndex >= 0 ,
            pageIndex <= numberOfPages - 1,
            pageIndex != currentIndex
            else { return }
        
        for index in 0 ..< numberOfPages {
            if index == currentIndex {
                CATransaction.begin()
                CATransaction.setDisableActions(!isAnimation)
                CATransaction.setAnimationDuration(0.7)
                let layer = inactiveLayer[index]
                hollowLayout(layer: layer, isActive: false)
                CATransaction.commit()
            }else if index == pageIndex {
                let layer = inactiveLayer[index]
                CATransaction.begin()
                CATransaction.setDisableActions(!isAnimation)
                CATransaction.setAnimationDuration(0.7)
                hollowLayout(layer: layer, isActive: true)
                CATransaction.commit()
            }
        }
        currentIndex = pageIndex
    }
    
    override func inactiveHollowLayout() {
        hollowLayout()
    }
    
    override func activeHollowLayout() {
        hollowLayout()
    }
    
    // MARK: - -------------------------- Layout --------------------------

    override func layoutInactiveIndicators() {
        var layerFrame = CGRect(x: 0,
                                y: 0,
                                width: actualIndicatorSize.width ,
                                height: actualIndicatorSize.height)
        inactiveLayer.forEach() { layer in
            layer.frame = layerFrame
            if actualIndicatorSize.width > actualIndicatorSize.height {
                layer.cornerRadius = actualIndicatorSize.height*0.5
            }else {
                layer.cornerRadius = actualIndicatorSize.width*0.5
            }
            layerFrame.origin.x +=  actualIndicatorSize.width + columnSpacing
        }
        hollowLayout()
    }
}

extension JXPageControlChameleon {
    
    private func hollowLayout() {
        if isInactiveHollow {
            for (index, layer) in inactiveLayer.enumerated() {
                if index == currentIndex, !isActiveHollow {
                    layer.backgroundColor = activeColor.cgColor
                }else {
                    layer.backgroundColor = UIColor.clear.cgColor
                    layer.borderColor = activeColor.cgColor
                }
                layer.borderColor = activeColor.cgColor
                layer.borderWidth = 1
            }
        }
        else {
            for (index, layer) in inactiveLayer.enumerated() {
                if index == currentIndex {
                    layer.backgroundColor = activeColor.cgColor
                }else {
                    layer.backgroundColor = inactiveColor.cgColor
                }
                layer.borderWidth = 0
            }
            
        }
    }
    
    private func hollowLayout(layer: CALayer, isActive: Bool) {
        /// Set backgroundcolor
        if isInactiveHollow {
            if isActive,
                !isActiveHollow {
                layer.backgroundColor = activeColor.cgColor
            }else {
                layer.backgroundColor = UIColor.clear.cgColor
                layer.borderColor = activeColor.cgColor
            }
        }else {
            if isActive {
                layer.backgroundColor = activeColor.cgColor
            }else {
                layer.backgroundColor = inactiveColor.cgColor
            }
        }
    }
}

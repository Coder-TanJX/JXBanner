//
//  JXPageControlFill.swift
//  JXPageControl_Example
//
//  Created by 谭家祥 on 2019/6/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable open class JXPageControlFill: JXPageControlBase {

    
    /// Please use the property "diameter"
    override public var activeSize: CGSize {
        get { return CGSize(width: actualDiameter, height: actualDiameter) }
        set {}
    }
    
    /// Please use the property "diameter"
    override public var inactiveSize: CGSize {
        get { return CGSize(width: actualDiameter, height: actualDiameter) }
        set {}
    }
    
    /// Please use the property "diameter"
    override public var indicatorSize: CGSize {
        get { return CGSize(width: actualDiameter, height: actualDiameter) }
        set {}
    }

    // MARK: - -------------------------- Custom property list --------------------------
    
    /// Indicator diameter
    var actualDiameter: CGFloat = 10.0
    @IBInspectable var diameter: CGFloat {
        set {
            actualDiameter = newValue > minIndicatorSize.width ?
                newValue : minIndicatorSize.width
            reloadLayout()
            updateProgress(CGFloat(currentIndex))
        }
        get { return actualDiameter }
    }
    
    /// Indicator ring borderWidth
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            reloadLayout()
            updateProgress(CGFloat(currentIndex))
        }
    }
    
    // MARK: - -------------------------- Update tht data --------------------------
    
    override func updateProgress(_ progress: CGFloat) {
        guard progress >= 0 ,
            progress <= CGFloat(numberOfPages - 1)
            else { return }
        
        let borderW: CGFloat = isInactiveHollow ? borderWidth : 0
        let insetRect = CGRect(x: 0,
                          y: 0,
                          width: actualDiameter,
                          height: actualDiameter).insetBy(dx: borderW, dy: borderW)

        let left = floor(progress)
        let page = Int(progress)
        let move = insetRect.width / 2

        let rightInset = move * CGFloat(progress - left)
        let rightRect = insetRect.insetBy(dx: rightInset, dy: rightInset)

        let leftInset = (1 - CGFloat(progress - left)) * move
        let leftRect = insetRect.insetBy(dx: leftInset, dy: leftInset)
        
        for (index, layer) in inactiveLayer.enumerated() {
            switch index {
            case page:
                hollowLayout(layer: layer,
                             insetRect: leftRect)
            case page + 1:
                 hollowLayout(layer: layer,
                              insetRect: rightRect)
                break
            default:
                 hollowLayout(layer: layer,
                              insetRect: insetRect)
                break
            }
        }
        currentIndex = Int(progress)
    }
    
    override func updateCurrentPage(_ pageIndex: Int) {
        guard pageIndex >= 0 ,
            pageIndex <= numberOfPages - 1,
            pageIndex != currentIndex
            else { return }
        
        
        let borderW: CGFloat = isInactiveHollow ? borderWidth : 0
        let insetRect = CGRect(x: 0,
                               y: 0,
                               width: actualDiameter,
                               height: actualDiameter).insetBy(dx: borderW, dy: borderW)
        let maxW = insetRect.width / 2
        
        
        for (index, layer) in inactiveLayer.enumerated() {
            if index == currentIndex {
                hollowLayout(layer: layer,
                              insetRect: insetRect,
                              coefficient: maxW,
                              maxW: nil)
                
            }else if index == pageIndex {
                hollowLayout(layer: layer,
                             insetRect: insetRect,
                             coefficient: 1,
                             maxW: maxW)
            }
        }
        currentIndex = pageIndex
    }

    override func inactiveHollowLayout() {
        updateProgress(CGFloat(currentIndex))
    }

    override func activeHollowLayout() {
        updateProgress(CGFloat(currentIndex))
    }

    // MARK: - -------------------------- Layout --------------------------
    override func layoutContentView() {
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        let width = CGFloat(numberOfPages) * (actualDiameter + columnSpacing) - columnSpacing
        let height = actualDiameter

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
    
    override func layoutInactiveIndicators() {
        
        var layerFrame = CGRect(x: 0,
                                y: 0,
                                width: actualDiameter,
                                height: actualDiameter)
        inactiveLayer.forEach() { layer in
            layer.cornerRadius = actualDiameter * 0.5
            layer.frame = layerFrame
            layerFrame.origin.x +=  actualDiameter + columnSpacing
        }
    }
}

extension JXPageControlFill {
    
    private func hollowLayout(layer: CALayer,
                      insetRect: CGRect,
                      coefficient: CGFloat,
                      maxW: CGFloat?) {
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.03)
        CATransaction.setCompletionBlock { [weak self] in
            guard let strongSelf = self else { return }
            
            
            if let maxW = maxW {
                let tempCoefficient = coefficient + 1
                if tempCoefficient <= maxW {
                    strongSelf.hollowLayout(layer: layer,
                                            insetRect: insetRect,
                                            coefficient: tempCoefficient,
                                            maxW: maxW)
                }
            }else {
                let tempCoefficient = coefficient - 1
                if tempCoefficient >= 0 {
                    strongSelf.hollowLayout(layer: layer,
                                            insetRect: insetRect,
                                            coefficient: tempCoefficient,
                                            maxW: nil)
                }
            }
            
        }
        
        let tempInsetRect = insetRect.insetBy(dx: coefficient,
                                              dy: coefficient)
        hollowLayout(layer: layer, insetRect: tempInsetRect)
        CATransaction.commit()
    }
    
    private func hollowLayout(layer: CALayer, insetRect: CGRect) {
        
        layer.sublayers?.forEach({ (sublayer) in
            sublayer.removeFromSuperlayer()
        })
        
        let mask = CAShapeLayer()
        mask.fillRule = kCAFillRuleEvenOdd
        let bounds = UIBezierPath(rect: layer.bounds)
        bounds.append(UIBezierPath(ovalIn: insetRect))
        mask.path = bounds.cgPath
        
        if !isInactiveHollow {
            layer.backgroundColor = inactiveColor.cgColor
            let backgroundLayer = CALayer()
            backgroundLayer.frame = layer.bounds
            backgroundLayer.backgroundColor = activeColor.cgColor
            backgroundLayer.cornerRadius = actualDiameter * 0.5
            layer.addSublayer(backgroundLayer)
            backgroundLayer.mask = mask
        }else {
            layer.backgroundColor = activeColor.cgColor
            layer.mask = mask
        }
    }
}

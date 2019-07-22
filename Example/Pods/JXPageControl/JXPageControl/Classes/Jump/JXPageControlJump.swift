//
//  JXPageControlJump.swift
//  JXPageControl
//
//  Created by 谭家祥 on 2019/6/7.
//

import UIKit

@IBDesignable open class JXPageControlJump: JXPageControlBase {
    
    override open func setBase() {
        super.setBase()
    }
    
    // MARK: - -------------------------- Custom property list --------------------------
    
    @IBInspectable public var isAnimation: Bool = true
    
    
    // MARK: - -------------------------- Update tht data --------------------------
    override func updateProgress(_ progress: CGFloat) {
        guard progress >= 0 ,
            progress <= CGFloat(numberOfPages - 1),
            let activeLayer = activeLayer
            else { return }
        
        CATransaction.setDisableActions(!isAnimation)
        
        let marginX = (maxIndicatorSize.width - activeSize.width) * 0.5
        let marginyY = (maxIndicatorSize.height - activeSize.height) * 0.5
        let marginW = (maxIndicatorSize.width - minIndicatorSize.width) * 0.5
        let x = progress * (maxIndicatorSize.width + columnSpacing) + marginX

        switch isAnimation {
        case true:
            let width = activeSize.width
                + (columnSpacing + marginW) * (abs(round(progress) - progress) * 2)
            let newFrame = CGRect(x: x,
                                  y: marginyY,
                                  width: width,
                                  height: activeSize.height)
            activeLayer.frame = newFrame
        case false:
            activeLayer.frame.origin.x = x
        }
        
        currentIndex = Int(progress)
        CATransaction.commit()
    }
    
    override func updateCurrentPage(_ pageIndex: Int) {
        guard pageIndex >= 0 ,
            pageIndex <= numberOfPages - 1,
            pageIndex != currentIndex,
            let activeLayer = activeLayer
            else { return }
        
        let marginX = (maxIndicatorSize.width - activeSize.width) * 0.5
        let activeLayerX = CGFloat(pageIndex) * (maxIndicatorSize.width + columnSpacing) + marginX
        let marginW = (maxIndicatorSize.width - minIndicatorSize.width) * 0.5
        
        if isAnimation {
            CATransaction.begin()
            CATransaction.setCompletionBlock {[weak self] in
                guard let strongSelf = self else { return }
                activeLayer.frame.size.width = strongSelf.activeSize.width
                activeLayer.frame.origin.x = activeLayerX
                
            }
            
            if  pageIndex < currentIndex {
                activeLayer.frame.origin.x = activeLayer.frame.origin.x - columnSpacing - marginW
            }
            
            CATransaction.begin()
            let width = activeSize.width + columnSpacing + marginW
            activeLayer.frame.size.width = width
            CATransaction.commit()
            
            CATransaction.commit()
            
        }else {
            CATransaction.begin()
            CATransaction.setCompletionBlock {[weak self] in
                guard let strongSelf = self else { return }
                activeLayer.frame.size.width = strongSelf.activeSize.width
                activeLayer.frame.origin.x = activeLayerX
            }
            activeLayer.frame.origin.x = activeLayer.frame.origin.x - 0.1
            CATransaction.begin()
            let width = activeSize.width
            activeLayer.frame.size.width = width
            CATransaction.commit()
            CATransaction.commit()
        }
        currentIndex = pageIndex
    }
    
    override func inactiveHollowLayout() {
        if isInactiveHollow {
            inactiveLayer.forEach { (layer) in
                layer.backgroundColor = UIColor.clear.cgColor
                layer.borderColor = inactiveColor.cgColor
                layer.borderWidth = 1
            }
        }else {
            inactiveLayer.forEach { (layer) in
                layer.backgroundColor = inactiveColor.cgColor
                layer.borderWidth = 0
            }
        }
    }
    
    
    override func activeHollowLayout() {
        if isActiveHollow {
            activeLayer?.backgroundColor = UIColor.clear.cgColor
            activeLayer?.borderColor = activeColor.cgColor
            activeLayer?.borderWidth = 1
        }else {
            activeLayer?.backgroundColor = activeColor.cgColor
            activeLayer?.borderWidth = 0
        }
    }
    
    // MARK: - -------------------------- Reset --------------------------
    
    override func resetActiveLayer() {
        activeLayer?.removeFromSuperlayer()
        activeLayer = CALayer()
        contentView.layer.addSublayer(activeLayer!)
    }
    
    // MARK: - -------------------------- Layout --------------------------
    override func layoutActiveIndicator() {
        
        if let activeLayer = activeLayer  {
            
            let x = (maxIndicatorSize.width - activeSize.width) * 0.5
            let y = (maxIndicatorSize.height - activeSize.height) * 0.5
            activeLayer.frame = CGRect(x: x,
                                       y: y,
                                       width: activeSize.width,
                                       height: activeSize.height)
            if activeLayer.frame.width > activeLayer.frame.height {
                activeLayer.cornerRadius = activeLayer.frame.height*0.5
            }else {
                activeLayer.cornerRadius = activeLayer.frame.width*0.5
            }
            activeHollowLayout()
        }
    }
    
    override func layoutInactiveIndicators() {
        let x = (maxIndicatorSize.width - inactiveSize.width) * 0.5
        let y = (maxIndicatorSize.height - inactiveSize.height) * 0.5
        var layerFrame = CGRect(x: x,
                                y: y,
                                width: inactiveSize.width,
                                height: inactiveSize.height)
        inactiveLayer.forEach() { layer in
            layer.frame = layerFrame
            /// Set cornerRadius
            if layer.frame.width > layer.frame.height {
                layer.cornerRadius = layer.frame.height*0.5
            }else {
                layer.cornerRadius = layer.frame.width*0.5
            }
            layerFrame.origin.x +=  maxIndicatorSize.width + columnSpacing
        }
        inactiveHollowLayout()
    }
}

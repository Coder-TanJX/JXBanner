//
//  JXPageControlExchange.swift
//  JXPageControl_Example
//
//  Created by 谭家祥 on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


@IBDesignable open class JXPageControlExchange: JXPageControlBase {

    // MARK: - -------------------------- Custom property list --------------------------

    private var inactiveOriginFrame: [CGRect] = []

    
    // MARK: - -------------------------- Update tht data --------------------------

    override func updateProgress(_ progress: CGFloat) {
        guard progress >= 0 ,
            progress <= CGFloat(numberOfPages - 1)
            else { return }
        
        let leftIndex = Int(floor(progress))
        let rightIndex = leftIndex + 1 > numberOfPages - 1 ? leftIndex : leftIndex + 1
        
        if leftIndex == rightIndex {
            
            CATransaction.setDisableActions(true)
            
            let marginX: CGFloat = maxIndicatorSize.width + columnSpacing
            
            // 活跃点布局
            let activeLayerX = (maxIndicatorSize.width - activeSize.width) * 0.5 + floor(progress) * marginX
            activeLayer?.frame = CGRect(x: activeLayerX,
                                        y: activeLayer?.frame.minY ?? 0,
                                        width: activeSize.width,
                                        height: activeSize.height)
            
            // 不活跃点布局
            for index in 0 ..< numberOfPages - 1 {

                var layerFrame: CGRect = inactiveOriginFrame[index]
                let layer = inactiveLayer[index]

                if index < Int(progress) {
                    layerFrame.origin.x -=  marginX
                    layer.frame = layerFrame
                }else if index > Int(progress) {
                    layer.frame = layerFrame
                }
            }
            
            CATransaction.commit()
            
            
        }else {
            
            CATransaction.setDisableActions(true)
            
            let marginX: CGFloat = maxIndicatorSize.width + columnSpacing
            
            // 活跃点布局
            let activeLayerX = (maxIndicatorSize.width - activeSize.width) * 0.5 + progress * marginX
            activeLayer?.frame = CGRect(x: activeLayerX,
                                        y: activeLayer?.frame.minY ?? 0,
                                        width: activeSize.width,
                                        height: activeSize.height)
            
            // 不活跃点布局
            for index in 0 ..< numberOfPages - 1 {
                
                var layerFrame: CGRect = inactiveOriginFrame[index]
                let layer = inactiveLayer[index]
                
                if index < Int(progress) {
                    layerFrame.origin.x -=  marginX
                    layer.frame = layerFrame
                }else if index > Int(progress) {
                    layer.frame = layerFrame
                }else {
                    let leftScare = progress - floor(progress)
                    layerFrame.origin.x =  layerFrame.origin.x - leftScare * marginX
                    layer.frame = layerFrame
                }
            }
            
            CATransaction.commit()
        }
    }
    
    override func updateCurrentPage(_ pageIndex: Int) {
        guard pageIndex >= 0 ,
            pageIndex <= numberOfPages - 1,
            pageIndex != currentIndex
            else { return }

        let marginX: CGFloat = maxIndicatorSize.width + columnSpacing
        
        // 活跃点布局
        let activeLayerX = (maxIndicatorSize.width - activeSize.width) * 0.5 + CGFloat(pageIndex) * marginX
        activeLayer?.frame = CGRect(x: activeLayerX,
                                    y: activeLayer?.frame.minY ?? 0,
                                    width: activeSize.width,
                                    height: activeSize.height)
        
        // 不活跃点布局
        for index in 0 ..< numberOfPages - 1 {
            
            var layerFrame: CGRect = inactiveOriginFrame[index]
            let layer = inactiveLayer[index]
            
            if index < pageIndex {
                layerFrame.origin.x -=  marginX
                layer.frame = layerFrame
            }else if index >=  pageIndex {
                layer.frame = layerFrame
            }
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
    
    override func resetInactiveLayer() {
        // clear data
        inactiveLayer.forEach() { $0.removeFromSuperlayer() }
        inactiveLayer = [CALayer]()
        inactiveOriginFrame = []
        // set new layers
        for _ in 0 ..< numberOfPages - 1 {
            let layer = CALayer()
            contentView.layer.addSublayer(layer)
            inactiveLayer.append(layer)
        }
    }
    
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
        inactiveOriginFrame = []
        let x = (maxIndicatorSize.width - inactiveSize.width) * 0.5
        let y = (maxIndicatorSize.height - inactiveSize.height) * 0.5
        var layerFrame = CGRect(x: x + maxIndicatorSize.width + columnSpacing,
                                y: y,
                                width: inactiveSize.width,
                                height: inactiveSize.height)
        inactiveLayer.forEach() { layer in
            layer.frame = layerFrame
            inactiveOriginFrame.append(layerFrame)
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

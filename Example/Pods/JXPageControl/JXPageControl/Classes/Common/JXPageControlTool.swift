//
//  JXPageControlTool.swift
//  JXPageControl_Example
//
//  Created by 谭家祥 on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor {

    private static func rgbArray(color: UIColor) -> [CGFloat] {

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0

        if self.responds(to: #selector(getRed(_:green:blue:alpha:))) {
            color.getRed(&r, green: &g, blue: &b, alpha: &a)
        }else {
            
            if let components = color.cgColor.components {
                if components.count == 2 {
                    r = components[0]
                    g = components[0]
                    b = components[0]
                    a = components[1]
                }else if components.count == 4 {
                    r = components[0]
                    g = components[1]
                    b = components[2]
                    a = components[3]
                }else {
                    print("获取颜色RGB失败")
                }
            }
        }
        
        return [r, g ,b , a]
    }

    private static func difference(originColor: UIColor,
                          targetColor: UIColor) -> [CGFloat] {
        let originArr = self.rgbArray(color: originColor)
        let targetArr = self.rgbArray(color: targetColor)
        return [targetArr[0] - originArr[0],
                targetArr[1] - originArr[1],
                targetArr[2] - originArr[2],
                targetArr[3] - originArr[3]]
    }
    
    /**
     *  Pass in two colors and proportions
     *
     *  @param originColor            Original color
     *  @param targetColor            Target color
     *  @param proportion           Between 0 and 1
     *
     *  @return UIColor
     */
    static func transform(originColor: UIColor,
                          targetColor: UIColor,
                          proportion: CGFloat) -> UIColor {
        let originArr = self.rgbArray(color: originColor)
        let differenceArr = self.difference(originColor: originColor,
                                        targetColor: targetColor)
        return UIColor(red: originArr[0] + proportion * differenceArr[0] ,
                       green: originArr[1] + proportion * differenceArr[1],
                       blue: originArr[2] + proportion * differenceArr[2],
                       alpha: originArr[3] + proportion * differenceArr[3])
    }
}


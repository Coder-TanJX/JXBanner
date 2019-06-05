//
//  JXPageControl.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/// 主题颜色
let THEME_COLOR = UIColor(
    red: 249.0 / 255.0,
    green: 88.0 / 255.0,
    blue: 98.0 / 255.0,
    alpha: 1.0
)
/// 更浅灰色 #CCCCCC
let MORE_LIGHT_GRAY = UIColor(white: 204.0 / 255.0, alpha: 1.0)

let kMinGap: CGFloat = 5
let kHighlitedWidth: CGFloat = 15
let kHeight: CGFloat = 4
let kSideMargin: CGFloat = 3
let kMinWidth: CGFloat = 4

class JXBannerPageControl: UIView, JXBannerPageControlType {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var numberOfPages: Int = 0 {
        didSet {
            isHidden = (numberOfPages <= 0) || (hidesForSinglePage && numberOfPages == 1)
            
            if numberOfPages > labels.count {
                for _ in labels.count..<numberOfPages {
                    let label = UILabel()
                    label.layer.cornerRadius = kHeight / 2
                    label.layer.masksToBounds = true
                    labels.append(label)
                    addSubview(label)
                    label.backgroundColor = pageIndicatorTintColor
                }
            } else if numberOfPages < labels.count {
                for i in (numberOfPages..<labels.count).reversed() {
                    labels[i].removeFromSuperview()
                    labels.remove(at: i)
                }
            }
            if numberOfPages != oldValue {
                let oldCenter = self.center
                bounds.size = size(forNumberOfPages: numberOfPages)
                center = oldCenter
                setNeedsLayout()
                layoutIfNeeded()
            }
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            guard 0..<labels.count ~= currentPage,
                0..<numberOfPages ~= currentPage,
                0..<labels.count ~= oldValue,
                0..<numberOfPages ~= oldValue else { return }
            
            labels[oldValue].backgroundColor = pageIndicatorTintColor
            labels[currentPage].backgroundColor = currentPageIndicatorTintColor
            
            if currentPage > oldValue {
                let x = labels[currentPage].frame.origin.x
                self.labels[self.currentPage].frame = CGRect(
                    x: x,
                    y: 0,
                    width: kHighlitedWidth,
                    height: kHeight
                )
                labels[oldValue].frame.size.width = kMinWidth
            } else if currentPage < oldValue {
                self.labels[self.currentPage].frame.size.width = kHighlitedWidth
                labels[oldValue].frame.origin.x += (kHighlitedWidth - kMinWidth)
                labels[oldValue].frame.size.width = kMinWidth
            }
            
        }
    }
    
    var hidesForSinglePage: Bool = false {
        didSet {
            isHidden = (numberOfPages <= 0) || (hidesForSinglePage && numberOfPages == 1)
        }
    }
    
    var pageIndicatorTintColor: UIColor? = MORE_LIGHT_GRAY {
        didSet {
            for (index, label) in labels.enumerated() {
                if index == currentPage {
                    continue
                }
                label.backgroundColor = pageIndicatorTintColor
            }
        }
    }
    
    var currentPageIndicatorTintColor: UIColor? = THEME_COLOR {
        didSet {
            guard 0..<labels.count ~= currentPage, 0..<numberOfPages ~= currentPage else { return }
            labels[currentPage].backgroundColor = currentPageIndicatorTintColor
        }
    }
    
    private var labels: [UILabel] = [UILabel]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var x = kSideMargin
        for (i, label) in labels.enumerated() {
            label.frame = CGRect(
                x: x,
                y: 0,
                width: (i == currentPage) ? kHighlitedWidth : kMinWidth,
                height: kHeight
            )
            x += label.frame.size.width + kMinGap
        }
    }
    
    override var frame: CGRect {
        set {
            let size = self.size(forNumberOfPages: numberOfPages)
            super.frame = CGRect(
                x: frame.origin.x,
                y: frame.origin.y,
                width: size.width,
                height: size.height
            )
        }
        get {
            return super.frame
        }
    }
    
    func size(forNumberOfPages pageCount: Int) -> CGSize {
        if pageCount <= 0 {
            return CGSize.zero
        }
        let width = kHighlitedWidth
            + CGFloat(pageCount - 1) * (kMinWidth + kMinGap)
            + 2 * kSideMargin
        return CGSize(
            width: width,
            height: kHeight
        )
    }

}

//
//  JXBannerCustomPageControl.swift
//  JXBanner_Example
//
//  Created by 谭家祥 on 2019/6/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class JXBannerCustomPageControl: UIPageControl, JXBannerPageControlType {

    var activeImage: UIImage?
    var inactiveImage: UIImage?
    var activeImageSize: CGSize?
    var inactiveImageSize: CGSize?

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isUserInteractionEnabled = false
    }
    
    override var currentPage: Int {
        didSet { updateItems() }
    }
    
    func updateItems() {
        for index: Int in 0 ..< self.subviews.count {
            let item: UIImageView = self.item(view: subviews[index], currentIndex: index)
            if index == currentPage {
                item.image = activeImage
                item.frame.size = activeImageSize ?? subviews[index].frame.size
            }else {
                item.image = inactiveImage
                item.frame.size = inactiveImageSize ?? subviews[index].frame.size
            }
        }
    }
    
    func item(view: UIView, currentIndex: Int) -> UIImageView {
        var imageView: UIImageView? = nil
        if view.isKind(of: UIView.self) {
            for subView in view.subviews {
                if subView.isKind(of: UIImageView.self) {
                    imageView = subView as? UIImageView
                    break
                }
            }
            if imageView == nil {
                imageView = UIImageView(frame: view.bounds)
                view.addSubview(imageView!)
            }
        }else {
            imageView = view as? UIImageView
        }
        
        return imageView!
    }
}





//
//  ViewController.swift
//  JXBanner
//
//  Created by Code_TanJX on 05/10/2019.
//  Copyright (c) 2019 Code_TanJX. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
 
    lazy var banner: JXBanner = {
        let banner = JXBanner(frame: CGRect(x: 0,
                                            y: 100,
                                            width: view.frame.size.width,
                                            height: 200))
        banner.backgroundColor = UIColor.black
        banner.delegate = self
        banner.dataSource = self
        return banner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(banner)
    }
}

//MARK:- JXBannerDataSource
extension ViewController: JXBannerDataSource {
    
    /// Register the bannerCell and reuseIdentifier
    public func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {
            return JXBannerCellRegister(type: JXBannerCell.self,
                                        reuseIdentifier: "JXBannerCell")
    }
    
    /// How many pages does banner View have?
    public func jxBanner(numberOfItems banner: JXBannerType)
        -> Int {
            return 3
    }
    
    /// Set the closure of the banner item information
    public func jxBanner(_ banner: JXBannerType,
                             cellForItemAt index: Int,
                             cell: JXBannerBaseCell)
        -> JXBannerBaseCell {
            let tempCell: JXBannerCell = cell as! JXBannerCell
            tempCell.backgroundColor = UIColor.red
            tempCell.layer.masksToBounds = true
            tempCell.layer.borderColor = UIColor.yellow.cgColor
            tempCell.layer.borderWidth = 1
            tempCell.imageView.image = UIImage(named: "banner_placeholder")
            tempCell.descriptionLabel.text = String(index)+"是打发斯蒂芬坚实的金凤凰"
            return tempCell
    }
    
    /// Set the closure of the banner layout Params
    public func jxBanner(_ banner: JXBannerType,
                             params: JXBannerParams)
        -> JXBannerParams {
            return params
                .timeInterval(1)
                .isAutoPlay(true)
                .isCycleChain(true)
    }
    
    /// Set the closure of the banner layout Params
    public func jxBanner(_ banner: JXBannerType,
                             layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
            return layoutParams
                .layoutType(JXBannerTransformLinear())
                .itemSize(CGSize(width: 300, height: 200))
                .itemSpacing(0)
    }
    
    func jxBanner(pageControl banner: JXBannerType,
                  numberOfPages: Int,
                  contentView: UIView)
        -> (UIView & JXBannerPageControlType)? {
            let pageControl: JXBannerSystemPageControl = JXBannerSystemPageControl()
//            pageControl.activeImageSize = CGSize(width: 20, height: 10)
//            pageControl.inactiveImageSize = CGSize(width: 10, height: 10)
//            let active: UIImage = UIImage(named: "active") ?? UIImage()
//            let inactive: UIImage = UIImage(named: "inactive") ?? UIImage()
//            pageControl.activeImage = active
//            pageControl.inactiveImage = inactive
            pageControl.numberOfPages = numberOfPages
            banner.addSubview(pageControl)
            pageControl.snp.makeConstraints { (make) in
                make.left.right.bottom.equalTo(contentView)
                make.height.equalTo(20)
            }
            pageControl.currentPageIndicatorTintColor = UIColor(
                red: 85.0/255.0,
                green: 190.0/255.0,
                blue: 1.0,
                alpha: 1.0
            )
            pageControl.pageIndicatorTintColor = .white
    
            return pageControl
    }
}

//MARK:- JXBannerDelegatez
extension ViewController: JXBannerDelegate {
    
    /// This is a call-back to select banner item
    public func jxBanner(_ banner: JXBannerType,
                             didSelectItemAt index: Int) {
        print(index)
    }
    
    func jxBanner(_ banner: JXBannerType, contentView: UIView) {
        let label: UILabel = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        label.text = "1111111111111111"
        contentView.addSubview(label)
    }
    
}

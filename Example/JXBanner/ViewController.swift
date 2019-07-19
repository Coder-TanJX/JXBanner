//
//  ViewController.swift
//  JXBanner
//
//  Created by Code_TanJX on 05/10/2019.
//  Copyright (c) 2019 Code_TanJX. All rights reserved.
//

import UIKit
import SnapKit
import JXPageControl

class ViewController: UIViewController {
 
    lazy var banner: JXBanner = {
        let banner = JXBanner()
        banner.snp.makeConstraints { (maker) in
            maker.left.right.equalTo(view)
            maker.height.equalTo(200)
            maker.top.equalTo(view.snp_top).offset(100)
        }
        banner.delegate = self
        banner.dataSource = self
        return banner
    }()
    
    lazy var pageControl: JXPageControlJump = {
        let pageControl = JXPageControlJump()
        pageControl.snp.makeConstraints { (maker) in
            maker.left.right.bottom.equalTo(banner)
            maker.height.equalTo(20)
        }
        pageControl.contentMode = .bottom
        pageControl.activeSize = CGSize(width: 20, height: 8)
        pageControl.inactiveSize = CGSize(width: 8, height: 8)
        pageControl.columnSpacing = 0
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(banner)
        banner.addSubview(pageControl)

        self.automaticallyAdjustsScrollViewInsets = false
        //TODO:- 未做边界保护
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
            pageControl.numberOfPages = 3
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
                .cycleWay(.rollingBack)
    }
    
    /// Set the closure of the banner layout Params
    public func jxBanner(_ banner: JXBannerType,
                             layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
            return layoutParams
                .layoutType(JXBannerTransformCoverflow())
                .itemSize(CGSize(width: 250, height: 200))
                .itemSpacing(0)
    }
    
    func jxBanner(pageControl banner: JXBannerType,
                  numberOfPages: Int,
                  contentView: UIView)
        -> (UIView & JXBannerPageControlType)? {

            return nil
    }
}

//MARK:- JXBannerDelegatez
extension ViewController: JXBannerDelegate {
    
    /// This is a call-back to select banner item
    public func jxBanner(_ banner: JXBannerType,
                             didSelectItemAt index: Int) {
        print(index)
    }
    
    func jxBanner(_ banner: JXBannerType,
                  center index: Int) {
        pageControl.currentPage = index
    }
    
    func jxBanner(_ banner: JXBannerType, contentView: UIView) {
        let label: UILabel = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 15)
        label.text = "JXBanner"
        contentView.addSubview(label)
    }
    
}

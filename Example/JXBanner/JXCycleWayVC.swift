//
//  JXCycleWayVC.swift
//  JXBanner_Example
//
//  Created by Coder_TanJX on 2019/8/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import SnapKit
import JXBanner
import JXPageControl

class JXCycleWayVC: UIViewController {
    
    var pageCount = 5
    
    lazy var linearBanner: JXBanner = {[weak self] in
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.indentify = "linearBanner"
        banner.delegate = self
        banner.dataSource = self
        return banner
        }()
    
    lazy var converflowBanner: JXBanner = {
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.indentify = "converflowBanner"
        banner.delegate = self
        banner.dataSource = self
        return banner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(linearBanner)
        view.addSubview(converflowBanner)
        linearBanner.snp.makeConstraints {(maker) in
            maker.left.right.equalTo(view)
            maker.height.equalTo(150)
            maker.top.equalTo(view.snp_top).offset(100)
        }
        
        converflowBanner.snp.makeConstraints {(maker) in
            maker.left.right.height.equalTo(linearBanner)
            maker.top.equalTo(linearBanner.snp_bottom).offset(100)
        }
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    deinit {
        print("\(#function) ----------> \(#file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? #file)")
    }
}

//MARK:- JXBannerDataSource
extension JXCycleWayVC: JXBannerDataSource {
    
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {
            
            if banner.indentify == "linearBanner" {
                return JXBannerCellRegister(type: JXBannerCell.self,
                                            reuseIdentifier: "LinearBannerCell")
            }else {
                return JXBannerCellRegister(type: JXBannerCell.self,
                                            reuseIdentifier: "ConverflowBannerCell")
            }
    }
    
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int { return pageCount }
    
    func jxBanner(_ banner: JXBannerType,
                  cellForItemAt index: Int,
                  cell: UICollectionViewCell)
        -> UICollectionViewCell {
            let tempCell = cell as! JXBannerCell
            tempCell.layer.cornerRadius = 8
            tempCell.layer.masksToBounds = true
            if banner.indentify == "linearBanner" {
                tempCell.imageView.image = UIImage(named: "\(index).jpg")
            }else if banner.indentify == "converflowBanner" {
                tempCell.imageView.image = UIImage(named: "\(index+5).jpg")
            }
            
            tempCell.msgLabel.text = String(index) + "---来喽来喽,他真的来喽~"
            return tempCell
    }
    
    func jxBanner(_ banner: JXBannerType,
                  params: JXBannerParams)
        -> JXBannerParams {
            
            if banner.indentify == "linearBanner" {
                return params
                    .timeInterval(2)
                    .cycleWay(.rollingBack)
            }else {
                return params
                    .timeInterval(3)
                    .cycleWay(.skipEnd)
            }
    }
    
    func jxBanner(_ banner: JXBannerType,
                  layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
            
            if banner.indentify == "linearBanner" {
                return layoutParams
                    .layoutType(JXBannerTransformLinear())
                    .itemSize(CGSize(width: 250, height: 150))
                    .itemSpacing(10)
                    .minimumAlpha(0.8)
            }else {
                return layoutParams
                    .layoutType(JXBannerTransformCoverflow())
                    .itemSize(CGSize(width: 300, height: 150))
                    .itemSpacing(0)
                    .minimumAlpha(0.8)
            }
    }
    
    func jxBanner(pageControl banner: JXBannerType,
                  numberOfPages: Int,
                  coverView: UIView,
                  builder: JXBannerPageControlBuilder) -> JXBannerPageControlBuilder {
        
        if banner.indentify == "linearBanner" {
            let pageControl = JXPageControlScale()
            pageControl.contentMode = .bottom
            pageControl.activeSize = CGSize(width: 15, height: 6)
            pageControl.inactiveSize = CGSize(width: 6, height: 6)
            pageControl.activeColor = UIColor.red
            pageControl.inactiveColor = UIColor.lightGray
            pageControl.columnSpacing = 0
            pageControl.isAnimation = true
            builder.pageControl = pageControl
            builder.layout = {
                pageControl.snp.makeConstraints { (maker) in
                    maker.left.right.equalTo(coverView)
                    maker.top.equalTo(coverView.snp_bottom).offset(10)
                    maker.height.equalTo(20)
                }
            }
            return builder
            
        }else {
            let pageControl = JXPageControlExchange()
            pageControl.contentMode = .bottom
            pageControl.activeSize = CGSize(width: 15, height: 6)
            pageControl.inactiveSize = CGSize(width: 6, height: 6)
            pageControl.activeColor = UIColor.red
            pageControl.inactiveColor = UIColor.lightGray
            pageControl.columnSpacing = 0
            builder.pageControl = pageControl
            builder.layout = {
                pageControl.snp.makeConstraints { (maker) in
                    maker.left.right.equalTo(coverView)
                    maker.top.equalTo(coverView.snp_bottom).offset(10)
                    maker.height.equalTo(20)
                }
            }
            return builder
        }
        
    }
    
}

//MARK:- JXBannerDelegate
extension JXCycleWayVC: JXBannerDelegate {
    
    public func jxBanner(_ banner: JXBannerType,
                         didSelectItemAt index: Int) {
        print(index)
    }
}



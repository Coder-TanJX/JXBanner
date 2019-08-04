//
//  JXDefaultVC.swift
//  JXBanner_Example
//
//  Created by 谭家祥 on 2019/7/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import JXBanner

class JXDefaultVC: UIViewController {
    
    var pageCount = 5
    
    lazy var banner: JXBanner = {
        let banner = JXBanner()
        banner.backgroundColor = UIColor.black
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.delegate = self
        banner.dataSource = self
        return banner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(banner)
        banner.snp.makeConstraints { (maker) in
            maker.left.right.equalTo(view)
            maker.height.equalTo(250)
            maker.top.equalTo(view.snp_top).offset(100)
        }
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    deinit {
        print("\(#function) ----------> \(#file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? #file)")
    }
}

//MARK:- JXBannerDataSource
extension JXDefaultVC: JXBannerDataSource {
    
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {
            return JXBannerCellRegister(type: JXBannerCell.self,
                                        reuseIdentifier: "JXDefaultVCCell")
    }
    
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int { return pageCount }
    
    func jxBanner(_ banner: JXBannerType,
                  cellForItemAt index: Int,
                  cell: JXBannerBaseCell)
        -> JXBannerBaseCell {
            let tempCell: JXBannerCell = cell as! JXBannerCell
            tempCell.layer.cornerRadius = 8
            tempCell.layer.masksToBounds = true
            tempCell.imageView.image = UIImage(named: "banner_placeholder")
            tempCell.msgLabel.text = String(index) + "---来喽来喽,他真的来喽~"
            return tempCell
    }
    
    func jxBanner(_ banner: JXBannerType,
                  layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
        return layoutParams
            .itemSize(CGSize(width: UIScreen.main.bounds.width - 40, height: 200))
            .itemSpacing(20)
    }
}

//MARK:- JXBannerDelegate
extension JXDefaultVC: JXBannerDelegate {
    
    public func jxBanner(_ banner: JXBannerType,
                         didSelectItemAt index: Int) {
        print(index)
    }
    
}

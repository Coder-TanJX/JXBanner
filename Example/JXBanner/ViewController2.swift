//
//  ViewController2.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/6/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {


    @IBOutlet weak var banner: JXTestBanner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        banner.backgroundColor = UIColor.black
        banner.delegate = self
        banner.dataSource = self
    }

}

//MARK:- JXBannerDataSource
extension ViewController2: JXBannerDataSource {
    
    public func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {
            return JXBannerCellRegister(type: JXBannerCell.self,
                                        reuseIdentifier: "JXBannerCell")
    }
    
    /// How many pages does banner View have?
    public func jxBanner(numberOfItems banner: JXBannerType)
        -> Int {
            return 10
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
}

//MARK:- JXBannerDelegatez
extension ViewController2: JXBannerDelegate {
    
    /// This is a call-back to select banner item
    public func jxBanner(_ banner: JXBannerType,
                         didSelectItemAt index: Int) {
        print(index)
    }
    
}

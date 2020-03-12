//
//  JXMiddleTargetVC.swift
//  JXBanner_Example
//
//  Created by tjx on 2020/1/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import JXBanner

class JXMiddleTargetVC: UIViewController {
    
    @IBOutlet weak var banner: JXBanner!
    var pageCount = 5
    let videoItems = [
        "http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4",
        "http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4",
        "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4",
        "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4",
        "http://vfx.mtime.cn/Video/2019/03/18/mp4/190318214226685784.mp4",
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.delegate = self
        banner.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    deinit {
        print("\(#function) ----------> \(#file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? #file)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        banner.reloadView()
    }
}

//MARK:- JXBannerDataSource
extension JXMiddleTargetVC: JXBannerDataSource {
    
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {
            return JXBannerCellRegister(type: nil,
                                        reuseIdentifier: "JXMiddleTargetCell",
                                        nib: UINib(nibName: "JXMiddleTargetCell", bundle: Bundle.main))
    }
    
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int { return pageCount }
    
    func jxBanner(_ banner: JXBannerType,
                  cellForItemAt index: Int,
                  cell: UICollectionViewCell)
        -> UICollectionViewCell {
            let tempCell = cell as! JXMiddleTargetCell
            tempCell.layer.cornerRadius = 8
            tempCell.layer.masksToBounds = true
            tempCell.imageView.image = UIImage(named: "mp4_\(index).jpg")
            return tempCell
    }
    
    func jxBanner(_ banner: JXBannerType,
                  params: JXBannerParams) -> JXBannerParams {
        return params
        .isAutoPlay(false)
    }
    
    func jxBanner(_ banner: JXBannerType,
                  layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
            return layoutParams
                .itemSize(CGSize(width: 300, height: 150))
                .itemSpacing(20)
                .layoutType(JXBannerTransformLinear())
    }
    
    func jxBanner(_ banner: JXBannerType,
                  centerIndex: Int,
                  centerCell: UICollectionViewCell) {
        
        if let cell = centerCell as? JXMiddleTargetCell {
            cell.layer.borderColor = UIColor.red.cgColor
            cell.layer.borderWidth = 2
            cell.imageView.image = UIImage(named: "mp4_\(centerIndex).jpg")
            cell.play(videoItems[centerIndex])
        }
    }
    
    func jxBanner(_ banner: JXBannerType,
                  lastCenterIndex: Int?,
                  lastCenterCell: UICollectionViewCell?) {
        
        if let cell = lastCenterCell as? JXMiddleTargetCell,
            let index = lastCenterIndex {
            cell.layer.borderWidth = 0
            cell.imageView.image = UIImage(named: "mp4_\(index).jpg")
            cell.stop()
        }
    }
}

//MARK:- JXBannerDelegate
extension JXMiddleTargetVC: JXBannerDelegate {
    
    public func jxBanner(_ banner: JXBannerType,
                         didSelectItemAt index: Int) {
        print(index)
    }
    
    func jxBanner(_ banner: JXBannerType, center index: Int) {
        print(index)
    }
    
    
    
}

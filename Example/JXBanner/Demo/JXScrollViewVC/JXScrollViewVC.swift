//
//  JXScrollViewVC.swift
//  JXBanner_Example
//
//  Created by 谭家祥 on 2019/11/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import JXBanner
import UIKit

class JXScrollViewVC: UIViewController {

  @IBOutlet weak var scrollView: JXBanner!

  var pageCount = 15

  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.placeholderImageView.image = UIImage(named: "banner_placeholder")
    scrollView.delegate = self
    scrollView.dataSource = self

    self.automaticallyAdjustsScrollViewInsets = false
  }

  deinit {
    print(
      "\(#function) ----------> \(#file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? #file)"
    )
  }

}

//MARK:- JXBannerDataSource
extension JXScrollViewVC: JXBannerDataSource {

  func jxBanner(_ banner: JXBannerType)
    -> (JXBannerCellRegister)
  {
    return JXBannerCellRegister(
      type: nil,
      reuseIdentifier: "JXScrollViewCell",
      nib: UINib(nibName: "JXScrollViewCell", bundle: Bundle.main))
  }

  func jxBanner(numberOfItems banner: JXBannerType)
    -> Int
  { return pageCount }

  func jxBanner(
    _ banner: JXBannerType,
    cellForItemAt index: Int,
    cell: UICollectionViewCell
  )
    -> UICollectionViewCell
  {
    if let tempCell = cell as? JXScrollViewCell {
      tempCell.imgView.image = UIImage(named: "\(index).jpg")
      tempCell.title.text = String(index) + "---来喽来喽,他真的来喽~"
      tempCell.detail.text = String(index) + "---哟哟哦哟哟哟哟哟哟哟哟~"
    }
    return cell
  }

  func jxBanner(
    _ banner: JXBannerType,
    params: JXBannerParams
  ) -> JXBannerParams {
    return
      params
      .isAutoPlay(false)
      .isShowPageControl(false)
      .isPagingEnabled(false)
      .cycleWay(.rollingBack)
      .contentInset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
  }

  func jxBanner(
    _ banner: JXBannerType,
    layoutParams: JXBannerLayoutParams
  )
    -> JXBannerLayoutParams
  {
    return
      layoutParams
      .itemSize(CGSize(width: 150, height: 160))
      .itemSpacing(10)
  }
}

//MARK:- JXBannerDelegate
extension JXScrollViewVC: JXBannerDelegate {

  public func jxBanner(
    _ banner: JXBannerType,
    didSelectItemAt index: Int
  ) {
    print(index)
  }

}

# JXBanner

[![CI Status](https://img.shields.io/travis/Code_TanJX/JXBanner.svg?style=flat)](https://travis-ci.org/Code_TanJX/JXBanner)
[![Version](https://img.shields.io/cocoapods/v/JXBanner.svg?style=flat)](https://cocoapods.org/pods/JXBanner)
[![License](https://img.shields.io/cocoapods/l/JXBanner.svg?style=flat)](https://cocoapods.org/pods/JXBanner)
[![Platform](https://img.shields.io/cocoapods/p/JXBanner.svg?style=flat)](https://cocoapods.org/pods/JXBanner)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JXBanner is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JXBanner'
```



##### (JXBanner supports multiple animation transformations, content layout transformations, and Xib layouts, The framework relies on JXPageConytrol and contains many custom interfaces, such as transition animation, view structure, and Settings ) 

---

##### 

* Development environment: Xcode 7 
* Running condition: iOS(8.0+) 
* Open source framework ：[github地址](https://github.com/Code-TanJX/JXPageControl)
* [ Chinese is introduced [ 中文介绍 ]](https://blog.csdn.net/TanJiaXiang/article/details/95796616)

&nbsp;

（If there is any problem, you can leave a message, welcome to study together, welcome star ）

---

### Installation
To install, simply add the following code to your Podfile   : 

```ruby

platform :ios, '8.0'

target 'TargetName' do
pod 'JXPageControl'
end

```

---


##### (JXBanner 支持多种动画变换, 支持纯代码布局和Xib布局)

JXBanner依赖于JXPageConytrol，并包含许多自定义接口，如转换动画、视图结构和设置

---

##### 

* 1.    开发环境: Xcode 7
* 2.    运行条件: iOS(8.0+)
* 开源框架：[github地址](https://github.com/Coder-TanJX/JXBanner)

&nbsp;

（如果使用有什么问题，可以留言，欢迎一起学习，欢迎star）

--- 
### Installation  [安装]
安装，只需将以下面代码添加到您的Podfile:

```ruby

platform :ios, '8.0'

target 'TargetName' do
pod 'JXBanner'
end

```

---

### UI效果

* default

不需要设置JXBanner -> JXBannerLayoutParams

![default.gif](https://upload-images.jianshu.io/upload_images/17645677-9616d01a4b270429.gif?imageMogr2/auto-orient/strip)

---

* JXBannerTransformLinear

![linear.gif](https://upload-images.jianshu.io/upload_images/17645677-3b932a5a58762e8d.gif?imageMogr2/auto-orient/strip)

--- 

* JXBannerTransformCoverflow

![coverflow.gif](https://upload-images.jianshu.io/upload_images/17645677-bf3f25be2c12439a.gif?imageMogr2/auto-orient/strip)

---

* custom

需要实现JXBannerTransformable协议, 修改 UICollectionViewLayoutAttributes -> transform3D 或 transform 属性

![custom.gif](https://upload-images.jianshu.io/upload_images/17645677-c8cb75cf07c4a719.gif?imageMogr2/auto-orient/strip)

---

### Frame set [框架集合]

&nbsp;

###### Banner 轮播图框架公用类文件
* API  ---> 开发者可以调用的所有接口
* Cell  ---> 框架提供cell基类 （如果想自定义cell内容, 可以新建cell继承于JXBannerBaseCell）
* Common ---> 框架公用类文件
* Transform ---> 动画效果类文件 ( 如果框架提供的动画效果不能满足开发者需求, 可以新建实现[JXBannerTransformable]()协议的struct/class, 修改 UICollectionViewLayoutAttributes -> transform3D 或 transform 属性）

###### PageControl    指示器类文件
* JXBannerPageControlBuilder ---> pageControl的构建者类
* JXBannerPageControlDefault --->  框架默认的pageControl样式 (可以通过实现JXBannerDataSource -> 【jxBanner(pageControl banner: numberOfPages: coverView: builder:) -> JXBannerPageControlBuilder】协议方法修改样式)

---

### JXBanner 重要文件介绍

&nbsp;

##### JXBannerParams 【banner 属性】

* isAutoPlay ---> 自动播放
* isBounces ---> 边界能否越界滑动
* timeInterval ---> 播放调度间隔
* isShowPageControl ---> 是否加载内部指示器（[JXPageControl（框架特色）](https://github.com/Coder-TanJX/JXPageControl)）
* cycleWay ---> [轮播方式（框架特色）]() （forward：无线向右播放， skipEnd：首尾自定义动画跳转， rollingBack：左右回滚模式）
* edgeTransitionType ---> cycleWay 使用 skipEnd 中 可以选取动画方式
* edgeTransitionSubtype ---> cycleWay 使用 skipEnd 中 可以选取动画方式

---

##### JXBannerLayoutParams 【banner布局、动画属性】

* itemSize ---> cell大小。
* itemSpacing --->cell左右边距。
* layoutType ---> 动画效果[JXBannerTransformable（框架特色）]()
* minimumScale ---> cell 缩放系数。
* minimumAlpha ---> cell 透明度系数。
* maximumAngle ---> cell 旋转系数。
* rateOfChange ---> cell 变化系数。
* rateHorisonMargin ---> cell 水平间距调整系数。

---

##### JXBannerCellRegister 【cell注册构建者】

* type ---> 注册cell的类型，必须是JXBannerBaseCell的子类
* reuseIdentifier ---> cell重用标识

var type: JXBannerBaseCell.Type
var reuseIdentifier: String

---
###  JXBanner 使用 

&nbsp;

##### Example 1

* 默认实现示例

&nbsp;

```

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

    // 注册重用Cell标识
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {
            return JXBannerCellRegister(type: JXBannerCell.self,
            reuseIdentifier: "JXDefaultVCCell")
        }

    // 轮播总数
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int { return pageCount }

    // 轮播cell内容设置
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

    // banner基本设置（可选）
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

    // 点击cell回调
    public func jxBanner(_ banner: JXBannerType,
    didSelectItemAt index: Int) {
    print(index)
    }

}


```

---

##### Example 2

&nbsp;

* 个性化设置

```

import SnapKit
import JXBanner
import JXPageControl

class JXCustomVC: UIViewController {

    var pageCount = 5

    lazy var linearBanner: JXBanner = {[weak self] in
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.backgroundColor = UIColor.black
        banner.indentify = "linearBanner"
        banner.delegate = self
        banner.dataSource = self    
        return banner
    }()

    lazy var converflowBanner: JXBanner = {
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.backgroundColor = UIColor.black
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
            maker.height.equalTo(200)
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
extension JXCustomVC: JXBannerDataSource {

    // 注册重用Cell标识
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

    // 轮播总数
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int { return pageCount }

    // 轮播cell内容设置
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

    // banner基本设置（可选）
    func jxBanner(_ banner: JXBannerType,
        params: JXBannerParams)
        -> JXBannerParams {

        if banner.indentify == "linearBanner" {
            return params
                .timeInterval(2)
                .cycleWay(.forward)
        }else {
            return params
                .timeInterval(3)
                .cycleWay(.forward)
        }
    }

// banner布局、动画设置
    func jxBanner(_ banner: JXBannerType,   
        layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {

        if banner.indentify == "linearBanner" {
            return layoutParams
                .layoutType(JXBannerTransformLinear())
                .itemSize(CGSize(width: 250, height: 190))
                .itemSpacing(10)
                .rateOfChange(0.8)
                .minimumScale(0.7)
                .rateHorisonMargin(0.5)
                .minimumAlpha(0.8)
        }else {
            return layoutParams
                .layoutType(JXBannerTransformCoverflow())
                .itemSize(CGSize(width: 300, height: 190))
                .itemSpacing(0)
                .maximumAngle(0.25)
                .rateHorisonMargin(0.3)
                .minimumAlpha(0.8)
        }
    }

    // 自定义pageControl样式、布局
    //（基于jxPageControl, 如果不适用JXPageControl, 设置isShowPageControl = false， 内部pageControl将不会再次加载 ） 
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
extension JXCustomVC: JXBannerDelegate {

    // 点击cell回调
    public func jxBanner(_ banner: JXBannerType,
        didSelectItemAt index: Int) {
        print(index)
    }

    // 设置自定义覆盖View, 比如添加自定义外部pageControl和布局
    func jxBanner(_ banner: JXBannerType, coverView: UIView) {
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        title.text = "JXBanner"
        title.textColor = UIColor.red
        title.font = UIFont.systemFont(ofSize: 16)
        coverView.addSubview(title)
    }

    // 最中心显示cell 索引
    func jxBanner(_ banner: JXBannerType, center index: Int) {
        print(index)
    }
}

```

##### Example 3 

如果框架提供的动画效果不能满足开发者需求：

* 1. 轮播图动画样式开发者可以自定义实现， 只要是新建实现[JXBannerTransformable]()协议的struct/class, 修改 UICollectionViewLayoutAttributes -> transform3D 或 transform 属性）

```

//
//  JXCustomTransform.swift
//  JXBanner_Example
//
//  Created by 谭家祥 on 2019/7/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import JXBanner

struct JXCustomTransform: JXBannerTransformable {

    public func transformToAttributes(collectionView: UICollectionView,
        params: JXBannerLayoutParams,
        attributes: UICollectionViewLayoutAttributes) {

        let collectionViewWidth = collectionView.frame.width
        if collectionViewWidth <= 0 { return }

        let centetX = collectionView.contentOffset.x + collectionViewWidth * 0.5;
        let delta = abs(attributes.center.x - centetX)
        let calculateRate = 1 - delta / collectionViewWidth
        let angle = min(delta / collectionViewWidth * (1 - params.rateOfChange), params.maximumAngle)
        let alpha = max(calculateRate, params.minimumAlpha)


        applyCoverflowTransformToAttributes(viewCentetX: centetX,
            attributes: attributes,
            params: params,
            angle: angle,
            alpha: alpha,
            calculateRate: calculateRate)
    }

    func applyCoverflowTransformToAttributes(viewCentetX: CGFloat,
        attributes: UICollectionViewLayoutAttributes,
        params: JXBannerLayoutParams,
        angle: CGFloat,
        alpha: CGFloat,
        calculateRate: CGFloat) -> Void {
        var transform3D: CATransform3D = CATransform3DIdentity


        let location = JXBannerTransfrom.itemLocation(viewCentetX: viewCentetX,
        itemCenterX: attributes.center.x)

        var _angle = angle
        var _alpha = alpha
        var _translateX: CGFloat = 0
        var _translateY: CGFloat = 0
        attributes.zIndex = 0

        switch location {
        case .left:
            _angle = angle
            _translateX = 0.2 * attributes.size.width * (1 - calculateRate) / 4
            _translateY = 0.4 * attributes.size.height * (1 - calculateRate)


        case .right:
            _angle = -angle
            _translateX = -0.2 * attributes.size.width * (1 - calculateRate) / 4
            _translateY = 0.4 * attributes.size.height * (1 - calculateRate)

        case .center:
            _angle = 0
            _alpha = 1
            _translateY = 0
            attributes.zIndex = 10000
        }

        transform3D = CATransform3DTranslate(transform3D, _translateX, _translateY, 0)
        transform3D = CATransform3DRotate(transform3D, -CGFloat.pi * _angle, 0, 0, 1)
        attributes.alpha = _alpha
        attributes.transform3D = transform3D
    }

}


```

* 2. 设置自定义实现动画 

JXBannerDataSource -> 【jxBanner(_ banner: layoutParams: ) -> JXBannerLayoutParams】





```

// JXCustomTransform()

    func jxBanner(_ banner: JXBannerType,
        layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {

        return layoutParams
            .layoutType(JXCustomTransform())
    }

```

### 更多设置可以参考示例 [Demo地址](https://github.com/Code-TanJX/JXPageControl)






## Author

Code_TanJX, code_tanjx@163.com

## License

JXBanner is available under the MIT license. See the LICENSE file for more info.

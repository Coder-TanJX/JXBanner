//
//  JXBannerCell.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

open class JXBannerCell: JXBannerBaseCell {

    private let msgBGViewH: CGFloat = 24
    private let msgMargin: CGFloat = 10
    
    open override func jx_addSubviews() {
        super.jx_addSubviews()
        contentView.addSubview(msgBgView)
        msgBgView.addSubview(msgLabel)
    }
    
    public lazy var msgLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: msgMargin,
                             y: 0,
                             width: msgBgView.bounds.width - 2*msgMargin,
                             height: msgBgView.bounds.height)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        return label
    }()
    
    public lazy var msgBgView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0,
                            y: self.contentView.bounds.height - msgBGViewH,
                            width: self.contentView.bounds.width,
                            height: msgBGViewH)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.autoresizingMask = [
            .flexibleWidth,
            .flexibleTopMargin
        ]
        return view
    }()
}

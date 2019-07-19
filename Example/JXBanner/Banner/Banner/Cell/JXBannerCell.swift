//
//  JXBannerCell.swift
//  JXBanner_Example
//
//  Created by Code_JX on 2019/5/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class JXBannerCell: JXBannerBaseCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addsubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addsubviews() {
        contentView.addSubview(imageView)
        imageView.addSubview(descriptionLabel)
        backgroundColor = UIColor.yellow
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let desW = imageView.frame.size.width
        let desH = 24.0
        let desY = Double(imageView.bounds.maxY) - desH
        descriptionLabel.frame = CGRect(x: 20, y: desY, width: Double(desW - 40.0), height: desH)
    }
    
    
    // MARK:- Lazy loading Cell subView
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 9
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        return descriptionLabel
    }()
    
}

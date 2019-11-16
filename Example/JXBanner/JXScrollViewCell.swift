//
//  JXScrollViewCell.swift
//  JXBanner_Example
//
//  Created by 谭家祥 on 2019/11/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class JXScrollViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = 8
        imgView.layer.masksToBounds = true
        
    }

}

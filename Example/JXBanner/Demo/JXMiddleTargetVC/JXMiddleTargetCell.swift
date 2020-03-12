//
//  JXMiddleTargetCell.swift
//  JXBanner_Example
//
//  Created by tjx on 2020/1/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import AVKit

class JXMiddleTargetCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var player : AVPlayer!
    var palyerItem : AVPlayerItem!
    var bufferTimeLabel : UILabel!
    var playerLayer: AVPlayerLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func play(_ urlStr: String) {
        
        guard let url = NSURL(string: urlStr) as URL?  else {
            return
        }
        
        self.palyerItem = AVPlayerItem(url: url)
        //创建ACplayer：负责视频播放
        self.player = AVPlayer.init(playerItem: self.palyerItem)
        self.player.rate = 1.0//播放速度 播放前设置
        //创建显示视频的图层
        playerLayer = AVPlayerLayer.init(player: self.player)
        playerLayer?.videoGravity = .resizeAspect
        playerLayer?.frame = self.bgView.bounds
        playerLayer?.backgroundColor = UIColor.black.cgColor
        self.imageView.layer.addSublayer(playerLayer!)
        //播放
        self.player.play()
    }
    
    func stop() {
        self.player.pause()
        playerLayer?.removeFromSuperlayer()
    }

}

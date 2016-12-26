//
//  CollectionViewBeautyCell.swift
//  douyu
//
//  Created by qianjn on 2016/12/22.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

class CollectionViewBeautyCell: UICollectionViewCell {

    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UIButton!
    
    
    var anchor: Anchor? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online/1000))万人在线"
            } else {
                onlineStr = "\(anchor.online)人在线"
            }
            onlineLabel.text = onlineStr
            roomNameLabel.text = anchor.room_name
            cityLabel.setTitle(anchor.anchor_city, for: .normal)
            if let imageUrl = URL(string: anchor.vertical_src) {
                bgImageView.kf.setImage(with: imageUrl)
            }
            
            
            
            
        }
    }
    
    
    
}

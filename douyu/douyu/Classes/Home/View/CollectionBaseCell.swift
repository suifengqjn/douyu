//
//  CollectionBaseCell.swift
//  douyu
//
//  Created by qianjn on 2016/12/26.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
   
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
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
            onlineBtn.setTitle(onlineStr, for: .normal)
            roomNameLabel.text = anchor.room_name
            if let imageUrl = URL(string: anchor.vertical_src) {
                bgImageView.kf.setImage(with: imageUrl)
            }
            
            
            
            
        }
    }
}

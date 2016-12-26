//
//  CollectionViewNormalCell.swift
//  douyu
//
//  Created by qianjn on 2016/12/18.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewNormalCell: UICollectionViewCell {

    @IBOutlet weak var soureImageView: UIImageView!
    
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    @IBOutlet weak var omlineBtn: UIButton!
    
    
    public var anchor : Anchor? {
        didSet {
            guard let anc = anchor else {
                return
            }
            nickNameLabel.text = anc.nickname
            omlineBtn.setTitle("\(anc.online) 在线", for: .normal)
            roomNameLabel.text = anc.room_name
            
            guard let icon_URL = URL(string: anc.vertical_src) else { return }
            soureImageView.kf.setImage(with: icon_URL)
        }
    }
}

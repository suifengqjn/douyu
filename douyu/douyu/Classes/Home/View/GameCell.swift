//
//  GameCell.swift
//  douyu
//
//  Created by qianjn on 2017/1/1.
//  Copyright © 2017年 SF. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var game:GameModel? {
        didSet {
            guard let game = game else {
                return
            }
            titleLabel.text = game.tag_name
            
            if let url = URL(string: game.icon_url) {
                iconImage.kf.setImage(with: url)
            }
            
        }
    }
    

}

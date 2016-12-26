//
//  CollectionViewNormalCell.swift
//  douyu
//
//  Created by qianjn on 2016/12/18.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewNormalCell: CollectionBaseCell {

    @IBOutlet weak var nickNameLabel: UILabel!
    
    
    
    override var anchor: Anchor? {
        
        didSet {
            super.anchor = anchor
            
           nickNameLabel.text = anchor?.nickname
        }
        
    }
    
  
}

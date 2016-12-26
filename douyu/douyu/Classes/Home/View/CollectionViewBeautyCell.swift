//
//  CollectionViewBeautyCell.swift
//  douyu
//
//  Created by qianjn on 2016/12/22.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

class CollectionViewBeautyCell: CollectionBaseCell {

    

    @IBOutlet weak var cityLabel: UIButton!
    
    

    
       override var anchor: Anchor? {
        
        didSet {
            super.anchor = anchor
            
            
            cityLabel.setTitle(anchor?.anchor_city, for: .normal)
        }
        
    }
    
    
    
}

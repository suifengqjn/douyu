//
//  RecommendCycleCell.swift
//  douyu
//
//  Created by qianjn on 2016/12/31.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit
import Kingfisher
class RecommendCycleCell: UICollectionViewCell {

    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var descLabel: UILabel!
    
    
   public var cycle: CycleModel? {
        didSet {
            guard let cycle = cycle else {
                return
            }
            
            descLabel.text = cycle.title
            
            if let imageUrl = URL(string: cycle.pic_url) {
                bgImage.kf.setImage(with: imageUrl)
            }
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

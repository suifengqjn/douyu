//
//  CollectionHeader.swift
//  douyu
//
//  Created by qianjn on 2016/12/16.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

class CollectionHeader: UICollectionReusableView {

   
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    public var group :  AnchorGroup? {
        didSet {
            self.iconImage.image = UIImage(named: group?.icon_name ?? "home_header_normal")
            self.titlelabel.text = group?.tag_name
        }
    }
    
    
}


extension CollectionHeader {
    class func createHeadView() -> CollectionHeader {
        return (Bundle.main.loadNibNamed("CollectionHeader", owner: nil, options: nil)?.first as? CollectionHeader)!
    }
}

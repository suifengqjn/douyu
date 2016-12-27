//
//  CycleModel.swift
//  douyu
//
//  Created by qianjn on 2016/12/27.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    //标题
    var title: String = ""
    //图片
    var pic_url : String = ""
    // 主播信息对应的模型
    var anchor : Anchor?
    //主播信息
    var room : [String : NSObject]? {
        didSet {
            if let room = room {
                anchor = Anchor(dict: room)
            }
        }
    }
    
    
    init(dict:[String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

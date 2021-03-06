//
//  AnchorGroup.swift
//  douyu
//
//  Created by qianjn on 2016/12/25.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

class AnchorGroup: BaseModel {

    // MARK:- 定义属性
    var room_list: [[String : NSObject]]? {
        didSet {
            guard let roomList = room_list else {
                return
            }
            for dict in roomList {
                anchors.append(Anchor(dict: dict))
            }
        }
    }

    var icon_name: String = ""
    //主播模型对象数组
    lazy var anchors: [Anchor] = [Anchor]()
    
}

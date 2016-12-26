//
//  Anchor.swift
//  douyu
//
//  Created by qianjn on 2016/12/25.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

class Anchor: NSObject {
    
    //房间ID
    var room_id : Int = 0
    //房间图片
    var vertical_src: String = ""
    //房间名称
    var room_name: String = ""
    //直播方式 0:电脑直播 1：手机直播
    var isVertical: Int = 0
    //直播昵称
    var nickname: String = ""
    //在线人数
    var online : Int = 0
    // 主播所在城市
    var anchor_city : String = ""
    init(dict:[String :NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

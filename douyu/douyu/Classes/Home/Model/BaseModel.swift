//
//  BaseModel.swift
//  douyu
//
//  Created by qianjn on 2017/1/1.
//  Copyright © 2017年 SF. All rights reserved.
//

import UIKit

class BaseModel:NSObject {
    
    var icon_url: String = ""
    var tag_name: String = ""
    
    
    override init() {
        
    }
    
    init(dict:[String :NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}


//
//  NSDate+Extension.swift
//  douyu
//
//  Created by qianjn on 2016/12/25.
//  Copyright © 2016年 SF. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let interval = Int(NSDate().timeIntervalSince1970)
        return "\(interval)"
    }
}

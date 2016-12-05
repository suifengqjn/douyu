//
//  UIColor+Extension.swift
//  douyu
//
//  Created by qianjn on 2016/12/5.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit


extension UIColor {
 
    // MARK: - 便利构造器
    convenience init(hexValue: Int, alpha: CGFloat) {
        
        self.init(red: CGFloat((hexValue & 0xFF0000) >> 16)/255.0,
                   green: CGFloat((hexValue & 0xFF00) >> 8)/255.0,
                   blue: CGFloat((hexValue & 0xFF) >> 8)/255.0,
                   alpha: alpha)
    }
    
    class func randomColor() -> UIColor {
        
        return UIColor(red: CGFloat(arc4random_uniform(256))/255, green: CGFloat(arc4random_uniform(256))/355, blue: CGFloat(arc4random_uniform(256))/255, alpha: 1)
            
    }
    
}

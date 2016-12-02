//
//  UIBarButtonItem+Extension.swift
//  douyu
//
//  Created by qianjn on 2016/12/2.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func itemCreated(imageName:String,highLightImageName:String,size:CGSize) -> UIBarButtonItem {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highLightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
        return UIBarButtonItem(customView: btn)
    }
}

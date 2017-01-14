//
//  XCNavigationController.swift
//  douyu
//
//  Created by qianjn on 2017/1/14.
//  Copyright © 2017年 SF. All rights reserved.
//

import UIKit


//
class XCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1. 获取系统的 pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        //2. 获取手势所在的view
        guard let gesView = systemGes.view else { return }
        
        //3. 获取target/action
        //3.1 获取target
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        
        guard let targetObj = targets?.first else { return }
        
        guard let tatget = targetObj.value(forKey: "_target") else {return }
        
        //3.2 获取action
        let action = Selector(("handleNavigationTransition:"))
        
        //4创建自己的手势
        let pan = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(pan)
        pan.addTarget(tatget, action: action)
    }


}

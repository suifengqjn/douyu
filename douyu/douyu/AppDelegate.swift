//
//  AppDelegate.swift
//  douyu
//
//  Created by qianjn on 2016/11/30.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setUpProject()
        
        return true
    }

    func setUpProject() {
        UITabBar.appearance().tintColor = UIColor.orange
    }


}


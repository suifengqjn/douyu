//
//  HomeController.swift
//  douyu
//
//  Created by qianjn on 2016/12/2.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    

}


// MARK: - 设置UI界面
extension HomeController {
    
    fileprivate func setupUI() {
        setupNavgationbar()
    }
    
    ///1. 设置导航栏
    private func setupNavgationbar() {
        //左侧按钮
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        //右侧按钮
        
        
    }
}

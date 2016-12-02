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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //右侧按钮
        
        let itemSize = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highLightImageName: "Image_my_history_click", size: itemSize)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highLightImageName: "btn_search_clicked", size: itemSize)
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", highLightImageName: "Image_scan_click", size: itemSize)
        self.navigationItem.rightBarButtonItems = [historyItem, searchItem, qrCodeItem]
    }
}

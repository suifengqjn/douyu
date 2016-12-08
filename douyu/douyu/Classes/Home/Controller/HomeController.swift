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

    lazy var titleView: PagetitleView = { [weak self] in
       
        let titleView = PagetitleView(frame: CGRect(x:0, y:Int(kNavHeight), width: Int(kScreenWidth), height:40), titles: ["推荐", "游戏", "娱乐", "趣玩"])
        titleView.delegate = self
        return titleView
        
    }()
    
    lazy var pageContentView: PageContentView = { [weak self] in
        
        let frame = CGRect(x: 0, y: kNavHeight + (self?.titleView.frame.height)!, width: kScreenWidth, height: kScreenHeight - kNavHeight - (self?.titleView.frame.height)! - kTabBarHeight)
        
        var arr:[UIViewController] = []
        let recommendVC = RecommendController()
        
        arr.append(recommendVC)
        for _ in 0..<3{
            let VC = UIViewController()
            VC.view.backgroundColor = UIColor.randomColor()
            arr.append(UIViewController())
        }
        
       let contentView = PageContentView(frame: frame, childsVC: arr, parentVC: self!)
        contentView.delegate = self
        return contentView
    }()
    

}


// MARK: - 设置UI界面
extension HomeController {
    
    fileprivate func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavgationbar()
        
        setUpTitleView()
        
        setUpContentView()
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
    
    ///2. 设置titleView
    private func setUpTitleView() {
        self.view.addSubview(titleView)
    }
    
    ///3. 设置contentView
    private func setUpContentView() {
        self.view.addSubview(pageContentView)
    }
}


// MARK - PagetitleViewDelegate
extension HomeController: PagetitleViewDelegate {
    func pageTitleView(titleView: PagetitleView, index: NSInteger) {
        pageContentView.setContentOffsetWithIndex(index: index)
    }
}


// MARK - PagetitleViewDelegate
extension HomeController: PageContentViewDelegate {
    
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setUpContentOffsetW(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

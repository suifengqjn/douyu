//
//  PageContentView.swift
//  douyu
//
//  Created by qianjn on 2016/12/5.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

protocol PageContentViewDelegate : class {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}


class PageContentView: UIView {

    fileprivate var childsVC:[UIViewController]
    fileprivate weak var parentVC:UIViewController?
    
    weak var delegate : PageContentViewDelegate?
    
    lazy var collectionView:UICollectionView = { [weak self] in
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let colllectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        colllectionView.isPagingEnabled = true
        colllectionView.showsHorizontalScrollIndicator = true
        colllectionView.bounces = false
        colllectionView.dataSource = self
        
        colllectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return colllectionView
        
    }()
    
    init(frame: CGRect, childsVC:[UIViewController], parentVC:UIViewController) {
        
        self.childsVC = childsVC
        self.parentVC = parentVC
        super.init(frame:frame)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//UI
extension PageContentView {
    
    fileprivate func buildUI() {
    
        for childVc in self.childsVC {
            parentVC?.addChildViewController(childVc)
        }
        
        // 2.添加UICollectionView, 用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds

        
    }
}



// mark - UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.childsVC.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2.给Cell设置内容
        // 2.1 由于循环利用, 避免循环添加, 先删除所有的子视图
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        //let childVc = childsVC[(indexPath as NSIndexPath).item]
        let childVC = childsVC[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}







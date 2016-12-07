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
    fileprivate var startOffsetX:CGFloat = 0
    fileprivate var isForbidScrollDelegate = false
    
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
        colllectionView.delegate = self
        
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

// mark - 提供给外界的接口
extension PageContentView {
    func setContentOffsetWithIndex(index: NSInteger) {
        let offSetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offSetX, y:0), animated: true)
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
        childVC.view.backgroundColor = UIColor.randomColor()
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}


// MARK:- 遵守UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 关闭禁止代理方法
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 1.定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左滑动还是右滑动
        let currentOffsetX : CGFloat = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        if currentOffsetX > startOffsetX { // 左滑动
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childsVC.count {
                targetIndex = childsVC.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1.0
                targetIndex = sourceIndex
            }
        } else { // 右滑动
            // 1.计算progres  s
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childsVC.count {
                sourceIndex = childsVC.count - 1
            }
            
            // 4.如果完全划过去
            if startOffsetX - currentOffsetX == scrollViewW {
                progress = 1.0
                sourceIndex = targetIndex
            }
        }
        
        // 3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}





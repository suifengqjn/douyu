//
//  RecommendCycleView.swift
//  douyu
//
//  Created by qianjn on 2016/12/26.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit


private let kCycleCellId = "kCycleCellId"

class RecommendCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    var timer: Timer?;
    
    public var cycleArr : [CycleModel]? {
        didSet {
            guard let arr = cycleArr else { return }
            collectionView.reloadData()
            pageController.numberOfPages = arr.count
            
            let index = IndexPath(item: (cycleArr?.count)! * 10, section: 0)
            collectionView.scrollToItem(at: index, at: .left, animated: false)
            addTimer()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //不随父控件拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        
        collectionView.register(UINib(nibName: "RecommendCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellId)
        
        
    }
    
}

extension RecommendCycleView:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleArr?.count ?? 0)*100
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cycle = cycleArr![(indexPath as NSIndexPath).item % cycleArr!.count]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as? RecommendCycleCell
        
        cell?.cycle = cycle
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


extension RecommendCycleView:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5
        
        let currentIndex = Int(offsetX / collectionView.bounds.size.width) % (cycleArr?.count ?? 1)
        
        pageController.currentPage = currentIndex
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}

extension RecommendCycleView {
    class func createCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}


///定时器
extension RecommendCycleView {
    func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(gotoNext), userInfo: nil, repeats: true)
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func gotoNext() {
        let currentOffsetX = collectionView.contentOffset.x
        if currentOffsetX > (collectionView.contentSize.width * 4 / 5) {
            collectionView.setContentOffset(CGPoint(x:collectionView.contentSize.width/2,y:0), animated: false)
        }
        collectionView.setContentOffset(CGPoint(x:currentOffsetX+kScreenWidth,y:0), animated: true)
    }
}


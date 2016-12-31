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
    
    public var cycleArr : [CycleModel]? {
        didSet {
            guard let arr = cycleArr else { return }
            collectionView.reloadData()
            pageController.numberOfPages = arr.count
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
        return cycleArr?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cycle = cycleArr?[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as? RecommendCycleCell
        
        cell?.cycle = cycle
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


extension RecommendCycleView:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / kScreenWidth)
        pageController.currentPage = currentIndex
    }
}

extension RecommendCycleView {
    class func createCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

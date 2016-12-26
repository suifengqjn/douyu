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
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //不随父控件拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellId)
    }
    
}

extension RecommendCycleView:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension RecommendCycleView {
    class func createCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//
//  RecommendController.swift
//  douyu
//
//  Created by qianjn on 2016/12/8.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit


let kHomeItemMargin:CGFloat = 10
let kHomeItemWidth: CGFloat = (kScreenWidth - 3*kHomeItemMargin)/2
let kHomeItemNormalHeight: CGFloat = kHomeItemWidth * 3 / 4
let kHomeItemBeautyHeight: CGFloat = kHomeItemWidth * 4 / 3
let kHomeSectionHeaderHeight:CGFloat = 50
let kHomeCellIden = "kHomeCellIden"
let kHomeBeautyCellIden = "kHomeBeautyCellIden"
let kHomeHeaderIden = "kHomeHeaderIden"

class RecommendController: UIViewController {

    
    lazy var recomVModel = RecommendViewModel()
    lazy var cycleView : RecommendCycleView = {
       
        let cycleView = RecommendCycleView.createCycleView()
        cycleView.frame = CGRect(x: 0, y: -cycleView.frame.height, width: kScreenWidth, height: cycleView.frame.height)
        return cycleView
    }()
    
    lazy var collectionView:UICollectionView = { [weak self] in
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kHomeItemWidth, height: kHomeItemNormalHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kHomeItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kHomeItemMargin, bottom: 0, right: kHomeItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHomeSectionHeaderHeight)
        
        let collView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collView.backgroundColor = UIColor.white
        collView.dataSource = self
        collView.delegate = self
        collView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kHomeCellIden)
        collView.register(UINib(nibName: "CollectionViewBeautyCell", bundle: nil), forCellWithReuseIdentifier: kHomeBeautyCellIden)
         collView.register(UINib(nibName: "CollectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHomeHeaderIden)
        //宽度，高度随父视图变化
        collView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collView.contentInset = UIEdgeInsetsMake((self?.cycleView.frame.height)!, 0, 0, 0)
        return collView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        loadData()

    }

}


// MARK - UI
extension RecommendController {
    
    fileprivate func buildUI() {
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        
    }
}

// MARK - 网络请求
extension RecommendController {
    fileprivate func loadData() {
        
        recomVModel.requestData { 
            self.collectionView.reloadData()
        }
    }
}


extension RecommendController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recomVModel.group.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recomVModel.group[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recomVModel.group[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        var cell : CollectionBaseCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHomeBeautyCellIden, for: indexPath) as! CollectionViewBeautyCell
            
        } else {
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHomeCellIden, for: indexPath) as! CollectionViewNormalCell
       
        }
        
        cell.anchor = anchor
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHomeHeaderIden, for: indexPath) as! CollectionHeader
        headView.group = recomVModel.group[indexPath.section]
        return headView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kHomeItemWidth, height: kHomeItemBeautyHeight)
        }
        return CGSize(width: kHomeItemWidth, height: kHomeItemNormalHeight)
    }
    
}


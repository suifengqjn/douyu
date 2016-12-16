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
let kHomeItemHeight: CGFloat = kHomeItemWidth * 3 / 4
let kHomeSectionHeaderHeight:CGFloat = 50
let kHomeCellIden = "kHomeCellIden"
let kHomeHeaderIden = "kHomeHeaderIden"

class RecommendController: UIViewController {

    
    lazy var collectionView:UICollectionView = { [weak self] in
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kHomeItemWidth, height: kHomeItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kHomeItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kHomeItemMargin, bottom: 0, right: kHomeItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHomeSectionHeaderHeight)
        
        let collView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        
        collView.dataSource = self
        collView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kHomeCellIden)
         collView.register( UINib(nibName: "CollectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHomeHeaderIden)
        //宽度，高度随父视图变化
        collView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
       
    }

}


// MARK - UI
extension RecommendController {
    
    fileprivate func buildUI() {
        view.addSubview(collectionView)
    }
}


extension RecommendController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHomeCellIden, for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHomeHeaderIden, for: indexPath)
        headView.backgroundColor = UIColor.white
        
        return headView
    }
    
}


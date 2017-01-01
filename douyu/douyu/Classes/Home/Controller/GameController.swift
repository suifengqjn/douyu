//
//  GameController.swift
//  douyu
//
//  Created by qianjn on 2017/1/1.
//  Copyright © 2017年 SF. All rights reserved.
//

import UIKit

private let kEdgeMargin: CGFloat = 10
private let k_Item_Width: CGFloat = (kScreenWidth - 2 * kEdgeMargin) / 3
private let k_Item_Height: CGFloat = k_Item_Width * 6 / 5
private let kGameViewH : CGFloat = 90
private let kGameCellID = "kGameCellID"


class GameController: UIViewController {

    fileprivate lazy var collectionView: UICollectionView = { [weak self] in
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: k_Item_Width, height: k_Item_Height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        let collView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collView.dataSource = self
        collView.backgroundColor = UIColor.white
        collView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        return collView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        
    }


}



// MARK: - UI
extension GameController {
    fileprivate func buildUI() {
        view.addSubview(collectionView)
        
        
    }
}


// MARK: - UICollectionView
extension GameController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as? GameCell
        cell?.backgroundColor = UIColor.randomColor()
        return cell!
    }
    
}

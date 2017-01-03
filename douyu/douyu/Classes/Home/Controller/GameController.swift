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

    fileprivate lazy var gameModel:GameViewModel = GameViewModel()
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
    
    fileprivate lazy var collectionHeadTopView: CollectionHeader  = {
        let headView = CollectionHeader.createHeadView()
        headView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        headView.iconImage.image = UIImage(named: "Img_orange")
        headView.titlelabel.text = "常见"
        headView.moreBtn.isHidden = true
        return headView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        loadData()
    }


}



// MARK: - UI
extension GameController {
    fileprivate func buildUI() {
        view.addSubview(collectionView)
        
        collectionView.addSubview(collectionHeadTopView)
        
        
        collectionView.contentInset = UIEdgeInsets(top: collectionHeadTopView.frame.height, left: 0, bottom: 0, right: 0)
        
    }
}
// MARK: - load data
extension GameController {
    fileprivate func loadData() {
        gameModel.loadGamesData { 
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionView
extension GameController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameModel.games.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let game = gameModel.games[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as? GameCell
        cell?.game = game
        return cell!
    }
    
}

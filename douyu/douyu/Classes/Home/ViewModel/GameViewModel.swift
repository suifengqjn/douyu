//
//  GameViewModel.swift
//  douyu
//
//  Created by qianjn on 2017/1/1.
//  Copyright © 2017年 SF. All rights reserved.
//

import UIKit

class GameViewModel: NSObject {

    var games:[GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadGamesData( finishBack: @escaping() -> ()) {
        
        NetWork.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", params: ["shortName":"game"]) { (result) in
            
             guard let resultDict = result as? [String : NSObject] else { return }
            
            guard let resultArr = resultDict["data"] as?[[String: NSObject]]else { return }
    
            for game in resultArr {
                self.games.append(GameModel(dict: game))
            }
            finishBack()
        }
    }
}

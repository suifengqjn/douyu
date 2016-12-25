//
//  RecommendViewModel.swift
//  douyu
//
//  Created by qianjn on 2016/12/25.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

class RecommendViewModel {

    lazy var group: [AnchorGroup] = [AnchorGroup]()
    
}


// MARK: - 网络请求
extension RecommendViewModel {
    
     public func requestData () {
        
        
        //
        var params = [String: String]()

        params["limit"] = "4"
        params["offset"] = "0"
        params["time"] = NSDate.getCurrentTime()
        
        
        NetWork.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", params: params) { (result) in
            
            //1. 将result 转成字典类型
            guard let dict = result as? [String : NSObject] else {
                return
            }
            //2. 取出需要的数据
            guard let array = dict["data"] as? [[String : NSObject]] else {
                return
            }
            //3. 转换成模型
            for dic in array {
                let gr = AnchorGroup(dict: dic)
                self.group.append(gr)
            }
            
        }

    }
    
}

//
//  RecommendViewModel.swift
//  douyu
//
//  Created by qianjn on 2016/12/25.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

class RecommendViewModel {

    lazy var cycleGroup: [CycleModel] = [CycleModel]()
    lazy var group: [AnchorGroup] = [AnchorGroup]()
    lazy var BigDataGroup :AnchorGroup = AnchorGroup()
    lazy var PrettyGroup:AnchorGroup = AnchorGroup()
    
}


// MARK: - 网络请求
extension RecommendViewModel {
    
    //瀑布流数据
    public func requestData (finishCallback: @escaping () -> ()) {
        
        var params = [String: String]()
        params["limit"] = "4"
        params["offset"] = "0"
        params["time"] = NSDate.getCurrentTime()
        
        let GCDGroup = DispatchGroup()
        
        //0
        GCDGroup.enter()
        NetWork.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", params: params) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key, 获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]]else {return}
            
            // 3.遍历字典,并且转成模型数组
            // 3.1设置组的属性
            
            
            self.BigDataGroup.tag_name = "热门"
            self.BigDataGroup.icon_name = "home_header_hot"
            
            // 3.2获取主播数据
            for dict in dataArray {
                let anchor = Anchor(dict: dict)
                self.BigDataGroup.anchors.append(anchor)
            }
            GCDGroup.leave()
        }
        
        //1
        GCDGroup.enter()
        NetWork.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: params) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key, 获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]]else {return}
            
            // 3.遍历字典,并且转成模型数组
            // 3.1设置组的属性
            
            
            self.PrettyGroup.tag_name = "颜值"
            self.PrettyGroup.icon_name = "home_header_phone"
            
            // 3.2获取主播数据
            for dict in dataArray {
                let anchor = Anchor(dict: dict)
                self.PrettyGroup.anchors.append(anchor)
            }
            
            // 3.3离开组
            GCDGroup.leave()
        }

        
        // 2- 12
        
        GCDGroup.enter()
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
            
            GCDGroup.leave()
        }
        
        
        GCDGroup.notify(queue: DispatchQueue.main) {
            self.group.insert(self.PrettyGroup, at: 0)
            self.group.insert(self.BigDataGroup, at: 0)
            finishCallback()
        }

    }
    
    //轮播图数据
    public func requestCycleData(finishCallBack: @escaping() -> ()) {
        
        let  param =  ["version" : "2.300"]
        
        NetWork.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", params: param) { (result) in
            
            guard let resultDic = result as? [String : NSObject] else { return }
            guard let resultArr = resultDic["data"] as? [[String : NSObject]] else { return }
            
            for param in resultArr {
                self.cycleGroup.append(CycleModel(dict: param))
            }
            finishCallBack()
        }
        
    }
    
    
    
    
}

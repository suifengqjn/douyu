//
//  NetWork.swift
//  douyu
//
//  Created by qianjn on 2016/12/25.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

///swift 可以不继承任何类
class NetWork {
    
    
    class func requestData(type: MethodType, URLString: String, params:[String : Any]? = nil, finishCallBack: @escaping (_ result : Any) -> ()) {
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: params).responseJSON { (response) in
            
            guard let result = response.result.value else {
                print(response.result.error ?? "net work error")
                return
            }
            
            finishCallBack(result)
        }
    }
}

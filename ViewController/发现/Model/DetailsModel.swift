//
//  DetailsModel.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class DetailsModel: NSObject {
    var title: String!
    var year: String!
    var summary: String!
    
    static func modelWith(dic: [String: AnyObject])->DetailsModel{
        let model = DetailsModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

//评论模型
//评论人模型
class userModel: NSObject {
    var headImgUrl: String!
    var id: String!
    var nickname: String!
    var iswriter: String!
    
    static func modelWith(dic: [String: AnyObject])->userModel{
        let model = userModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
}

//内容的模型
class commentModel: NSObject {
    var content: String!
    var commenttime: String!
    
    static func modelWith(dic: [String: AnyObject])->commentModel{
        let model = commentModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

//
//  RecommendModel.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit
//第一种模型
class RecommendModel: NSObject {

    var title: String!
    var nickname: String!
    var keyword: String!
    var imgUrl: String!
    var articleContentUrl: String!
    
    static func modelWith(dic: [String: AnyObject])->RecommendModel{
        let model = RecommendModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

//第二种模型
class SRecommendModel: NSObject {
    var title: String!
    var videoTime: String!
    var keyword: String!
    var coverUrl: String!
    var videoUrl: String!
    
    
    static func modelWith(dic: [String: AnyObject])->SRecommendModel{
        let model = SRecommendModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

//第三种模型
class TRecommendModel: NSObject {
    var title: String!
    var articlesNum: NSNumber!
    var subscribeNum: NSNumber!
    var keyword: String!
    var headImgUrl: String!
    var imgUrl: String!
    var id: String!
    
    static func modelWith(dic: [String: AnyObject])->TRecommendModel{
        let model = TRecommendModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}



//
//  DiscoverModel.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import Foundation

//第三个页面发布评论人的信息
class authorModel: NSObject {
    var nickname: String!
    var headImgUrl: String!
    
    static func modelWith(dic: [String: AnyObject])->authorModel{
        let model = authorModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

//第三个页面内容和Id的模型
class contentModel: NSObject {
    var recommend: String!
    var filmResourcesId: String!
    var createDate: NSNumber!
    
    static func modelWith(dic: [String: AnyObject])->contentModel{
        let model = contentModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

//第三个页面导演的模型
class directorModel: NSObject {
    var name: String!
    var id: String!
    var alt: String!
    
    static func modelWith(dic: [String: AnyObject])->directorModel{
        let model = directorModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

//第三个页面演员的模型
class castModel: NSObject {
    var id: String!
    var alt: String!
    var name: String!
}



//
//  ClassifyModel.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit
//分类页面的collectionView模型
class ClassifyModel: NSObject {

    var imgUrl: String!
    var title: String!
    var articlesNum: NSNumber!
    var subscribeNum: NSNumber!
    var id: String!
    
    static func modelWith(dic: [String: AnyObject])->ClassifyModel{
        let model = ClassifyModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

//分类页面的tableView 模型
class tableViewModel: NSObject {
    var title: String!
    var sourceName: String!
    var image: String!
    var articleUrl: String!
    
    static func modelWith(dic: [String: AnyObject])->tableViewModel{
        let model = tableViewModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

//分类页面collectionView中第一个视觉系的二级页面title的模型
class pushModel: NSObject {
    var title: String!
    var praiseCount: String!
    
    static func modelWith(dic: [String: AnyObject])->pushModel{
        let model = pushModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

//分类页面collectionView中第一个视觉系的二级页面nick的模型
class articleModel: NSObject {
    var headImgUrl: String!
    var id: String!
    var nickname: String!
    
    static func modelWith(dic: [String: AnyObject])->articleModel{
        let model = articleModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
}

//分类页面的上边collectionView二级页面的type为2的模型
class objectModel: NSObject {
    var title: String!
    var videoTime: String!
    var coverUrl: String!
    var videoUrl: String!
    
    static func modelWith(dic: [String: AnyObject])->objectModel{
        let model = objectModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

//分类页面collectionView二级页面type为6的模型
class lastModel: NSObject {
    var imgUrl: String!
    var sourceAuthor: String!
    var Description: String!
    var praiseCount: NSNumber!
    var id: String!
    
    static func modelWith(dic: [String: AnyObject])->lastModel{
        let model = lastModel()
        model.setValuesForKeysWithDictionary(dic)
        model.Description = dic["description"] as? String
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}

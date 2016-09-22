//
//  ClassifyModel.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class ClassifyModel: NSObject {

    var imgUrl: String!
    var title: String!
    var articlesNum: NSNumber!
    var subscribeNum: NSNumber!
    
    static func modelWith(dic: [String: AnyObject])->ClassifyModel{
        let model = ClassifyModel()
        model.setValuesForKeysWithDictionary(dic)
        return model
    }
    
    //如果key不存在，走这个方法，直接跳过
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

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

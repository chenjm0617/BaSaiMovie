//
//  MyConnection.swift
//  LoveFree
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class MyConnection: NSObject {

//MARK:属性
    //记录代表网址的字符串
    var urlStr: String?
    
    //记录下载的数据
    let downloadData = NSMutableData()
    
    //记录一个对象(不关心对象是谁)
    var target: AnyObject?
    
    //记录一个方法
    var action: Selector?
    
    //记录下载的状态(成功还是失败)
    var isFinish = false
    
    //标记(判断是哪次网络请求)
    var tag: Int?
    
    //记录执行网络链接的对象，可能会有取消网络连接
    var connection: NSURLConnection?
    
//MARK：方法
    //构造
    init(urlStr: String, target: AnyObject, action: Selector, tag: Int = 0) {
        self.urlStr = urlStr
        self.target = target
        self.action = action
        self.tag = tag
    }
    //启动
    func start()->Void{
        let url = NSURL.init(string: urlStr!)!
        let request = NSURLRequest.init(URL: url)
        //网络数据加载时的小菊花
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        connection = NSURLConnection.init(request: request, delegate: self)//只要网络请求在，就会保留它的代理
    }
    
    func stop()->Void{
        //取消网络链接
        connection?.cancel()
    }
    
    //不会手动触发deinit，只会自动触发，没引用时执行deinit，死亡之前执行里面的程序
    deinit{
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}

extension MyConnection: NSURLConnectionDataDelegate{
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        downloadData.length = 0
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        downloadData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        isFinish = true
        //调选择器的方法，将自己传过去
        target?.performSelector(action!, withObject: self)
        //让某个属性target调某个方法action，把自己self作为参数传过去
        
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        isFinish = false
        target?.performSelector(action!, withObject: self)
        
    }
}




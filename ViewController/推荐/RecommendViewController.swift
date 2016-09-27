//
//  RecommendViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class RecommendViewController: BaseViewController {

    let MyView = bigView()
    var bannerArray = NSMutableArray() //存放轮播视图
    var typeArray = NSMutableArray()  //存放区分cell类型字符串
    var authorNameArray = NSMutableArray()  //存放作者名字
    var timeArray = NSMutableArray()  //存放时间段
    var dataArray = NSMutableArray()
    
    lazy var headerView:UIView = {
        let headerView = UIView.init(frame: CGRectMake(0, 64, SCREEN_W, 243))
        headerView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(headerView)
        return headerView
    }()
    
    lazy var tableView: UITableView = {
       let tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49))
        tableView.registerNib(UINib.init(nibName: "RecommendCell", bundle: nil), forCellReuseIdentifier: "RecommendCell")
        tableView.registerNib(UINib.init(nibName: "SRecommendCell", bundle: nil), forCellReuseIdentifier: "SRecommendCell")
        tableView.registerNib(UINib.init(nibName: "TRecommendCell", bundle: nil), forCellReuseIdentifier: "TRecommendCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = self.headerView
        self.view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "推荐"
        
        let recommendUrl = "http://www.moviebase.cn/uread/app/recommend/recommend?pageContext=1&platform=2&naviId=2&sysver=4.4.4&channelId=1002&appVersion=1.6.0&deviceModel=HM%2BNOTE%2B1LTE&versionCode=1066&deviceId=1B21F376753E91FF0B7070F02EF5D126"
        let mc = MyConnection.init(urlStr: recommendUrl, target: self, action: #selector(self.connectionFinish(_:)))
        mc.start()
//        HDManager.startLoading()
    }
    
    func connectionFinish(mc: MyConnection) -> Void {
        if mc.isFinish {
            self.parseData(mc.downloadData)
//            HDManager.stopLoading()
        }else{
            let ac = UIAlertController.init(title: "网络请求失败", message: "请检查网络链接", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
            ac.addAction(action)
            self.presentViewController(ac, animated: true, completion: nil)
//            HDManager.stopLoading()
        }
    }
    
    func parseData(data: NSData) -> Void {
        let obj = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        let list = obj["forcusImageList"] as! [NSDictionary]
        bannerArray.addObjectsFromArray(list)
        bannerArray.insertObject(bannerArray[bannerArray.count - 1], atIndex: 0)
        bannerArray.addObject(bannerArray[1])
        self.createUI()
        
        var infoList = obj["infoList"] as! [NSDictionary]
        infoList.removeAtIndex(0)
        var i = 0
        for dict in infoList {
            let objectType = dict["objectType"] as! String
            typeArray.addObject(objectType)
            
            if typeArray[i] as! String == "1" {
                let object = dict["object"] as! NSDictionary
                let articleSource = object["articleSource"] as! NSDictionary
                let nickname = articleSource["nickname"] as! String
                authorNameArray.addObject(nickname)
                
                dataArray.addObject(RecommendModel.modelWith(object as! [String : AnyObject]))
                let time = object["createDate"] as! Int
                timeArray.addObject(time)
            }else if typeArray[i] as! String == "2"{
                authorNameArray.addObject("")
                
                let object = dict["object"] as! NSDictionary
                dataArray.addObject(SRecommendModel.modelWith(object as! [String : AnyObject]))
                timeArray.addObject("")
            }else{
                authorNameArray.addObject("")
                
                let object = dict["object"] as! NSDictionary
                dataArray.addObject(TRecommendModel.modelWith(object as! [String : AnyObject]))
                timeArray.addObject("")
            }
    
            i += 1
        }
        tableView.reloadData()
    }
    
    func createUI() -> Void {
        MyView.frame = CGRectMake(0, 0, SCREEN_W, 200)
        headerView.addSubview(MyView)
        MyView.scrollView.contentSize = CGSizeMake(CGFloat(bannerArray.count) * SCREEN_W, 0)
        for i in 0...bannerArray.count - 1 {
            let model = bannerArray[i] as! NSDictionary
            let imageV = BannerView.init(frame: CGRectMake(CGFloat(i) * SCREEN_W, 0, SCREEN_W, 200))
            MyView.scrollView.addSubview(imageV)
            imageV.sd_setImageWithURL(NSURL.init(string: model["imageUrl"] as! String))
            imageV.mainTitleL.text = model["mainTitle"] as? String
            imageV.subTitleL.text = model["subTitle"] as? String
        }
        
        
        let label = UILabel.init(frame: CGRectMake(0, 210, SCREEN_W, 23))
        label.font = UIFont.systemFontOfSize(16)
        label.textAlignment = .Center
        label.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.5)
        label.text = "- 欢迎使用 -"
        headerView.addSubview(label)

    }
    
    func timeFromInt(number: Int) -> String {
        let createTime = NSDate.init(timeIntervalSince1970: NSTimeInterval.init(number))
        var timeStr = String(createTime)
        timeStr.removeRange(Range(start: timeStr.startIndex.advancedBy(20), end: timeStr.startIndex.advancedBy(25)))
        return timeStr
        
    }

}

//MARK: UITableView 协议方法
extension RecommendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let type = typeArray[indexPath.row] as! String
        if type == "1" {
            let cell = tableView.dequeueReusableCellWithIdentifier("RecommendCell", forIndexPath: indexPath) as! RecommendCell
            cell.nickL.text = authorNameArray[indexPath.row] as? String
            let model = dataArray[indexPath.row] as! RecommendModel
            cell.headImage.sd_setImageWithURL(NSURL.init(string: model.imgUrl))
            cell.titleL.text = model.title
            cell.keywordL.text = model.keyword
            let time = timeArray[indexPath.row] as! Int
            cell.timeL.text = self.timeFromInt(time)
            return cell
        }else if type == "2" {
            let cell = tableView.dequeueReusableCellWithIdentifier("SRecommendCell", forIndexPath: indexPath) as! SRecommendCell
            let model = dataArray[indexPath.row] as! SRecommendModel
            cell.headImage.sd_setImageWithURL(NSURL.init(string: model.coverUrl))
            cell.titleL.text = model.title
            cell.timeL.text = model.videoTime
            cell.keywordL.text = model.keyword
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("TRecommendCell", forIndexPath: indexPath) as! TRecommendCell
            let model = dataArray[indexPath.row] as! TRecommendModel
            cell.headImage.sd_setImageWithURL(NSURL.init(string: model.headImgUrl))
            cell.titleL.text = model.title
            cell.numberL.text = "\(model.articlesNum) 篇/\(model.subscribeNum) 订阅"
            cell.keywordL.text = model.keyword
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if typeArray[indexPath.row] as! String == "1" {
            return 120
        }else{
            return 170
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let type = typeArray[indexPath.row] as! String
        if type == "1" {
            let model = dataArray[indexPath.row] as! RecommendModel
            let fvc = FirstViewController()
            fvc.webViewUrl = model.articleContentUrl
            self.navigationController?.pushViewController(fvc, animated: true)
            
        }else if type == "2" {
            let model = dataArray[indexPath.row] as! SRecommendModel
            let svc = SecondViewController()
            svc.videoUrl = model.videoUrl
            self.navigationController?.pushViewController(svc, animated: true)
        }else{
            let model = dataArray[indexPath.row] as! TRecommendModel
            let csvc = CSecondViewController()
            csvc.imageUrl = model.imgUrl
            csvc.nameStr = model.title
            csvc.numberStr1 = model.articlesNum
            csvc.numberStr2 = model.subscribeNum
            csvc.id = model.id
            self.navigationController?.pushViewController(csvc, animated: true)        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

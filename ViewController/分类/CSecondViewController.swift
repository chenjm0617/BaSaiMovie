//
//  CSecondViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class CSecondViewController: UIViewController {

    var imageUrl: String!
    var nameStr: String!
    var numberStr1: NSNumber!
    var numberStr2: NSNumber!
    var id: String!
    
    var page = 1
    
    var typeArray = NSMutableArray()  //存放区分cell类型字符串
    var nickArray = NSMutableArray()  //存放nick的数组
    var urlArray = NSMutableArray()  //存放type为1的跳转页面的url
    var dataArray = NSMutableArray()
    
    lazy var headView: UIView = {
        let headView = UIView.init(frame: CGRectMake(0, 64, SCREEN_W, 250))
        headView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        self.view.addSubview(headView)
        return headView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49))
        tableView.registerNib(UINib.init(nibName: "RecommendCell", bundle: nil), forCellReuseIdentifier: "RecommendCell")
        tableView.registerNib(UINib.init(nibName: "SRecommendCell", bundle: nil), forCellReuseIdentifier: "SRecommendCell")
        tableView.registerNib(UINib.init(nibName: "secondCell", bundle: nil), forCellReuseIdentifier: "secondCell")
        tableView.tableHeaderView = self.headView
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        self.createUI()
        
        weak var weakSelf = self
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock:  {
            let url = String.init(format: "http://www.moviebase.cn/uread/app/topic/topicDetail/articleList?pageContext=%d&platform=2&sysver=4.4.4&channelId=1002&appVersion=1.6.0&topicId=%@&versionCode=1066&deviceId=1B21F376753E91FF0B7070F02EF5D126", weakSelf!.page, weakSelf!.id)
            let mc = MyConnection.init(urlStr: url, target: self, action: #selector(self.connectionFinish(_:)))
            mc.start()
            HDManager.startLoading()
        })
        tableView.mj_footer.beginRefreshing()
    }
    
    func connectionFinish(mc: MyConnection) -> Void {
        if mc.isFinish {
            self.parseData(mc.downloadData)
            tableView.reloadData()
            HDManager.stopLoading()
            page += 1
        }else{
            print("网络请求失败")
            HDManager.stopLoading()
        }
    }
    
    func parseData(data: NSData) -> Void {
        let obj = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        let articleList = obj["articleList"] as! [NSDictionary]
        for dict in articleList {
            let type = dict["objectType"] as! String
            typeArray.addObject(type)
            
            let object = dict["object"] as! NSDictionary
            if type == "1" {
                let article = object["articleSource"] as! NSDictionary
                let nickname = article["nickname"] as! String
                nickArray.addObject(nickname)
                
                dataArray.addObject(ClassifyModel.modelWith(object as! [String : AnyObject]))
                
                let urlDic = object["shareUrl"] as! NSDictionary
                let urlStr = urlDic["url"] as! String
                urlArray.addObject(urlStr)
            }else if type == "2"{
                nickArray.addObject("")
                
                dataArray.addObject(objectModel.modelWith(object as! [String : AnyObject]))
                
                urlArray.addObject("")
            }else{
                nickArray.addObject("")
                
                dataArray.addObject(lastModel.modelWith(object as! [String : AnyObject]))
                
                urlArray.addObject("")
            }
            
        }
        tableView.mj_footer.endRefreshing()
    }
    
    func createUI() -> Void {
        let headImage = UIImageView.init(frame: CGRectMake(0, 0, SCREEN_W, 200))
        headView.addSubview(headImage)
        headImage.sd_setImageWithURL(NSURL.init(string: imageUrl))
        
        let nameL = UILabel.init(frame: CGRectMake((SCREEN_W - 80) / 2, 40, 80, 23))
        nameL.textColor = UIColor.whiteColor()
        nameL.textAlignment = .Center
        nameL.font = UIFont.systemFontOfSize(17)
        nameL.text = nameStr
        headImage.addSubview(nameL)
        
        let numberL = UILabel.init(frame: CGRectMake(0, 210, SCREEN_W, 30))
        numberL.font = UIFont.systemFontOfSize(15)
        numberL.text = "   \(numberStr1)篇/\(numberStr2)人订阅"
        headView.addSubview(numberL)
        numberL.backgroundColor = UIColor.whiteColor()
        
//        let button = UIButton.init(frame: CGRectMake(SCREEN_W - 60, 215, 40, 20))
//        button.layer.cornerRadius = 5
//        button.clipsToBounds = true
//        button.layer.borderColor = UIColor.blueColor().CGColor
//        button.layer.borderWidth = 1
//        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        button.setTitle("订阅", forState: UIControlState.Normal)
//        button.titleLabel?.font = UIFont.systemFontOfSize(13)
//        headView.addSubview(button)
        
    }

}

//MARK: UITableView 协议方法
extension CSecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let type = typeArray[indexPath.row] as! String
        if type == "1" {
            let cell = tableView.dequeueReusableCellWithIdentifier("RecommendCell", forIndexPath: indexPath) as! RecommendCell
            cell.nickL.text = nickArray[indexPath.row] as? String
            let model = dataArray[indexPath.row] as! ClassifyModel
            cell.titleL.text = model.title
            cell.headImage.sd_setImageWithURL(NSURL.init(string: model.imgUrl))
            cell.timeL.hidden = true
            cell.keywordL.hidden = true
            return cell
        }else if type == "2"{
            let cell = tableView.dequeueReusableCellWithIdentifier("SRecommendCell", forIndexPath: indexPath) as! SRecommendCell
            let model = dataArray[indexPath.row] as! objectModel
            cell.headImage.sd_setImageWithURL(NSURL.init(string: model.coverUrl))
            cell.titleL.text = model.title
            cell.timeL.text = model.videoTime
            cell.keywordL.hidden = true
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("secondCell", forIndexPath: indexPath) as! secondCell
            
            let model = dataArray[indexPath.row] as! lastModel
            cell.backImage.sd_setImageWithURL(NSURL.init(string: model.imgUrl))
            cell.titleL.text = "\(model.Description)"
            cell.nickL.text = model.sourceAuthor
            cell.numberL.text = String(model.praiseCount)
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let type = typeArray[indexPath.row] as! String
        if type == "1" {
            return 120
        }else if type == "2"{
            return 170
        }else{
            return SCREEN_W - 100
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let type = typeArray[indexPath.row] as! String
        if type == "1" {
            let fvc = FirstViewController()
            fvc.webViewUrl = urlArray[indexPath.row] as! String
            self.navigationController?.pushViewController(fvc, animated: true)
        }else if type == "2"{
            let model = dataArray[indexPath.row] as! objectModel
            let svc = SecondViewController()
            svc.videoUrl = model.videoUrl
            self.navigationController?.pushViewController(svc, animated: true)
        }else{
            let model = dataArray[indexPath.row] as! lastModel
            let ctvc = CThirdViewController()
            ctvc.imageUrl = model.imgUrl
            ctvc.content = model.Description
            self.presentViewController(ctvc, animated: false, completion: nil)
        }
    }
}


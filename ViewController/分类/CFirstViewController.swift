//
//  CFirstViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class CFirstViewController: UIViewController {

    var page = 1
    
    var imageUrl: String!
    var nameStr: String!
    var numberStr1: NSNumber!
    var numberStr2: NSNumber!
    var id: String!
    
    var imageArray = NSMutableArray()  //存放图片的数组
    var articleArray = NSMutableArray()  //存放articleModel数据
    var dataArray = NSMutableArray()
    
    lazy var headView: UIView = {
        let headView = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, 250))
        headView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        self.view.addSubview(headView)
        return headView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49))
        tableView.registerNib(UINib.init(nibName: "firstCell", bundle: nil), forCellReuseIdentifier: "firstCell")
        tableView.tableHeaderView = self.headView
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "视觉系"
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        
        let pushUrl = "http://www.moviebase.cn/uread/app/topic/topicDetail/articleList?pageContext=1&platform=2&sysver=4.4.4&channelId=1002&appVersion=1.6.0&deviceModel=HM%2BNOTE%2B1LTE&topicId=a859adbfce8041d3bd2ded0ae383d3b6&versionCode=1066&deviceId=1B21F376753E91FF0B7070F02EF5D126"
        let mc = MyConnection.init(urlStr: pushUrl, target: self, action: #selector(self.connectionFinish(_:)))
        mc.start()
//        HDManager.startLoading()
        
        self.createUI()
        
//        weak var weakSelf = self
//        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock:  {
//            let pushUrl = String.init(format: "http://www.moviebase.cn/uread/app/topic/topicDetail/articleList?pageContext=%d&platform=2&sysver=4.4.4&channelId=1002&appVersion=1.6.0&topicId=a859adbfce8041d3bd2ded0ae383d3b6&versionCode=1066&deviceId=1B21F376753E91FF0B7070F02EF5D126", weakSelf!.page)
//            let mc = MyConnection.init(urlStr: pushUrl, target: self, action: #selector(self.connectionFinish(_:)))
//            mc.start()
//            HDManager.startLoading()
//        })
//        tableView.mj_footer.beginRefreshing()
    }
    
    func connectionFinish(mc: MyConnection) -> Void {
        if mc.isFinish {
            self.parseData(mc.downloadData)
            tableView.reloadData()
//            HDManager.stopLoading()
//            page += 1
            
        }else{
            print("网络请求失败")
//            HDManager.stopLoading()
        }
    }
    
    func parseData(data: NSData) -> Void {
        let obj = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        let articleList = obj["articleList"] as! [NSDictionary]
        for dict in articleList {
            let object = dict["object"] as! NSDictionary
            dataArray.addObject(pushModel.modelWith(object as! [String : AnyObject]))
            
            let articleSource = object["articleSource"] as! NSDictionary
            articleArray.addObject(articleModel.modelWith(articleSource as! [String : AnyObject]))
            
            let pictorialUrls = object["pictorialUrls"] as! [String]
            imageArray.addObject(pictorialUrls)
        }
//        tableView.mj_footer.endRefreshing()
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

extension CFirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("firstCell", forIndexPath: indexPath) as! firstCell
        
        let model = dataArray[indexPath.row] as! pushModel
        cell.contentL.text = model.title
        cell.numberL.text = String(model.praiseCount)
        cell.numberBtn.setTitle(String.init(format: "全部%d张", imageArray[indexPath.row].count), forState: UIControlState.Normal)
        cell.numberBtn.tag = 100 + indexPath.row
        let smallModel = articleArray[indexPath.row] as! articleModel
        cell.iconView.sd_setImageWithURL(NSURL.init(string: smallModel.headImgUrl))
        cell.nickL.text = smallModel.nickname
        let imageModel = imageArray[indexPath.row] as! [String]
        if imageModel.count < 10 {
            for i in 1...imageModel.count {
                let image = cell.viewWithTag(i) as! UIImageView
                image.sd_setImageWithURL(NSURL.init(string: imageModel[i - 1]))
            }

        }else{
            for i in 1...9 {
                let image = cell.viewWithTag(i) as! UIImageView
                image.sd_setImageWithURL(NSURL.init(string: imageModel[i - 1]))
            }
        }
        cell.numberBtn.addTarget(self, action: #selector(self.numberBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    //MARK: Cell里总张数的按钮的点击事件
    func numberBtnClick(btn: UIButton) -> Void {
        let number = imageArray[btn.tag - 100].count
        let cfvc = CFourthViewController()
        cfvc.count = number
        cfvc.imageArray.addObjectsFromArray(imageArray[btn.tag - 100] as! [AnyObject])
        self.presentViewController(cfvc, animated: false, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 530
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let model = dataArray[indexPath.row] as! pushModel
        let fvc = FirstViewController()
        fvc.webViewUrl = model.articleContentUrl
        self.navigationController?.pushViewController(fvc, animated: true)
    }
}

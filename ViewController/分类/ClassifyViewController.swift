//
//  ClassifyViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class ClassifyViewController: BaseViewController {

    var dataArray = NSMutableArray()  //存放collectionView 数据
    var tableViewArray = NSMutableArray()  //存放tableView 数据aaa
    
    lazy var headView: UIView = {
       let headView = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, 700))
        self.view.addSubview(headView)
        headView.backgroundColor = UIColor.whiteColor()
        return headView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 10, right: 15)
        let collectionView = UICollectionView.init(frame: CGRectMake(0, 40, SCREEN_W, self.headView.frame.size.height - 40), collectionViewLayout: layout)
        collectionView.registerNib(UINib.init(nibName: "headCell", bundle: nil), forCellWithReuseIdentifier: "headCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        self.headView.addSubview(collectionView)
        
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49), style: UITableViewStyle.Plain)
        tableView.registerNib(UINib.init(nibName: "buttomCell", bundle: nil), forCellReuseIdentifier: "buttomCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = self.headView
        self.view.addSubview(tableView)
//        self.headView.frame.size.height = self.collectionView.frame.origin.y + self.collectionView.frame.size.height
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "分类"
        self.createUI()
        
        let classifyUrl = "http://www.moviebase.cn/uread/app/category/categoryList?deviceModel=HM%2BNOTE%2B1LTE&versionCode=1066&platform=2&sysver=4.4.4&channelId=1002&appVersion=1.6.0&deviceId=1B21F376753E91FF0B7070F02EF5D126"
        let mc = MyConnection.init(urlStr: classifyUrl, target: self, action: #selector(self.connectionFinish(_:)))
        mc.start()
        HDManager.startLoading()
        
    }
    
    func connectionFinish(mc: MyConnection) -> Void {
        if mc.isFinish {
            self.parseData(mc.downloadData)
            HDManager.stopLoading()
        }else{
            print("网络请求失败")
            HDManager.stopLoading()
        }
    }
    
    func parseData(data: NSData) -> Void {
        let obj = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        let list = obj["topicRecommendList"] as! [NSDictionary]
        for dict in list {
            dataArray.addObject(ClassifyModel.modelWith(dict as! [String : AnyObject]))
        }
        collectionView.reloadData()
        
        let articleList = obj["articleList"] as! [NSDictionary]
        for dic in articleList {
            tableViewArray.addObject(tableViewModel.modelWith(dic as! [String : AnyObject]))
        }
        tableView.reloadData()
    }
    
    func createUI() -> Void {
        let label = UILabel.init(frame: CGRectMake(0, 0, SCREEN_W, 40))
        label.text = "  专题"
        label.font = UIFont.boldSystemFontOfSize(20)
        headView.addSubview(label)
        
        let button = UIButton.init(frame: CGRectMake(SCREEN_W - 110, 5, 100, 30))
        button.setTitle("查看全部", forState: UIControlState.Normal)
        headView.addSubview(button)
    }

}

//MARK: UICollectionView 协议方法
extension ClassifyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("headCell", forIndexPath: indexPath) as! headCell
        
        let model = dataArray[indexPath.row] as! ClassifyModel
        cell.iconView.sd_setImageWithURL(NSURL.init(string: model.imgUrl))
        cell.titleL.text = model.title
        cell.numberL.text = "\(model.articlesNum)篇/\(model.subscribeNum)人订阅"
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((SCREEN_W - 50) / 2, 200)
    }
}

//MARK: UITableView 协议方法
extension ClassifyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("buttomCell", forIndexPath: indexPath) as! buttomCell
        
        let model = tableViewArray[indexPath.row] as! tableViewModel
        cell.iconView.sd_setImageWithURL(NSURL.init(string: model.image))
        cell.contentL.text = model.title
        cell.nickL.text = model.sourceName
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}


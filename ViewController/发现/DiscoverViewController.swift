//
//  DiscoverViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {

    var authorArray = NSMutableArray()  //存放发布评论人的信息
    var titleArray = NSMutableArray()  //存放电影名
    var directorArray = NSMutableArray()  //存放导演名
    var castArray = NSMutableArray()  //存放演员名
    var contentArray = NSMutableArray()  //存放内容和ID
    var imgArray = NSMutableArray()  //存放电影图片
    
    var page = 1
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49))
        tableView.registerNib(UINib.init(nibName: "newestCell", bundle: nil), forCellReuseIdentifier: "newestCell")
        tableView.estimatedRowHeight = 350
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "最新"
        
        weak var weakSelf = self
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock:  {
            let newestUrl = String.init(format: "http://www.moviebase.cn/uread/app/film/recommendList?pageContext=%d&platform=2&sysver=4.4.4&channelId=1002&appVersion=1.6.0&versionCode=1066&deviceId=1B21F376753E91FF0B7070F02EF5D126", weakSelf!.page)
            let mc = MyConnection.init(urlStr: newestUrl, target: self, action: #selector(self.connectionFinish(_:)))
            mc.start()
            
        })
        tableView.mj_footer.beginRefreshing()
    }
    
    func connectionFinish(mc: MyConnection) -> Void {
        if mc.isFinish {
            self.parseData(mc.downloadData)
            tableView.reloadData()
            page += 1
        }else{
            print("网络请求失败")
        }
    }
    
    func parseData(data: NSData) -> Void {
        let obj = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        let list = obj["recommendsList"] as! [NSDictionary]
        for dict in list {
            contentArray.addObject(contentModel.modelWith(dict as! [String : AnyObject]))
            let resources = dict["filmResources"] as! NSDictionary
            titleArray.addObject(resources["title"] as! String)
            let directors = resources["directors"] as! [NSDictionary]
            directorArray.addObject(directorModel.modelWith(directors[0] as! [String : AnyObject]))
            let image = resources["images"] as! NSDictionary
            imgArray.addObject(image["small"] as! NSString)
            let casts = resources["casts"] as! [NSDictionary]
            let array =  NSMutableArray()
            for dic in casts {
                array.addObject(dic["name"] as! String)
            }
            castArray.addObject(array)
            let writer = dict["writerInfo"] as! NSDictionary
            authorArray.addObject(authorModel.modelWith(writer as! [String : AnyObject]))
        }
        tableView.mj_footer.endRefreshing()
    }

}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authorArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("newestCell", forIndexPath: indexPath) as! newestCell
        
        let authors = authorArray[indexPath.row] as! authorModel
        cell.iconView.sd_setImageWithURL(NSURL.init(string: authors.headImgUrl), placeholderImage: UIImage.init(named: "电影"))
        cell.authorL.text = authors.nickname
        cell.movieImg.sd_setImageWithURL(NSURL.init(string: imgArray[indexPath.row] as! String))
        let contents = contentArray[indexPath.row] as! contentModel
        cell.contentL.text = contents.recommend
        cell.timeL.text = timeFromInt(contents.createDate as Int)
        cell.movieNameL.text = titleArray[indexPath.row] as? String
        let directors = directorArray[indexPath.row] as! directorModel
        cell.directorL.text = directors.name
        var actors = castArray[indexPath.row] as! [String]
        var actor = ""
        for i in 0..<actors.count {
            actor += "/\(actors[i])"
        }
//        actor.removeAtIndex(actor.startIndex)
        
        if actors.count == 0 {
            cell.yanyuanL.hidden = true
        }else{
            actor.removeAtIndex(actor.startIndex)
        }
        cell.actorL.text = actor
        
        return cell
    }
    
    func timeFromInt(number: Int) -> String {
        let createTime = NSDate.init(timeIntervalSince1970: NSTimeInterval.init(number))
        var timeStr = String(createTime)
        timeStr.removeRange(Range(start: timeStr.startIndex.advancedBy(20), end: timeStr.startIndex.advancedBy(25)))
        return timeStr
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let dvc = DetailsViewController()
        let model = contentArray[indexPath.row] as! contentModel
        dvc.id = model.filmResourcesId
        self.navigationController?.pushViewController(dvc, animated: true)
        
    }
}

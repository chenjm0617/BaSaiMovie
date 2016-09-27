//
//  DetailsViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var id: String!
    var movieV: MovieView = MovieView.init(frame: CGRectMake(0, 0, SCREEN_W, 550))

    var dataArray = NSMutableArray()
    var commentArray = NSMutableArray()  //存放评论
    var userArray = NSMutableArray()  //存放评论人
    
    lazy var headView:UIView = {
        let headView = UIView.init(frame: CGRectMake(0, 64, SCREEN_W, 550))
        self.view.addSubview(headView)
        return headView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49))
        tableView.tableHeaderView = self.headView
        tableView.registerNib(UINib.init(nibName: "commentCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        tableView.estimatedRowHeight = 200
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        headView.addSubview(self.movieV)
        
        let detailsUrl = String.init(format: "http://www.moviebase.cn/uread/app/film/filmResource?platform=2&deviceId=3E272E8CED24A170CDF25B68B4FA0714&channelId=1002&appVersion=1.6.0&versionCode=1066&id=%@&sysver=5.1.1", id)
        let mc = MyConnection.init(urlStr: detailsUrl, target: self, action: #selector(self.connectionFinish(_:)), tag: 1)
        mc.start()
        
        let commentUrl = String.init(format: "http://www.moviebase.cn/uread/app/film/filmResourceComments?platform=2&deviceId=3E272E8CED24A170CDF25B68B4FA0714&channelId=1002&pageContext=1&appVersion=1.6.0&versionCode=1066&id=%@&sysver=5.1.1", id)
        let mc2 = MyConnection.init(urlStr: commentUrl, target: self, action: #selector(self.connectionFinish(_:)), tag: 2)
        mc2.start()
    }
    
    func connectionFinish(mc: MyConnection) -> Void {
        if mc.isFinish {
            if mc.tag == 1 {
                self.parseData(mc.downloadData)
                
            }else{
                self.parseCommentData(mc.downloadData)
                tableView.reloadData()
            }
        }else{
            print("网络请求失败")
        }
    }
    
    func parseCommentData(data: NSData) -> Void {
        let obj = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        let list = obj["commentList"] as! [NSDictionary]
        for dict in list {
            let infoDic = dict["commentinfo"] as! NSDictionary
            commentArray.addObject(commentModel.modelWith(infoDic as! [String : AnyObject]))
            
            let userDic = dict["userInfo"] as! NSDictionary
            userArray.addObject(userModel.modelWith(userDic as! [String : AnyObject]))
        }
    }
    
    func parseData(data: NSData) -> Void {
        let obj = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        let movieInfo = obj["movieInfo"] as! NSDictionary
        let source = movieInfo["_source"] as! NSDictionary
        let image = source["posters"] as! NSDictionary
        movieV.movieImg.sd_setImageWithURL(NSURL.init(string: image["small"] as! String))
        movieV.nameL.text = "\(source["title"]!)(\(source["year"]!))"
        self.navigationItem.title = source["title"] as? String
        movieV.ENameL.text = source["original_title"] as? String
        movieV.timeLongL.text = "时长：\(source["durations"]![0])"
        let genres = source["genres"] as! [String]
        var type = ""
        for i in 0..<genres.count {
            type += "\(genres[i]) "
        }
        movieV.typeL.text = "类型：\(type)"
        let countries = source["countries"] as! [String]
        var country = ""
        for i in 0..<countries.count {
            country += "\(countries[i]) "
        }
        movieV.countryL.text = "国家：\(country)"
        movieV.timeL.text = source["pubdates"]![0] as? String
        
        movieV.juqingContentL.text = source["summary"] as? String
        let juqingText = NSString.init(string: movieV.juqingContentL.text!)
        let juqingContentH = juqingText.boundingRectWithSize(CGSizeMake(400, 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15)], context: nil).height
        movieV.juqingContentL.frame.size.height = juqingContentH
        headView.frame.size.height = movieV.juqingContentL.frame.origin.y + movieV.juqingContentL.frame.size.height + 20
        movieV.frame.size.height = movieV.juqingContentL.frame.origin.y + movieV.juqingContentL.frame.size.height
        
        
//        //将导演模型放入数组
//        let directorArray = NSMutableArray()
//        let directors = source["directors"] as! [NSDictionary]
//        let director = directors[0]
//        let dire = director["avatar_photos"]
//        if dire != nil {
//            directorArray.addObject(director)
//        }
//        let casts = source["casts"] as! [NSDictionary]
//        if casts.count > 0 {
//            for cast in casts {
//                directorArray.addObject(cast)
//            }
//        }
//        dataArray.addObject(directorArray)
//        
//        //将花絮模型放到数组
//        let trailerArray = NSMutableArray()
//        if source["trailers"] != nil {
//            let trailers = source["trailers"] as! [NSDictionary]
//            if trailers.count > 0 {
//                for trailer in trailers {
//                    trailerArray.addObject(trailer)
//                }
//            }
//        }
//        dataArray.addObject(trailerArray)
//        
//        //将剧照模型放入数组
//        let imageArray = NSMutableArray()
//        let images = source["stage_photos"] as! [String]
//        if images.count > 0 {
//            for image in images {
//                imageArray.addObject(image)
//            }
//        }
//        dataArray.addObject(imageArray)
//        
//        print("1 \(directorArray.count)")
//        print("2 \(imageArray.count)")
//        print("3 \(trailerArray.count)")
//        print("4 \(dataArray.count)")
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! commentCell
        
        let contents = commentArray[indexPath.row] as! commentModel
        cell.contentL.text = contents.content
        cell.timeL.text = timeFromInt(Int(contents.commenttime)!)
        
        let users = userArray[indexPath.row] as! userModel
        cell.iconView.sd_setImageWithURL(NSURL.init(string: users.headImgUrl), placeholderImage: UIImage.init(named: "评论头像"))
        cell.nickL.text = users.nickname
        
        return cell
    }
    
    func timeFromInt(number: Int) -> String {
        let createTime = NSDate.init(timeIntervalSince1970: NSTimeInterval.init(number))
        var timeStr = String(createTime)
        timeStr.removeRange(Range(start: timeStr.startIndex.advancedBy(20), end: timeStr.startIndex.advancedBy(25)))
        return timeStr
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "用户评论 \(commentArray.count) 条"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

//extension DetailsViewController: UITableViewDelegate, UITableViewDataSource, movieIntroduceCellDelegate {
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return dataArray.count
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("movieIntroduceCell", forIndexPath: indexPath) as! movieIntroduceCell
//        
//        cell.indexPath = indexPath
//        print("index = \(indexPath.row)")
//        cell.delegate = self
//        
//        return cell
//        
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 200
//    }
//    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "演员"
//        }else if section == 1 {
//            return "预告片和花絮"
//        }else{
//            return "剧照"
//        }
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
//    
//    //MARK: movieIntroduceCellDelegate 协议方法
//    func numberOfItemsInRow(row: NSInteger) -> NSInteger {
//        return dataArray[row].count
//    }
//    
//    func cellForItemInRow(row: NSInteger, index: NSInteger, collectionView: UICollectionView) -> UICollectionViewCell {
//        print(row)
//        print(index)
//        if row == 0 {
//            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("actorCell", forIndexPath: NSIndexPath.init(forItem: index, inSection: 0)) as! actorCell
//            
//            return cell
//        }else if row == 1 {
//            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("noticeCell", forIndexPath: NSIndexPath.init(forItem: index, inSection: 0)) as! noticeCell
//            
//            
//            return cell
//        }else{
//            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("stillCell", forIndexPath: NSIndexPath.init(forItem: index, inSection: 0)) as! stillCell
//            
//            print(111)
//            let image = dataArray[index][row] as! String
//            cell.imageView.sd_setImageWithURL(NSURL.init(string: image))
//            
//            return cell
//        }
//    }
//    
//    func sizeForItemInRow(row: NSInteger, index: NSInteger) -> CGSize {
//        if row == 0 {
//            return CGSizeMake(100, 160)
//        }else if row == 1 {
//            return CGSizeMake(160, 80)
//        }else{
//            return CGSizeMake(130, 80)
//        }
//    }
//}

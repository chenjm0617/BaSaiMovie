//
//  MovieView.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class MovieView: UIView {

    var backView: UIView!
    var movieImg: UIImageView!
    var nameL: UILabel!
    var ENameL: UILabel!
    var countryL: UILabel!
    var typeL: UILabel!
    var timeLongL: UILabel!
    var timeL: UILabel!
    var juqingTitleL: UILabel!
    var juqingContentL: UILabel!
    var juzhaoL: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        backView = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, 200))
        backView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.addSubview(backView)
        
        movieImg = UIImageView.init(frame: CGRectMake(10, 10, 120, 180))
        backView.addSubview(movieImg)
        
        nameL = UILabel.init(frame: CGRectMake(140, 10, SCREEN_W - 200, 23))
        nameL.textColor = UIColor.whiteColor()
        nameL.font = UIFont.boldSystemFontOfSize(18)
        backView.addSubview(nameL)
        
        ENameL = UILabel.init(frame: CGRectMake(140, 40, SCREEN_W - 200, 20))
        ENameL.textColor = UIColor.whiteColor()
        ENameL.font = UIFont.systemFontOfSize(13)
        backView.addSubview(ENameL)
        
        countryL = UILabel.init(frame: CGRectMake(140, 70, SCREEN_W - 200, 20))
        countryL.textColor = UIColor.whiteColor()
        countryL.font = UIFont.systemFontOfSize(14)
        backView.addSubview(countryL)
        
        typeL = UILabel.init(frame: CGRectMake(140, 95, SCREEN_W - 200, 20))
        typeL.textColor = UIColor.whiteColor()
        typeL.font = UIFont.systemFontOfSize(14)
        backView.addSubview(typeL)
        
        timeLongL = UILabel.init(frame: CGRectMake(140, 120, SCREEN_W - 200, 20))
        timeLongL.textColor = UIColor.whiteColor()
        timeLongL.font = UIFont.systemFontOfSize(14)
        backView.addSubview(timeLongL)
        
        timeL = UILabel.init(frame: CGRectMake(140, 145, SCREEN_W - 200, 20))
        timeL.textColor = UIColor.whiteColor()
        timeL.font = UIFont.systemFontOfSize(14)
        backView.addSubview(timeL)
        
        juqingTitleL = UILabel.init(frame: CGRectMake(0, 210, SCREEN_W, 30))
        juqingTitleL.text = "  剧情介绍"
        juqingTitleL.font = UIFont.boldSystemFontOfSize(17)
        self.addSubview(juqingTitleL)
        
        juqingContentL = UILabel.init(frame: CGRectMake(20, 250, SCREEN_W - 40, 300))
        juqingContentL.textAlignment = .Left
        juqingContentL.numberOfLines = 0
        juqingContentL.font = UIFont.systemFontOfSize(15)
        self.addSubview(juqingContentL)
        
//        juzhaoL = UILabel.init(frame: CGRectMake(0, 410, SCREEN_W, 30))
//        self.addSubview(juzhaoL)
//        juzhaoL.text = "  剧照"
//        juzhaoL.font = UIFont.boldSystemFontOfSize(17)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

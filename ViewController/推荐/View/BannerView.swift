//
//  BannerView.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class BannerView: UIImageView {

    var mainTitleL: UILabel!
    var subTitleL: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainTitleL = UILabel.init(frame: CGRectMake(8, 150, SCREEN_W, 23))
        mainTitleL.textColor = UIColor.whiteColor()
        mainTitleL.font = UIFont.boldSystemFontOfSize(18)
        self.addSubview(mainTitleL)
        
        subTitleL = UILabel.init(frame: CGRectMake(8, 173, SCREEN_W, 21))
        subTitleL.textColor = UIColor.whiteColor()
        subTitleL.font = UIFont.systemFontOfSize(14)
        self.addSubview(subTitleL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

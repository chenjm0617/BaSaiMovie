//
//  CFiFthViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class CFifthViewController: UIViewController {

    var imgUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.blackColor()
        
        let imageView = UIImageView.init(frame: CGRectMake(0, (SCREEN_H - SCREEN_W + 100) / 2, SCREEN_W, SCREEN_W - 100))
        imageView.sd_setImageWithURL(NSURL.init(string: imgUrl))
        self.view.addSubview(imageView)

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }

}

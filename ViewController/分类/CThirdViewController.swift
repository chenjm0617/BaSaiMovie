//
//  CThirdViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class CThirdViewController: UIViewController {

    var imageUrl: String!
    var content: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.blackColor()
        
        self.createUI()
    }
    
    func createUI() -> Void {
        let imageView = UIImageView.init(frame: CGRectMake(0, (SCREEN_H - SCREEN_W + 100) / 2, SCREEN_W, SCREEN_W - 100))
        imageView.sd_setImageWithURL(NSURL.init(string: imageUrl))
        self.view.addSubview(imageView)
        
        let backView = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_W - 100))
        imageView.addSubview(backView)
        backView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.4)
        
        let label = UILabel.init(frame: CGRectMake(40, (imageView.frame.size.height - 100) / 2, SCREEN_W - 2 * 40, 100))
        label.textColor = UIColor.whiteColor()
        label.numberOfLines = 0
        label.textAlignment = .Center
        label.text = content
        backView.addSubview(label)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
   
}

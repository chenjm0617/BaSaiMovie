//
//  CFourthViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class CFourthViewController: UIViewController {

    var count = 0
    
    var imageArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.blackColor()
        
        self.createUI()
    }
    
    
    func createUI() -> Void {
        let label = UILabel.init(frame: CGRectMake(0, 50, SCREEN_W, 30))
        label.font = UIFont.boldSystemFontOfSize(20)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.text = "全部 \(count) 张"
        self.view.addSubview(label)
        
        let btn = UIButton.init(frame: CGRectMake(8, 30, 80, 30))
        self.view.addSubview(btn)
        btn.setImage(UIImage.init(named: "返回"), forState: UIControlState.Normal)
        btn.setTitle("返回", forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(self.backBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        let scrollView = UIScrollView.init(frame: CGRectMake(0, 80, SCREEN_W, SCREEN_H - 80))
        self.view.addSubview(scrollView)
        let imageViewW = Int((self.view.frame.size.width - 40) / 3)
        if count % 3 == 0 {
            scrollView.contentSize.height = CGFloat(count / 3 * (imageViewW + 10))
        }else{
            scrollView.contentSize.height = CGFloat((count / 3 + 1) * (imageViewW + 10))
        }
        
        for i in 0..<count {
            let imageView = UIImageView.init(frame: CGRect.init(x: 10 + i % 3 * (imageViewW + 10), y: i / 3 * (imageViewW + 10), width: imageViewW, height: imageViewW))
            imageView.sd_setImageWithURL(NSURL.init(string: imageArray[i] as! String))
            imageView.tag = 100 + i
            imageView.userInteractionEnabled = true
            scrollView.addSubview(imageView)
            
            let tapGR = UITapGestureRecognizer.init(target: self, action: #selector(self.tapGRClick(_:)))
            imageView.addGestureRecognizer(tapGR)
        }
        
    }
    
    func backBtnClick() -> Void {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func tapGRClick(tapGR: UITapGestureRecognizer) -> Void {
        let CFifthVC = CFifthViewController()
        let iv = tapGR.view as! UIImageView
        CFifthVC.imgUrl = imageArray[iv.tag - 100] as! String
        self.presentViewController(CFifthVC, animated: false, completion: nil)
    }

}

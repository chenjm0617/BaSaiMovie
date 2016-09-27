//
//  FirstViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var webViewUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.automaticallyAdjustsScrollViewInsets = false
//        HDManager.startLoading()
        self.createUI()
        
    }
    
    func createUI() -> Void {
        let wv = UIWebView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49))
        let url = NSURL.init(string: webViewUrl)
        let request = NSURLRequest.init(URL: url!)
        self.view.addSubview(wv)
        wv.loadRequest(request)
//        HDManager.stopLoading()
    }
}

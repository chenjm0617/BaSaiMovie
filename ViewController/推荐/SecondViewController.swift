//
//  SecondViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

import AVKit
import AVFoundation

class SecondViewController: UIViewController {

    var videoUrl: String!
    
    let pvc = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.playVideo()
    }
    
    func playVideo() -> Void {
        pvc.player = AVPlayer.init(URL: NSURL.init(string: videoUrl)!)
        
    #if true
        pvc.view.frame = CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49)
        self.view.addSubview(pvc.view)
    #else
        pvc.view.frame = CGRectMake(0, 64, SCREEN_W, 200)
            self.view.addSubview(pvc.view)
    #endif
        
    }

}

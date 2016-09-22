//
//  MyTabBarViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class MyTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.createTabBarVC()
        
    }
    
    func createTabBarVC() -> Void {
        let recommendVC = RecommendViewController()
        let classifyVC = ClassifyViewController()
        let discoverVC = DiscoverViewController()
        let mineVC = MineViewController()
        
        let vcArray = [recommendVC, classifyVC, discoverVC, mineVC]
        let titleArray = ["推荐", "分类", "发现", "我的"]
        var i = 0
        var viewControllers = [UINavigationController]()
        for vc in vcArray {
            let nav = UINavigationController.init(rootViewController: vc)
            let title = titleArray[i]
            nav.title = title
            let image = UIImage.init(named: title + "A")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            let imageS = UIImage.init(named: title + "B")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            let tabItem = UITabBarItem.init(title: title, image: imageS, selectedImage: image)
            nav.tabBarItem = tabItem
            tabItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.grayColor()], forState: UIControlState.Normal)
            tabItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.orangeColor()], forState: UIControlState.Selected)
            viewControllers.append(nav)
            
            i += 1
            
        }
        self.viewControllers = viewControllers
    }

}

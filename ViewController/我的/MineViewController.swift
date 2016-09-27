//
//  MineViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    
    @IBOutlet weak var iconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "我的"
        
        self.view.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.4)
        
        iconView.layer.cornerRadius = self.iconView.frame.size.height / 2
        iconView.clipsToBounds = true
    }

    @IBAction func loginBtnClick(sender: UIButton) {
        let lvc = LoginsViewController()
        self.navigationController?.pushViewController(lvc, animated: true)
        
    }
}

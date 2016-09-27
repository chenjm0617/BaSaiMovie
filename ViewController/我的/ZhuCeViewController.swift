//
//  ZhuCeViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class ZhuCeViewController: UIViewController {
    
    @IBOutlet weak var nickTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var passAgainTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func zhuceBtn(sender: UIButton) {
        if passTF.text != passAgainTF.text {
            let ac = UIAlertController.init(title: "两次输入的密码不一致", message: "请重新输入", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
            ac.addAction(action)
            self.presentViewController(ac, animated: true, completion: nil)
        }else{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

   
}

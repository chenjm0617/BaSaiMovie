//
//  LoginViewController.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class LoginsViewController: UIViewController {

    var nickTF: UITextField!
    var passTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        self.createUI()
    }
    
    func createUI() -> Void {
        nickTF = UITextField.init(frame: CGRectMake(100, 200, SCREEN_W - 200, 30))
        nickTF.borderStyle = .RoundedRect
        nickTF.placeholder = "请输入用户名"
        self.view.addSubview(nickTF)
        
        passTF = UITextField.init(frame: CGRectMake(100, 300, SCREEN_W - 200, 30))
        passTF.borderStyle = .RoundedRect
        passTF.placeholder = "请输入密码"
        self.view.addSubview(passTF)
        
        let loginBtn = UIButton.init(frame: CGRectMake(80, 400, 100, 40))
        loginBtn.backgroundColor = UIColor.grayColor()
        loginBtn.setTitle("登录", forState: UIControlState.Normal)
        loginBtn.tag = 1
        self.view.addSubview(loginBtn)
        loginBtn.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        let registerBtn = UIButton.init(frame: CGRectMake(SCREEN_W - 180, 400, 100, 40))
        registerBtn.backgroundColor = UIColor.grayColor()
        registerBtn.setTitle("注册", forState: UIControlState.Normal)
        registerBtn.tag = 2
        self.view.addSubview(registerBtn)
        registerBtn.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func btnClick(sender: UIButton) -> Void {
        if sender.tag == 1{
            let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
            if nickTF != "" && passTF != "" {
                let ac = UIAlertController.init(title: "登录成功", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                ac.addAction(action)
                self.presentViewController(ac, animated: true, completion: nil)
            }else{
                let ac = UIAlertController.init(title: "用户名密码不正确", message: "请重新输入", preferredStyle: UIAlertControllerStyle.Alert)
                ac.addAction(action)
                self.presentViewController(ac, animated: true, completion: nil)
            }
        }else{
            let zhuce = ZhuCeViewController()
            self.navigationController?.pushViewController(zhuce, animated: true)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}

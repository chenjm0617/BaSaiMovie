//
//  newestCell.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class newestCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var authorL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieNameL: UILabel!
    @IBOutlet weak var directorL: UILabel!
    @IBOutlet weak var yanyuanL: UILabel!
    @IBOutlet weak var actorL: UILabel!
    @IBOutlet weak var buttomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        iconView.layer.cornerRadius = iconView.frame.size.height / 2
        iconView.clipsToBounds = true
        
        backView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.4)
        
        buttomView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.4)
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

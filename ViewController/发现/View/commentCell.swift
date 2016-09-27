//
//  commentCell.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class commentCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nickL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var contentL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        iconView.layer.cornerRadius = self.iconView.frame.size.height / 2
        iconView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

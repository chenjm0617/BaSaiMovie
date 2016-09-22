//
//  buttomCell.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class buttomCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var nickL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  secondCell.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class secondCell: UITableViewCell {


    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var nickL: UILabel!
    @IBOutlet weak var numberL: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.4)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

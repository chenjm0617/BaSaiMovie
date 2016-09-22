//
//  TRecommendCell.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class TRecommendCell: UITableViewCell {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var numberL: UILabel!
    @IBOutlet weak var keywordL: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        keywordL.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6)
        bottomView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

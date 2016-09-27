//
//  movieIntroduceCell.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

//1，委托方第一步：声明协议
protocol movieIntroduceCellDelegate:class {
    //从ReCommendView 获取某一行的item个数
    func numberOfItemsInRow(row:NSInteger)->NSInteger
    //从ReCommendView 中获取某一个具体的cell
    func cellForItemInRow(row:NSInteger,index:NSInteger,collectionView:UICollectionView)->UICollectionViewCell
    //布局相关的，返回某一个cell的大小
    func sizeForItemInRow(row:NSInteger,index:NSInteger)->CGSize
    
}

class movieIntroduceCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //1，委托方第二步：代理指针
    weak var delegate: movieIntroduceCellDelegate!
    
    var indexPath:NSIndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionView.registerNib(UINib.init(nibName: "actorCell", bundle: nil), forCellWithReuseIdentifier: "actorCell")
        self.collectionView.registerNib(UINib.init(nibName: "noticeCell", bundle: nil), forCellWithReuseIdentifier: "noticeCell")
        self.collectionView.registerNib(UINib.init(nibName: "stillCell", bundle: nil), forCellWithReuseIdentifier: "stillCell")
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.showsHorizontalScrollIndicator = false
        
        //去掉选中效果
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: UICollectionView 协议
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.delegate.numberOfItemsInRow(self.indexPath.row)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return self.delegate.cellForItemInRow(self.indexPath.row, index: indexPath.item, collectionView: collectionView)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.delegate.sizeForItemInRow(self.indexPath.row, index: indexPath.item)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 2
    }
    
}

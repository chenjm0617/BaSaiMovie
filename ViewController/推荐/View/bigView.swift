//
//  ADScrollView.swift
//  BaSaiMovie
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 SOLO. All rights reserved.
//

import UIKit

class bigView: UIView, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var timer: NSTimer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView.init(frame: CGRectMake(0, 0, SCREEN_W, 200))
        self.addSubview(scrollView)
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        scrollView.contentOffset.x = SCREEN_W
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
        
        pageControl = UIPageControl.init(frame: CGRectMake(SCREEN_W - 350, 160, 160, 15))
        self.addSubview(pageControl)
        pageControl.numberOfPages = 4
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.timeChange), userInfo: nil, repeats: true)
        
        
    }
    
    func timeChange() -> Void {
        UIView.animateWithDuration(1) { 
            self.scrollView.contentOffset.x += SCREEN_W
            let page = ((self.scrollView.contentOffset.x - SCREEN_W) % (SCREEN_W * 6)) / self.scrollView.frame.width
            self.pageControl.currentPage = Int(page)
        }
        if scrollView.contentOffset.x == CGFloat(5) * SCREEN_W {
            scrollView.setContentOffset(CGPointMake(SCREEN_W, 0), animated: false)
            pageControl.currentPage = 0
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = (scrollView.contentOffset.x - SCREEN_W) / scrollView.frame.width
        pageControl.currentPage = Int(page)
        if scrollView.contentOffset.x == 0 {
            scrollView.setContentOffset(CGPointMake(SCREEN_W * 4, 0), animated: false)
            pageControl.currentPage = 3
        }
        if scrollView.contentOffset.x == SCREEN_W * 5 {
            scrollView.setContentOffset(CGPointZero, animated: false)
            pageControl.currentPage = 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

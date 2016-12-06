//
//  PagetitleView.swift
//  douyu
//
//  Created by qianjn on 2016/12/3.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit

class PagetitleView: UIView {

    //定义属性
    var  titles: [String]
    var titleLbabels: [UILabel] = []
    //定义懒加载属性
    lazy var scrollow: UIScrollView =  { [weak self] in
        
        let src = UIScrollView()
        src.showsHorizontalScrollIndicator = false
        src.scrollsToTop = false
        src.bounces = false
        src.frame = (self?.bounds)!
        return src
        
    }()
    
    lazy var scrollowLine: UIView = {
       
        let line = UIView()
        line.backgroundColor = UIColor.orange
        return line
    }()
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PagetitleView {
    
    fileprivate func buildUI() {
       
        //添加scrollowView
        addSubview(scrollow)
        
        
        //添加title 对应的label
        buildUpTitleLabel()
        
        //底部的线条
        buildUpBottomLine()
        
    }
    
    fileprivate func buildUpTitleLabel() {
        
        // 0.确定lable的一些frame值
        let labelW : CGFloat = frame.width/CGFloat(titles.count)
        let labelH : CGFloat = frame.height
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title;
            label.tag = index;
            label.font = UIFont.systemFont(ofSize: 15);
            label.textColor = UIColor.darkGray;
            label.textAlignment = .center
            
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //添加label到scrollow
            scrollow.addSubview(label)
            titleLbabels.append(label)
            
            //给label添加点击事件
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleClick(ges:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    private func buildUpBottomLine() {
        //底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.gray
        bottomLine.frame = CGRect(x: 0, y: scrollow.frame.height - 0.5, width: kScreenWidth, height: 0.5)
        addSubview(bottomLine)
        
        //添加滚动条
        guard let firstLabel = titleLbabels.first else { return }
        
        scrollow.addSubview(scrollowLine)
        scrollowLine.frame = CGRect(x: 0, y: scrollow.frame.height - 2, width: firstLabel.frame.width, height: 2)
    }
    
}


// MARK: - label 的点击事件
extension PagetitleView {
    @objc func titleClick(ges:UITapGestureRecognizer) {
      // printf("------")
    }
}


//
//  PagetitleView.swift
//  douyu
//
//  Created by qianjn on 2016/12/3.
//  Copyright © 2016年 SF. All rights reserved.
//

import UIKit


private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

/// 申明代理方法
protocol PagetitleViewDelegate: class {
    func pageTitleView(titleView:PagetitleView, index:NSInteger)
}


class PagetitleView: UIView {

    //定义属性
    var  titles: [String]
    var titleLbabels: [UILabel] = []
    var currentIndex:NSInteger = 0
    ///代理属性
    weak var delegate:PagetitleViewDelegate?
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
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleClick(_:)))
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
    @objc fileprivate  func titleClick(_ ges:UITapGestureRecognizer) {
        
        //当前label
        guard let currentLabel = ges.view as? UILabel else { return }
        //上次的label
        let oldLabel = titleLbabels[currentIndex]

        //更换颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag;
        
        //更新底部线条的frame
        let scrollowLineX = CGFloat(currentLabel.tag) * scrollowLine.frame.width
        
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollowLine.frame.origin.x = scrollowLineX
        })
        
        ///通知代理
        delegate?.pageTitleView(titleView: self, index: currentIndex)
    }
}


// MARK - 外界方法
extension PagetitleView {
    func setUpContentOffsetW(progress:CGFloat, sourceIndex: Int, targetIndex: Int) {
        // 1. 取出label
        let sourceLabel = titleLbabels[sourceIndex]
        let targetLabel = titleLbabels[targetIndex]
        
        //2.处理滑块
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollowLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        // 3.1 取出变化的范围(元组类型)
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 3.记录最新的index
        currentIndex = targetIndex
    }
}

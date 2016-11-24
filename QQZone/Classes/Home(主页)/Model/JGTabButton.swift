//
//  JGTabButton.swift
//  QQZone
//
//  Created by 刘军 on 2016/11/23.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

/// 按钮imageView占的比例
private let kRatio:CGFloat = 0.4

class JGTabButton: UIButton {
    
    /// 重写父类属性，取消高亮状态
    override var isHighlighted: Bool {
        didSet{
            super.isHighlighted = false
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 让图片不拉伸，居中显示
        imageView?.contentMode = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- 布局子控件
extension JGTabButton{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //根据横竖屏决定子控件的布局
        if bounds.width > bounds.height {           //横屏
            imageView?.frame = CGRect(x: 0, y: 0, width: frame.width * kRatio, height: frame.height)
            titleLabel?.frame = CGRect(x: imageView!.frame.maxX, y: 0, width: frame.width*(1-kRatio), height: frame.height)
            
        }else{   //竖屏，此时bounds.width = bounds.height
            imageView?.frame = bounds
            titleLabel?.frame = CGRect.zero
        }
        
        
    }
}

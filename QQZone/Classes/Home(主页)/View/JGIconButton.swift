//
//  JGIconButton.swift
//  QQZone
//
//  Created by 刘军 on 2016/11/22.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class JGIconButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化头像
        setImage(UIImage(named: "JG1"), for: .normal)
        setTitle("个人中心", for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- 布局子控件
extension JGIconButton{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if frame.height > frame.width { //横屏时
            imageView?.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
            titleLabel?.frame = CGRect(x: 0, y: imageView!.frame.maxY, width:kIconBtnLandscapeW , height: (bounds.height - bounds.width))
            
        }else{                              //竖屏时
            imageView?.frame = bounds
            titleLabel?.frame = CGRect.zero
        }
    }
}



//MARK:- 外界屏幕旋转时，让子控件适配
extension JGIconButton{
    func setupCurrentOritation(_ isLandscape : Bool) {
//        1、调整自己的frame
        let W:CGFloat = isLandscape ? kIconBtnLandscapeW : kIconBtnPortraitWH
        let H:CGFloat = isLandscape ? kIconBtnLandscapeH : kIconBtnPortraitWH
        let X:CGFloat = (superview!.frame.width - W) * 0.5
        let Y:CGFloat = kIconBtnY
        frame = CGRect(x: X, y: Y, width: W, height: H)
    }
}

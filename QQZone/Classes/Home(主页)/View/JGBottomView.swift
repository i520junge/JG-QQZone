//
//  JGBottomView.swift
//  QQZone
//
//  Created by 刘军 on 2016/11/22.
//  Copyright © 2016年 刘军. All rights reserved.
//


import UIKit

/// 定义协议，点击按钮，让外面控制器做事情
protocol JGBottomViewDelegate : class{  //遵守class，指定只能类遵守协议
    func bottomViewDidClickBtn(_ type:kBottomViewType)
}

enum kBottomViewType:Int {
    case mood = 0
    case photo = 1
    case blog = 2
}
class JGBottomView: UIView {
    //MARK:- 属性
    weak var delegate:JGBottomViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        //添加子控件
        setUpButton("tabbar_mood",.mood)
        setUpButton("tabbar_photo",.photo)
        setUpButton("tabbar_blog",.blog)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- 添加按钮
extension JGBottomView{
    fileprivate func setUpButton(_ imageName:String,_ type:kBottomViewType) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_separate_selected_bg"), for: .highlighted)
        btn.tag = type.rawValue
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        
        
        addSubview(btn)
    }
}


//MARK:- 外界屏幕旋转时，让子控件适配
extension JGBottomView{
    func setupCurrentOritation(_ isLandscape : Bool) {
//        0、获取子控件的个数
        let count = CGFloat(subviews.count)
        
//        1、调整自己的frame
        let W:CGFloat = superview!.frame.width  //dockView的宽度
        let H:CGFloat = isLandscape ? kDockItemH : count*kDockItemH
        let X:CGFloat = 0
        let Y:CGFloat = superview!.frame.height - H
        frame = CGRect(x: X, y: Y, width: W, height: H)
        
//        2、子控件的frame
        for(index,btn) in subviews.enumerated(){
            let btnW:CGFloat = isLandscape ? W/count : W
            let btnH:CGFloat = isLandscape ? H : kDockItemH
            let btnX:CGFloat = isLandscape ? CGFloat(index) * btnW : 0
            let btnY:CGFloat = isLandscape ? 0 : CGFloat(index) * btnH
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        }
    }
}


//MARK:- 点击按钮时，调用代理
extension JGBottomView{
    func btnClick(_ btn:UIButton) {
        delegate?.bottomViewDidClickBtn(kBottomViewType(rawValue: btn.tag)!)
    }
}




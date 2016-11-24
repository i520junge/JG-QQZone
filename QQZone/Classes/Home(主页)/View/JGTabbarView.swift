//
//  JGTabbarView.swift
//  QQZone
//
//  Created by 刘军 on 2016/11/22.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

/// 定义协议，点击item，外面做事情
protocol JGTabbarViewDelegate:class {
    func tabbarViewDidSelectedItem(_ tabbarView:JGTabbarView,_ fromIndex:Int,_ toIndex:Int)
}

class JGTabbarView: UIView {
    //MARK:- 属性
    weak var delegete:JGTabbarViewDelegate?
    fileprivate var selectBtn:JGTabButton?  //用于记录被选中按钮
    
    //MARK:- 初始化界面
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupItem("tab_bar_feed_icon", "全部动态")
        setupItem("tab_bar_passive_feed_icon", "与我相关")
        setupItem("tab_bar_pic_wall_icon", "照片墙")
        setupItem("tab_bar_e_album_icon", "电子相框")
        setupItem("tab_bar_friend_icon", "好友")
        setupItem("tab_bar_e_more_icon", "更多")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 添加子控件
extension JGTabbarView{
    fileprivate func setupItem(_ iconName : String, _ title : String) {
        let item = JGTabButton()
        
        item.setTitle(title, for: .normal)
        item.setImage(UIImage(named: iconName), for: .normal)
        item.setBackgroundImage(UIImage(named: "tabbar_separate_selected_bg"), for: .selected)
        // 将当前子控件的个数赋值给item的tag
        item.tag = subviews.count
        item.addTarget(self, action: #selector(itemClick(_:)), for: .touchDown)
        
        addSubview(item)
    }
}

//MARK:- 点击按钮，调用代理方法
extension JGTabbarView{
    @objc fileprivate func itemClick(_ item: JGTabButton) {
        delegete?.tabbarViewDidSelectedItem(self, selectBtn?.tag ?? 0, item.tag)
        
        selectBtn?.isSelected = false
        item.isSelected = true
        selectBtn = item
    }
}


//MARK:- 外界屏幕旋转时，让子控件适配
extension JGTabbarView{
    func setupCurrentOritation(_ isLandscape : Bool) {
//        0、获取子控件的个数
        let count = CGFloat(subviews.count)
        
//        1、调整自己的frame
        let W:CGFloat = superview!.frame.width  //dockView的宽度
        let H:CGFloat = count*kDockItemH
        let X:CGFloat = 0
        let Y:CGFloat = 0   //由底部view决定，所以在dockView里面底部view的frame确定后设置
        frame = CGRect(x: X, y: Y, width: W, height: H)
        
//        2、子控件的frame
        for(index,btn) in subviews.enumerated(){
            let btnW:CGFloat = W
            let btnH:CGFloat = kDockItemH
            let btnX:CGFloat = 0
            let btnY:CGFloat = btnH * CGFloat(index)
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        }
        
        
    }
}

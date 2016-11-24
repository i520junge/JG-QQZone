//
//  JGDockView.swift
//  QQZone
//
//  Created by 刘军 on 2016/11/22.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class JGDockView: UIView {
    //MARK:- 属性
    lazy var bottomView:JGBottomView = JGBottomView()
    lazy var tabbarView:JGTabbarView = JGTabbarView()
    lazy var iconBtn:JGIconButton = JGIconButton()
    
    //MARK:- 加载本类
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- 设置本类的UI控件
extension JGDockView{
    fileprivate func setUpUI() {
        
        addSubview(tabbarView)
        addSubview(bottomView)
        addSubview(iconBtn)
    }
}

//MARK:- 外界屏幕旋转时，让子控件适配
extension JGDockView{
    func setupCurrentOritation(_ isLandscape : Bool) {
        // 1、确定底部view
        bottomView.setupCurrentOritation(isLandscape)
        // 2、由底部view确定tabbarView的y
        tabbarView.setupCurrentOritation(isLandscape)
        tabbarView.frame.origin.y = frame.height - bottomView.frame.height - tabbarView.frame.height
        // 3、调整iconBtn
        iconBtn.setupCurrentOritation(isLandscape)
    }
}











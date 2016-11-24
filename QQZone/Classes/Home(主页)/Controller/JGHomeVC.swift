//
//  JGHomeVC.swift
//  QQZone
//
//  Created by 刘军 on 2016/11/22.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class JGHomeVC: UIViewController {
//MARK:- 属性
    fileprivate lazy var dockView:JGDockView = JGDockView()
    fileprivate lazy var containView:UIView = UIView()
    fileprivate var currentIndex:Int = 0    //用于记录当前点击了那个控制器
    
//MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //1、初始化UI界面
        setUpUI()
        
        //2、添加点击TabbarView展示的控制器
        setUpAllController()
        
        //3、一进来就展示个人中心
        iconBtnDidClick(iconBtn: dockView.iconBtn)
    }
    
    
    /// 设置状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
//MARK:- 设置整体UI初始化操作
extension JGHomeVC {
    fileprivate func setUpUI() {
//        1、设置背景
        view.backgroundColor = UIColor(55, 55, 55)
        
//        2、添加左边dock
        setUpDockView()
        
//        3、添加containView用于装控制器的view
        setUpContainView()
        
//        3、监听bottomView的点击(modal一个控制器)
        dockView.bottomView.delegate = self
        
//        4、监听tabbarView的点击（展示在containView上）
        dockView.tabbarView.delegete = self
        
//        5、监听iconBtn的点击（展示在containView上）
        dockView.iconBtn.addTarget(self, action: #selector(iconBtnDidClick(iconBtn:)), for: .touchUpInside)
    }
}


//MARK:- 设置dockView
extension JGHomeVC{
    fileprivate func setUpDockView() {
//        1、根据屏幕是横屏还是竖屏，设置dockView的frame
        let isLandscape = kScreenW > kScreenH
        let dockW = isLandscape ? kDockLandscapeW : kDockPortraitW
        dockView.frame = CGRect(x: 0, y: 0, width: dockW, height: view.frame.height)
        
        //设置子控件的frame
        dockView.setupCurrentOritation(isLandscape)
        
//        2、添加至view上
        view.addSubview(dockView)
    }
}

//MARK:- 设置containView
extension JGHomeVC{
    fileprivate func setUpContainView(){
        //containView的高度固定不变
        let w:CGFloat = min(kScreenH, kScreenW) - kDockPortraitW
        containView.frame = CGRect(x: dockView.frame.maxX, y: 20, width: w, height: view.bounds.height - 20)
        containView.backgroundColor = UIColor.green
        
        view.addSubview(containView)
        //屏幕即将旋转时也要改变containView的frame
    }
}

//MARK:- 添加控制器
extension JGHomeVC{
    func setUpAllController() {
        addTabbarViewChildVC(JGAllStatusVC(), UIColor.brown, "全部动态")
        addTabbarViewChildVC(UIViewController(), UIColor.blue, "与我相关")
        addTabbarViewChildVC(UIViewController(), UIColor.cyan, "照片墙")
        addTabbarViewChildVC(UIViewController(), UIColor.red, "电子相框")
        addTabbarViewChildVC(UIViewController(), UIColor.green, "好友")
        addTabbarViewChildVC(UIViewController(), UIColor.purple, "更多")
        addTabbarViewChildVC(UIViewController(), UIColor.gray, "个人中心")
    }
    
    //添加控制器
    fileprivate func addTabbarViewChildVC(_ vc:UIViewController,_ backColor:UIColor,_ title:String) {
        vc.title = title
        vc.view.backgroundColor = backColor
        let navVC = UINavigationController(rootViewController: vc)
//        navVC.title = title   //会设置不成功
        
        addChildViewController(navVC)
    }
    
}

//MARK:- 屏幕将要旋转时触发这个方法
// 注意：此时view的宽度和高度还没有改变过来，
extension JGHomeVC{
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//1、旋转时，改变dockView的宽度、高度，还有其子控件
        //let isLandscape = kScreenW > kScreenH //kScreenW是个常量，当旋转时，屏幕的高度和宽度改变了
        //动画时间等于coordinator.transitionDuration，就是屏幕旋转的时间，这样动画流畅
        UIView.animate(withDuration: coordinator.transitionDuration, animations: {
            let isLandscape = size.width > size.height
            self.dockView.frame.size.width = isLandscape ? kDockLandscapeW : kDockPortraitW
            self.dockView.frame.size.height = size.height//此时view的高度还没有改变过来，不能让它等于view.frame.size.height
            //屏幕旋转，子控件也要改变
            self.dockView.setupCurrentOritation(isLandscape)
            
//2、屏幕即将旋转时也要改变containView的frame
            self.containView.frame.origin.x = self.dockView.frame.maxX
            self.containView.frame.size.height = size.height - 20
            
        })
        
        
    }
}





//MARK:- bottomView代理
extension JGHomeVC:JGBottomViewDelegate{
    func bottomViewDidClickBtn(_ type: kBottomViewType) {
        switch type {
        case .mood:
            let moodVC = JGMoodVC()
            let moodNav = UINavigationController(rootViewController: moodVC)
            moodNav.modalTransitionStyle = .flipHorizontal
            moodNav.modalPresentationStyle = .formSheet
            present(moodNav, animated: true, completion: nil)
        case .photo:
            print("照片")
        default:
            print("博客")
        }
    }
}

//MARK:- tabbarView的代理方法
extension JGHomeVC:JGTabbarViewDelegate{
    func tabbarViewDidSelectedItem(_ tabbarView: JGTabbarView, _ fromIndex: Int, _ toIndex: Int) {
//        1、取出旧控制器，将其view从父控件中移除
        let oldVC = childViewControllers[fromIndex]
        oldVC.view.removeFromSuperview()
        
//        2、将点击的这个控制器的view展示在containView上
        let newVC = childViewControllers[toIndex]
        newVC.view.frame = containView.bounds
        containView.addSubview(newVC.view)
        
//        3、记录当前点击了哪个
        currentIndex = toIndex
    }
}

//MARK:- 监听iconBtn
extension JGHomeVC{
    func iconBtnDidClick(iconBtn:JGIconButton) {
        // 从上一个控制器跳至个人中心，个人中心添加在最后一个控制器
        tabbarViewDidSelectedItem(dockView.tabbarView, currentIndex, childViewControllers.count - 1)
    }
}


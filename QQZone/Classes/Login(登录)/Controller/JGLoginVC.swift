//
//  JGLoginVC.swift
//  QQZone
//
//  Created by 刘军 on 2016/11/22.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class JGLoginVC: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var remPwdBtn: UIButton!
    @IBOutlet weak var autoLoginBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置textField代理
        accountField.delegate = self
        pwdField.delegate = self
    }
    
    /// 设置状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}


//MARK:- 记住密码、自动登录按钮监听
extension JGLoginVC{
    @IBAction func remPwdBtnClick(_ sender: UIButton) {
        remPwdBtn.isSelected = !remPwdBtn.isSelected
        
        if remPwdBtn.isSelected == false {//记住密码没有选中，自动登录就没有被选中
            autoLoginBtn.isSelected = false
        }
    }
    
    @IBAction func autoLoginBtnClick(_ sender: UIButton) {
        autoLoginBtn.isSelected = !autoLoginBtn.isSelected
        
        if autoLoginBtn.isSelected == true {//自动登录选中，记住密码就选中
            remPwdBtn.isSelected = true
        }
    }
    
}

//MARK:- 点击登录按钮
extension JGLoginVC{
    @IBAction func loginBtnClick() {
//        1、退出键盘
        view.endEditing(true)
        
//        2、判断是否输入了帐号
        if accountField.text?.characters == nil {
            showErrorInfo("请输入账号")
            return
        }
//        3、是否输入了密码
        if pwdField.text?.characters == nil {
            showErrorInfo("请输入密码")
            return
        }
//        4、帐号、密码是否正确
        if accountField.text == "123" && pwdField.text == "123" {
            //都正确则登录成功，跳转控制器
            present(JGHomeVC(), animated: true, completion: nil)
        }else{
            showErrorInfo("请输入正确的帐号或密码")
        }
        
    }
}

//MARK:- textField代理方法，实现键盘return/done
extension JGLoginVC:UITextFieldDelegate{
    //点击了键盘的return时会触发这个方法
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //如果在输入帐号这里点了return，转向输入密码
        if textField == accountField {
            pwdField.becomeFirstResponder()
        }
        // 如果在输入密码中点了return，则登录
        else if textField == pwdField{
            loginBtnClick()
        }
        return true
    }
}

//MARK:- 弹框提醒登录状况
extension JGLoginVC{
    func showErrorInfo(_ infoStr:String) {
//        1、创建弹框控制器
        let alertController = UIAlertController(title: "登录失败", message: infoStr, preferredStyle: .alert)    //不能为actionSheet
        
//        2、设置按钮
        let action = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        
//        3、将按钮添加至控制器，并弹框
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
        
//        4、做振动提醒动画
        //①创建动画(CABasicAnimation/CAKeyframeAnimation) Basic只能添加2个点，Keyframe可添加多个临界点
        let keyframeAni = CAKeyframeAnimation(keyPath: "transform.translation.x") //水平平移x
        
        //②设置属性
        keyframeAni.values = [-10,0,10] //动画从x = -10,至x = 0 ,至x = 10
        keyframeAni.repeatCount = 5       //动画重复次数
        keyframeAni.duration = 0.1        //动画执行时间
        //③将动画添加至view的layer层
        view.layer.add(keyframeAni, forKey: nil)//keyPath用于绑定key，其他地方好拿到操控这个动画
        
    }
}


//
//  JGAllStatusVC.swift
//  QQZone
//
//  Created by 刘军 on 2016/11/23.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class JGAllStatusVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavItem()
    }


}

extension JGAllStatusVC{
    fileprivate func setUpNavItem() {
        let seg = UISegmentedControl(items: ["全部", "特别关心", "好友动态", "认证空间"])
        seg.tintColor = UIColor.gray
        //设置文字颜色
        seg.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.black], for: .normal)
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(segValueChange(_:)), for: .valueChanged)
        navigationItem.titleView = seg
        
    }
}

extension JGAllStatusVC{
    func segValueChange(_ seg:UISegmentedControl){
        switch seg.selectedSegmentIndex {
        case 0:
            view.backgroundColor = UIColor.red
        case 1:
            view.backgroundColor = UIColor.green
        case 2:
            view.backgroundColor = UIColor.white
        default:
            view.backgroundColor = UIColor.blue
        }
    }
}

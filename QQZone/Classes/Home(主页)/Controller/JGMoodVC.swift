//
//  JGMoodVC.swift
//  QQZone
//
//  Created by 刘军 on 2016/11/23.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class JGMoodVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发布心情"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(exitVC))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: nil, action: nil)
        
    }
    
    func exitVC() {
        dismiss(animated: true, completion: nil)
    }
}

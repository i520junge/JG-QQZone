//
//  UIColor+Extension.swift
//  QQZone
//
//  Created by 刘军 on 2016/11/22.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) {
        self.init(colorLiteralRed: Float(r)/255.0, green: Float(g)/255.0, blue: Float(b)/255.0, alpha: 1.0)
    }
}


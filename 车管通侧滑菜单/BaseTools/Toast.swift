//
//  Toast.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/12.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import Foundation

class Toast: NSObject {
    static func s(str: String) {
        ProgressHUD.show(str)
    }
    
    static func h() {
        ProgressHUD.dismiss()
    }
}

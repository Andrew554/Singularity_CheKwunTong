//
//  BaseViewController.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/4.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        // 设置导航栏的颜色
        self.navigationController?.navigationBar.barTintColor = barColor
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "barBack"), forBarMetrics: UIBarMetrics.Default)
        // 设置导航栏按钮的背景颜色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        // 设置导航栏字体颜色和大小
        self.navigationController?.navigationBar.titleTextAttributes = textAttrDic
        self.navigationController?.navigationBar.translucent = false
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.setBackStyle()
    }
    
    // 更改返回按钮样式
    func setBackStyle() {
        let backBar = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBar
    }
}

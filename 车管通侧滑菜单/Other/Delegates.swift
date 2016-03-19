//
//  Delegates.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/7.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import Foundation

// 协议
protocol SideMenu {
    func clickSideMenuItem(viewController: UIViewController, mark: String);
}

//
protocol RootReturnDelegate {
    func autoShowSlide()
}
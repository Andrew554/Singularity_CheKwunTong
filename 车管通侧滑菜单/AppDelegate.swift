//
//  AppDelegate.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/11/6.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    var centerView: MainViewController!
    var navCenter: UINavigationController!
    var drawerController: MMDrawerController?
    var rightView: RightViewController!
    var navRight: UINavigationController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        // 欢迎界面
        let welcome = WelcomeController()
        self.window?.rootViewController = welcome
        
        // 给闭包赋值
        welcome.startClosure = { ()-> Void in
            self.startApp()
        }
        return true
    }
    
    // 启动程序
    func startApp() {
        // 主页面的导航控制器
        self.centerView = MainViewController()
        self.navCenter = UINavigationController(rootViewController: centerView)
        
        // 侧滑菜单的导航控制器
        self.rightView = RightViewController()
        self.rightView.delegate = self.centerView
        self.navRight = UINavigationController(rootViewController: self.rightView)
        
        // 侧滑控制器
        let drawerController = MMDrawerController(centerViewController: navCenter, rightDrawerViewController: navRight)
        drawerController.maximumRightDrawerWidth = UIScreen.mainScreen().bounds.width/7*6
        
        // 给侧滑控制器设置手势
        drawerController.openDrawerGestureModeMask  = MMOpenDrawerGestureMode.All
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        
        self.window?.rootViewController = drawerController
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


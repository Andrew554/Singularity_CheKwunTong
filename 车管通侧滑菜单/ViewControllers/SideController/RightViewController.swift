//
//  RightViewController.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/11/6.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit

class RightViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: SideMenu!
    var tableView: UITableView!
    var data = [["登录/注册", "用户反馈", "推送消息"], ["检查更新", "关于软件"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        self.navigationController?.navigationBar.barTintColor = barColor
        self.navigationController?.navigationBar.titleTextAttributes = textAttrDic
        
        // 使导航栏的不透明 颜色不会和view的进行融合
        self.navigationController?.navigationBar.translucent = false
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/7*6, height: self.view.frame.height))
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.scrollEnabled = false
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    // tableView的代理方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.font = UIFont(name: "Georgia", size: 15)
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = UIColor.grayColor()
        if(indexPath.section == 0 && indexPath.row == 2) {
            let switchBtn = UISwitch()
            switchBtn.onTintColor = barColor
            switchBtn.addTarget(self, action: "switchAction:", forControlEvents: UIControlEvents.ValueChanged)
            cell.accessoryView = switchBtn
//            cell.userInteractionEnabled = false
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 取消选中状态
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        // 该cell取消选中事件
        if(indexPath.section == 0 && indexPath.row == 2) {
            return
        }
        
        // 关闭抽屉
        self.mm_drawerController.closeDrawerAnimated(true) { (close) -> Void in
            print("close")
        }
        NSLog("tableView")
        
        var viewController = UIViewController()
        var mark = ""
        if(indexPath.section == 0) {
            switch(indexPath.row) {
            case 0:
                NSLog("1")
                viewController = LoginViewController()
                mark = "login"
            case 1:
                NSLog("2")
                viewController = UserFeedBackViewController()
            default:
                viewController = LoginViewController()
            }
        }else if(indexPath.section == 1) {
            switch(indexPath.row) {
            case 0:
                NSLog("软件更新")
            case 1:
                NSLog("关于软件")
                viewController = AboutBaseController()
            default:
                NSLog("default")
            }
        }
        pushViewController(viewController, mark: mark)
    }
    
    // 回调方法
    func pushViewController(viewController: UIViewController, mark: String) {
        NSLog("\(index)")
        self.delegate.clickSideMenuItem(viewController, mark: mark)
    }
    
    // 监听switch的状态
    func switchAction(sender: UISwitch) {
        if(sender.on) {
            NSLog("on")
        } else {
            NSLog("no")
        }
    }
    
    // 对应section的顶部间隔布局的高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

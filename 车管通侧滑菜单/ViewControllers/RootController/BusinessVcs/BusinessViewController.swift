//
//  BusinessViewController.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/5.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit

class BusinessViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var typeId: Int = 0
    var titleMessage = ""   // 标题
    var plistArrayName = ""     // table数据数组
    var handNumDetailId = ""    // 获取办理人数详情的id
    
    var tv: UITableView!
    var btn: UIButton!
    var list: NSArray!
    var vcs = [UIViewController]()
    
    override func viewDidLoad() {
        self.navigationItem.title = self.titleMessage
        super.setBackStyle()
        
        initData()
        initLayout()
    }
    
    //  初始化布局
    func initLayout() {
        
        self.tv = UITableView(frame: CGRect(x: 0, y: 0, width: SW, height: SH), style: UITableViewStyle.Plain)
        self.tv.registerClass(UITableViewCell.self, forCellReuseIdentifier: "mcrCell")
        self.tv.tableFooterView = UIView()
        self.tv.delegate = self
        self.tv.dataSource = self
        self.tv.scrollEnabled = false
        self.view.addSubview(self.tv)
        
        self.btn = UIButton(frame: CGRect(x: SW/5, y: SH-120, width: SW*3/5, height: 35))
        self.btn.layer.cornerRadius = 5
        self.btn.backgroundColor = barColor
        self.btn.setTitle("办理人数详情", forState: UIControlState.Normal)
        self.btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.btn.addTarget(self, action: "handleDetail:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.btn)
    }
    
    
    // 初始化数据
    func initData() {
        self.list = PlistTool.readPlistDic("MotorVehicleBusiness")["\(self.plistArrayName)"] as! NSArray
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let view = UIView()
        view.backgroundColor = barColor
        
        let identifier = "mcrCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell?.tintColor = barColor
        
        cell?.selectedBackgroundView = view
        cell?.textLabel?.text = self.list[indexPath.row] as? String
        cell?.textLabel?.textColor = UIColor.grayColor()
        cell?.textLabel?.font = UIFont.systemFontOfSize(15)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = DetailBusinessController()
        vc.typeId = self.typeId
        vc.businessName = self.list[indexPath.row] as! String
        vc.showHandleDetailBtn = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // 设置cell的现实动画为3d缩放，xy方向的缩放动画
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.5) { () -> Void in
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }	
    
    // 办理人数详情事件
    func handleDetail(sender: UIButton){
        let handler = HandlerPeopleDetail()
        handler.typeId = 1
        self.navigationController?.pushViewController(handler, animated: true)
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

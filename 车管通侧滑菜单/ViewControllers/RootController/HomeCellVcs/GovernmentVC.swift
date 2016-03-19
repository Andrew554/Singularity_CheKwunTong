//
//  GovernmentVC.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/12.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GovernmentVC: BaseViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    var tv: UITableView!
    var lists: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    // 初始化UI
    func initUI() {
        self.navigationItem.title = "政务公开"
        self.lists = NSMutableArray()
        self.requestData()
        
        self.tv = UITableView(frame: SCREEN, style: UITableViewStyle.Plain)
        self.tv.registerClass(UITableViewCell.self, forCellReuseIdentifier: "groverCell")
        self.tv.tableFooterView = UIView()
        self.tv.delegate = self
        self.tv.dataSource = self
        self.view.addSubview(self.tv)
        
        let searchBar = UIBarButtonItem(image: UIImage(named: "search"), style: UIBarButtonItemStyle.Plain, target: self, action: "searchAction:")
        self.navigationItem.rightBarButtonItem = searchBar
    }
    
    func requestData() {
        ProgressHUD.show("数据加载中")
        Alamofire.request(.GET, "\(rootPath)\(groverment)").validate().responseJSON {
            (response)-> Void in
            switch response.result {
            case .Success(let value):
                let json = JSON(value).arrayValue
                for arr in json {
                    let dic = NSDictionary(objects: [arr["id"].int!, "\(arr["salary_title"])"], forKeys: ["id", "salary_title"])
                    self.lists?.addObject(dic)
                }
                self.tv.reloadData()
                ProgressHUD.dismiss()
            case .Failure(let error):
                print("error:\(error)")
            }
        }
    }
    
    func searchAction(sender: UIBarButtonItem) {
        let vc = SearchVC()
        print("d")
        self.navigationController?.presentViewController(vc, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lists!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "groverCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? UITableViewCell
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = self.lists![indexPath.row]["salary_title"] as? String
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell?.textLabel?.textColor = UIColor.grayColor()
        cell?.textLabel?.font = UIFont.systemFontOfSize(15)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = GovernDetailVC()
        vc.title = self.lists![indexPath.row]["salary_title"] as? String
        vc.id = self.lists![indexPath.row]["id"] as! Int
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // 设置cell的现实动画为3d缩放，xy方向的缩放动画
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.5) { () -> Void in
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
}

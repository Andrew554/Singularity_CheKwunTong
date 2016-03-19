//
//  HandlerPeopleDetail.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/5.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/**
  * 办理人数详情页面
  */
class HandlerPeopleDetail: BaseViewController, UIWebViewDelegate {
    
    var numView: UIView!
    var numLabel: UILabel!
    var wv: UIWebView!
    var segment: UISegmentedControl!
    var typeId: Int = 0
    var day_html: String = ""
    var week_html: String = ""
    var month_html: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        self.navigationItem.title = "办理人数详情"
        self.numView = UIView(frame: CGRect(x: 0, y: 0, width: SW, height: SH/15))
        self.numLabel = UILabel(frame: CGRect(x: 20, y: 5, width: self.numView.frame.width/2, height: self.numView.frame.height-10))
        self.numLabel.text = "当前办理人数：0 人"
        self.numLabel.font = UIFont.systemFontOfSize(13)
        self.numView.addSubview(self.numLabel)
        self.numView.backgroundColor = bgColor
        self.view.addSubview(self.numView)
        
        let label = UILabel(frame: CGRect(x: SW/2-25, y: self.numView.frame.maxY, width: 50, height: SH/20))
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(15)
        label.text = "数据表"
        self.view.addSubview(label)
        
        self.segment = UISegmentedControl(items: ["今日","近7天","近30天"])
        self.segment.frame = CGRect(x: SW/5, y: label.frame.maxY, width: SW*3/5, height: SH/20)
        self.segment.tintColor = barColor
        self.segment.addTarget(self, action: "segmentAction:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(self.segment)
        
        self.wv = UIWebView(frame: CGRect(x: SW/7, y: self.segment.frame.maxY+10, width: SW*5/7, height: SH-self.segment.frame.maxY-10))
        self.wv.delegate = self
        self.view.addSubview(self.wv)
        self.requestData()
    }
    
    // 请求数据
    func requestData() {
        ProgressHUD.show("数据加载中...")
        Alamofire.request(.POST, "\(rootPath)\(peopleDetailPath)\(self.typeId)").validate().responseJSON {
            response in
            switch (response.result) {
            case .Success(let value):
                let json = JSON(value)
                self.day_html = json["day_html"].string!
                self.week_html = json["week_html"].string!
                self.month_html = json["month_html"].string!
                self.loadWebView(self.day_html)
                 ProgressHUD.showSuccess("加载完成")
            case .Failure(let error):
                print("error:\(error)")
            }
        }
    }
    
    // 加载webview
    func loadWebView(str: String) {
        self.wv.loadHTMLString(str, baseURL: NSBundle.mainBundle().bundleURL)
    }
    
    func segmentAction(sender: UISegmentedControl) {
        var str: String = ""
        switch(sender.selectedSegmentIndex) {
        case 0:
            str = self.day_html
        case 1:
            str = self.week_html
        case 2:
            str = self.month_html
        default:
            str = self.day_html
        }
        loadWebView(str)
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

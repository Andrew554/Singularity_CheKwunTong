//
//  AboutSoftViewController.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/11/24.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit
import Alamofire

class AboutBaseController: BaseViewController, UIWebViewDelegate {
    
    var typeID: Int = 0
    var path: String = "http://cgt.ixp86.com/front/get_procedure_intro"
    var wb: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        initView()
        getData(path)
    }
    
    func initView() {
        self.wb = UIWebView(frame: CGRect(x: 0, y: -5, width: SW, height: SH-10))
        self.wb.backgroundColor = UIColor.whiteColor()
        // 让web content布局适应webView
//         self.wb.scalesPageToFit = true
        self.wb.delegate = self
        self.view.addSubview(self.wb)
    }
    
    // 获取网络数据
    func getData(path: String) {
        ProgressHUD.show("数据加载中")
        Alamofire.request(.GET, self.path).response { (request, response, data, error) -> Void in
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                var string: String = ""
                if(self.typeID == 0) {
                  self.navigationItem.title = "关于软件"
                  string = (jsonData!["content"] as? String)!
                }else {
                  self.navigationItem.title = "关于车管所"
                    print("\(jsonData)")
                  string = (jsonData!["about_vehicle_intro"] as? String)!
                }
                print("数据为：\(string)")
                self.loadWebView(string)
            }catch {
            }
        }
    }
    
    // 给webView加载数据
    func loadWebView(htmlStr: String) {
        dispatch_async(dispatch_get_main_queue(),
            {
                self.wb.loadHTMLString(htmlStr, baseURL: NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath))
        })
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    // 线程延迟
    func Delay(time:Double,closure:()->()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }

    func webViewDidFinishLoad(webView: UIWebView) {
         ProgressHUD.showSuccess("加载完成")
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

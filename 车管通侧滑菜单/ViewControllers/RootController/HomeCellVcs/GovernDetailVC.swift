//
//  GovernDetailVC.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/12.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GovernDetailVC: BaseViewController, UIWebViewDelegate {
    
    var id: Int = 0
    var wv: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    func initUI() {
        self.wv = UIWebView(frame: CGRect(x: 0, y: 0, width: SW, height: SH-55))
        self.wv.delegate = self
        self.view.addSubview(self.wv)
        
        requestData()
    }
    
    func requestData() {
        ProgressHUD.show("数据加载中")
        Alamofire.request(.GET, "\(rootPath)\(detailGrover)\(self.id)").validate().responseJSON{(response)-> Void in
            switch(response.result) {
            case .Success(let value):
                let json = JSON(value)
                let string = json["salary_content"].string
                self.loadData(string!)
            case .Failure(let error):
                print("error:\(error)")
            }
        }
    }
    
    func loadData(str: String) {
        self.wv.loadHTMLString(str, baseURL: NSBundle.mainBundle().bundleURL)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        ProgressHUD.dismiss()
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

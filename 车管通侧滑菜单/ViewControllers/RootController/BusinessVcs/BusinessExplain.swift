//
//  BusinessExplain.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/5.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit

/**
  * 办事说明
  */

class BusinessExplain: BaseViewController, UIWebViewDelegate {
    
    var wv: UIWebView!
    var htmlUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wv = UIWebView(frame: SCREEN)
        self.wv.delegate = self
        self.view.addSubview(self.wv)
        self.wv.loadHTMLString(self.htmlUrl, baseURL: NSBundle.mainBundle().bundleURL)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        ProgressHUD.show("数据加载中")
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

//
//  UserFeedBackViewController.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/11/9.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit

class UserFeedBackViewController: BaseViewController, UITextViewDelegate {

    var textView: UITextView!
    var btnCommit: UIButton!
    var btnCancel: UIButton!
    var placeholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "用户反馈"
        initLayout()
    }
    
    //  初始化布局
    func initLayout() {
        self.textView = UITextView(frame: CGRect(x: SW/10, y: SH/10, width: SW*4/5, height: SH/3))
        self.textView.layer.cornerRadius = 5
        
        let font = UIFont(name: "Georgia", size: 15)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let attributes = [NSFontAttributeName: font!, NSParagraphStyleAttributeName: paragraphStyle] as[String: AnyObject]
        self.textView.font = font
        self.textView.attributedText = NSAttributedString(string: self.textView.text, attributes: attributes)
        self.textView.layer.cornerRadius = 5
        self.textView.layer.borderColor = UIColor.grayColor().CGColor
        self.textView.layer.borderWidth = 1
        self.textView.delegate = self
        self.view.addSubview(self.textView)
        
        self.placeholder = UILabel(frame: CGRect(x: 5, y: 8, width: self.textView.frame.width, height: 10))
        self.placeholder.text = "您的建议是我们前进的最大动力！"
        self.placeholder.textColor = UIColor.grayColor()
        self.textView.addSubview(self.placeholder)
        
        self.btnCommit = UIButton(frame: CGRect(x: SW/10, y: self.textView.frame.maxY+30, width: self.textView.frame.width*2/5, height: 40))
        self.btnCommit.setTitle("提交", forState: UIControlState.Normal)
        self.btnCommit.layer.cornerRadius = 5
        self.btnCommit.clipsToBounds = true
        self.btnCommit.setBackgroundImage(UIImage(named: "btn_登录"), forState: UIControlState.Normal)
        self.btnCommit.setBackgroundImage(UIImage(named: "btn_登录_hover"), forState: UIControlState.Highlighted)
        self.btnCommit.tag = 23
        self.btnCommit.addTarget(self, action: "clickBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.btnCancel = UIButton(frame: CGRect(x: self.btnCommit.frame.maxX + self.textView.frame.width/5, y: self.textView.frame.maxY+30, width: self.textView.frame.width*2/5, height: 40))
        self.btnCancel.setTitle("取消", forState: UIControlState.Normal)
        self.btnCancel.layer.cornerRadius = 5
        self.btnCancel.clipsToBounds = true
        self.btnCancel.setBackgroundImage(UIImage(named: "btn_注册"), forState: UIControlState.Normal)
        self.btnCancel.setBackgroundImage(UIImage(named: "btn_注册_hover"), forState: UIControlState.Highlighted)
        self.btnCancel.tag = 24
        self.btnCancel.addTarget(self, action: "clickBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(self.btnCommit)
        self.view.addSubview(self.btnCancel)
    }
    
    func clickBtn(sender: UIButton) {
        switch(sender.tag) {
            case 23:
                ProgressHUD.show("提交中...")
            case 24:
                self.navigationController?.popViewControllerAnimated(true)
                ProgressHUD.dismiss()
            default:
                print("default")
        }
        
//        let delayTime = dispatch_time(DISPATCH_TIME_NOW, (Int64)(2.0))
//
//        // 线程延迟5秒
//        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
//            print("dispatch_after")
//            ProgressHUD.dismiss()
//        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.placeholder.hidden = true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.placeholder.hidden = false
//        if let str = (self.placeholder.text! as String) {
//            if(str.count > 0) {
//            }
//        }
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

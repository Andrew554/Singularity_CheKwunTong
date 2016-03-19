//
//  LoginViewController.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/11/9.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// 声明一个闭包类型
typealias sendValueClosure=(string: String)-> Void

class LoginViewController: BaseViewController, UITextFieldDelegate {
    var identifier = ""
    var accountImage: UIImageView!
    var accountTextField: UITextField!
    var pwdImage: UIImageView!
    var pwdTextField: UITextField!
    var loginBtn: UIButton!
    var cancel: UILabel!
    var losePw: UILabel!
    var registe: UILabel!
    
    // 一个闭包属性
    var closure: sendValueClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "登录"
        initLayout()
    }
    
    // 初始化布局
    func initLayout() {
        self.cancel = UILabel(frame: CGRect(x: SW*3/4, y: 50, width: 40, height: 20))
        self.cancel.text = "取消"
        self.cancel.textColor = barColor
        self.cancel.tag = 101
        self.cancel.userInteractionEnabled = true
        let cancelGestrue = UITapGestureRecognizer(target: self, action: "clickLabel:")
        self.cancel.addGestureRecognizer(cancelGestrue)
        self.view.addSubview(self.cancel)
        
        self.accountImage = UIImageView(frame: CGRect(x: SW/10, y: SH/5, width: SH/20, height: SH/20))
        self.accountImage.image = UIImage(named: "email")
        
        self.accountTextField = UITextField(frame: CGRect(x: self.accountImage.frame.maxX + 30, y: self.accountImage.frame.minY, width: SW*3/5, height: self.accountImage.frame.height))
        self.accountTextField.placeholder = "请输入邮箱/手机号"
        self.accountTextField.adjustsFontSizeToFitWidth = true
        self.accountTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.accountTextField.keyboardType = UIKeyboardType.EmailAddress
        self.accountTextField.delegate = self
        
        let view1 = UIView(frame: CGRect(x: SW/12, y: self.accountImage.frame.maxY + 10, width: SW*5/6, height: 1))
        view1.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(view1)
        
        self.pwdImage = UIImageView(frame: CGRect(x: SW/10, y: self.accountImage.frame.maxY + 30, width: SH/20, height: SH/20))
        self.pwdImage.image = UIImage(named: "password")
        self.pwdTextField = UITextField(frame: CGRect(x: self.pwdImage.frame.maxX + 30, y:self.pwdImage.frame.minY, width: SW*3/5, height: self.pwdImage.frame.height))
        self.pwdTextField.placeholder = "请输入密码"
        self.pwdTextField.adjustsFontSizeToFitWidth = true
        self.pwdTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.pwdTextField.secureTextEntry = true
        self.pwdTextField.keyboardType = UIKeyboardType.Default
        self.pwdTextField.delegate = self
        
        let view2 = UIView(frame: CGRect(x: SW/12, y: self.pwdImage.frame.maxY + 10, width: SW*5/6, height: 1))
        view2.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(view2)
        
        self.loginBtn = UIButton(frame: CGRect(x: SW/12, y: self.pwdTextField.frame.midY+100, width: SW*5/6, height: 40))
        self.loginBtn.setTitle("登录", forState: UIControlState.Normal)
        self.loginBtn.setBackgroundImage(UIImage(named: "btn_登录"), forState: UIControlState.Normal)
        self.loginBtn.setBackgroundImage(UIImage(named: "btn_登录_hover"), forState: UIControlState.Highlighted)
        self.loginBtn.layer.cornerRadius = 5
        self.loginBtn.addTarget(self, action: "login:", forControlEvents: UIControlEvents.TouchUpInside)
        self.loginBtn.clipsToBounds = true
        
        self.registe = UILabel(frame: CGRect(x: SW/3, y: SH-30, width: 40, height: 20))
        self.registe.textColor = UIColor.lightGrayColor()
        self.registe.font = UIFont.systemFontOfSize(13)
        self.registe.text = "注册"
        self.registe.tag = 102
        let registeGesture = UITapGestureRecognizer(target: self, action: "clickLabel:")
        self.registe.addGestureRecognizer(registeGesture)
        self.view.addSubview(self.registe)
        
        let viewLine = UIView(frame: CGRect(x: SW/2, y: SH-35, width: 1, height: 30))
        viewLine.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(viewLine)
        
        self.losePw = UILabel(frame: CGRect(x: SW/2 + 25, y: SH-30, width: 60, height: 20))
        self.losePw.textColor = UIColor.lightGrayColor()
        self.losePw.text = "忘记密码"
        self.losePw.font = UIFont.systemFontOfSize(13)
        self.losePw.tag = 103
        let loseGesture = UITapGestureRecognizer(target: self, action: "clickLabel:")
        self.losePw.addGestureRecognizer(loseGesture)
        self.view.addSubview(self.losePw)
        
        self.view.addSubview(self.accountTextField)
        self.view.addSubview(self.accountImage)
        self.view.addSubview(self.pwdImage)
        self.view.addSubview(self.pwdTextField)
        self.view.addSubview(self.loginBtn)
    }
    
    // 赋值闭包的方法
    func initClosure(closure: (string: String)->Void) {
        self.closure = closure
    }
    
    // 登录
    func login(sender: UIButton) {
        self.accountTextField.resignFirstResponder()
        self.pwdTextField.resignFirstResponder()
        var c: Bool
        c = confirmInput()
        if(c == true) {
            loginRequest()
            ProgressHUD.show("登录中...")
        } else {
            let alertController = UIAlertController(title: "提示信息", message: "账号和密码不能为空!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "确认", style: UIAlertActionStyle.Destructive, handler: { (UIAlertAction) -> Void in
            }))
            // 显示alert
            self.presentViewController(alertController, animated: true, completion: { () -> Void in
            })
        }
    }
    
    // 验证输入
    func confirmInput()-> Bool {
        if(self.accountTextField.text == "" || self.pwdTextField.text == "") {
            print("confirm")
                return false
        }
        return true
    }
    
    // 登录请求
    func loginRequest() {
        let account = self.accountTextField.text!
        let pwd = self.pwdTextField.text!
        print("login:\(account):\(pwd)")
        Alamofire.request(.POST, "\(rootPath)\(loginPath)?login=\(account)&password=\(pwd)").validate().responseJSON { (response) -> Void in
            switch response.result{
            case .Success(let value):
                print("value:\(value)")
                let json = JSON(value)
//                let token = json["token"] as! NSData
                let userJson = json["user"].dictionary
                let id = userJson!["id"]!.int
                let name = userJson!["name"]!.string
                let user = User(id: id!, name: name!)
                self.saveUserInfo(user)
                self.dismissViewControllerAnimated(true, completion: nil)
                ProgressHUD.showSuccess("登录成功!!!")
            case .Failure(let error):
                ProgressHUD.showError("登录失败...")
                print("error:\(error)")
            }
        }
    }
    
    // 保存登录信息
    func saveUserInfo(user: User) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(user.authentication_token, forKey: "authentication_token")
        // 调用闭包 
        if (self.closure != nil) {
            closure!(string: self.accountTextField.text! as String)
        }
    }
    //  注册
    func registe(sender: UIBarButtonItem) {
        ProgressHUD.show("注册中》》》")
//        self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
//            print("diss")
//        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    func clickLabel(sender: UIGestureRecognizer) {
        let view = sender.view
        switch(view!.tag) {
        case 101:
            self.dismissViewControllerAnimated(true) { () -> Void in
                print("fock")
            }
        case 102:
            print("注册")
        case 103:
            print("忘记密码")
//        case 104:
        default:
            print("default")
        }
    }
    
    // 监听键盘返回键
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.accountTextField.resignFirstResponder()
        self.pwdTextField.resignFirstResponder()
        return true
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


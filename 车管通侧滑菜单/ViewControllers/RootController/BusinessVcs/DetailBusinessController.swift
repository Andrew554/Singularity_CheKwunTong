//
//  DetailBusinessController.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/5.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

 /*
  * 业务页面
  */

class DetailBusinessController: BaseViewController, UIScrollViewDelegate, UIWebViewDelegate {
    var typeId: Int = 0
    var businessName = ""   // 当前现实业务名称
    var showHandleDetailBtn = true // 是否现实办理人数详情按钮
    var businessData: NSDictionary!   // 根据业务名称得到数据
    var urlPath = ""    // 当前业务的数据
    var explain = ""    // 关于业务的网络数据请求地址
    var sc: UIScrollView!
    var wv: UIWebView!
    var image: UIImageView!
    var images: NSArray!
    var btn: UIButton!
    
    var explainBtn: UIBarButtonItem!
    var btnLeft: UIButton!
    var btnRight: UIButton!
    var slider: UIView!
    var segment: UISegmentedControl!
    var imgIndex: Int = 0
    var barView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.businessName
        self.view.backgroundColor = UIColor.whiteColor()
        initData()
        initLayout()
    }
    
    // 初始化布局
    func initLayout() {
        self.barView = UIView()
        self.barView.backgroundColor = barColor
        
        self.btnLeft = self.initButton("办事指南", fX: 0, tag: 11)
        self.btnRight = self.initButton("流程导航", fX: self.btnLeft.frame.maxX, tag: 12)
        
        self.view.addSubview(self.btnLeft)
        self.view.addSubview(self.btnRight)
        
        let slideBg = UIView(frame: CGRect(x: 0, y: self.btnLeft.frame.maxY-1, width: SW, height: 1))
        slideBg.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(slideBg)
        
        self.slider = UIView(frame: CGRect(x: 0, y: self.btnLeft.frame.maxY-3, width: SW/2, height: 3))
        self.slider.backgroundColor = UIColor(patternImage: UIImage(named: "line")!)
        self.view.addSubview(self.slider)
       
        self.btn = UIButton(frame: CGRect(x: SW/5, y: SH-120, width: SW*3/5, height: 35))
        self.btn.layer.cornerRadius = 5
        self.btn.backgroundColor = barColor
        self.btn.setTitle("办理人数详情", forState: UIControlState.Normal)
        self.btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.btn.addTarget(self, action: "handleDetail:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // initRightUI
        self.segment = UISegmentedControl(items: ["上一步","下一步","开始导航"])
        self.segment.tintColor = barColor
        self.segment.frame = CGRect(x: SW/5, y: SH-120, width: SW*3/5, height: 30)
        self.segment.addTarget(self, action: "segmentAction:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(self.segment)
        self.segment.hidden = true
        
        self.sc = UIScrollView(frame: CGRect(x: 0, y: self.btnLeft.frame.height, width: SW, height: SH-70-65-self.btnLeft.frame.height))
        if(self.showHandleDetailBtn == true) {
            self.view.addSubview(self.btn)
        }else {

        }
        
        self.sc.contentSize = CGSize(width: SW*2, height: self.sc.frame.height)
        self.sc.bouncesZoom = false
        self.sc.pagingEnabled = true
        self.sc.showsHorizontalScrollIndicator = false
        self.sc.delegate = self

        self.wv = UIWebView(frame: CGRect(x: 0, y: 0, width: self.sc.frame.width, height: self.sc.frame.height))
        self.wv.delegate = self
        self.sc.addSubview(self.wv)
        self.view.addSubview(self.sc)
        
        self.images = ["map_A1", "map_b1", "map_b2a", "map_b2b"]
        self.image = UIImageView(frame: CGRect(x: SW/4, y: 0, width: self.sc.frame.width/2, height: self.sc.frame.height))
        self.image.frame.origin.x = SW*5/4
        self.image.image = UIImage(named: "map_A1")
        self.sc.addSubview(self.image)
        
        // 右边导航按钮
        self.explainBtn = UIBarButtonItem(image: UIImage(named: "IconBangzhu"), style: UIBarButtonItemStyle.Plain, target: self, action: "explainClick:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.barView)
        // 请求数据
        requestData()
    }
    
    //  自定义初始化button方法
    func initButton(title: String, fX: CGFloat, tag: Int)-> UIButton {
        let btn = UIButton(type: UIButtonType.RoundedRect)
        btn.frame = CGRect(x: fX, y: 0, width: SW/2, height: 40)
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.whiteColor()
        btn.tag = tag
        btn.addTarget(self, action: "clickBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }
    
    // 初始化数据
    func initData() {
        self.businessData = PlistTool.readPlistDic("AllOrderList")
        self.urlPath = "\(rootPath)\(self.businessData[self.businessName]!["business"] as! String)"
    }
    
    // 数据请求
    func requestData() {
        ProgressHUD.show("数据加载中")
        print("url:\(self.urlPath)")
        Alamofire.request(.GET, "\(self.urlPath)").validate().responseJSON { (response) -> Void in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let html = json["companion"].string
                    let explainStr = json["explain"].string
                    self.explain = explainStr!
                    self.loadWebView(html!)
                }
            case .Failure(let error):
                print("error:\(error)")
            }
        }
    }
    
    // webView加载数据
    func loadWebView(htmlStr: String) {
        dispatch_async(dispatch_get_main_queue(),
            {
                self.wv.loadHTMLString(htmlStr, baseURL: NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath))
        })
    }
    
    // 办事说明按钮事件
    func explainClick(sender: UIBarButtonItem) {
        let businessExplain = BusinessExplain()
        businessExplain.htmlUrl = self.explain
        self.navigationController?.pushViewController(businessExplain, animated: true)
    }
    
    // 办理人数详情事件
    func handleDetail(sender: UIButton){
        let handler = HandlerPeopleDetail()
        handler.typeId = self.typeId
        self.navigationController?.pushViewController(handler, animated: true)
    }
    
    // 导航切换页面按钮点击
    func clickBtn(sender: UIButton){
        var setPoint: CGFloat!
        switch(sender.tag) {
        case 11:
            setPoint = CGFloat(0)*SW
            self.btn.hidden = false
            self.segment.hidden = true
        case 12:
            setPoint = CGFloat(1)*SW
            self.btn.hidden = true
            self.segment.hidden = false
        default:
            print("")
        }
        changeShowContent(setPoint)
        self.sc.contentOffset.x = setPoint
    }
    
    // segment的事件
    func segmentAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("上一页")
            self.imgIndex++
        case 1:
            print("下一页")
            self.imgIndex--
        default:
            print("default")
        }
        
        if(self.imgIndex < 0) {
            self.imgIndex = self.images.count-1
        }
        if(self.imgIndex > self.images.count-1) {
            self.imgIndex = 0
        }
        // 更改图片
        self.image.image = UIImage(named: self.images[self.imgIndex] as! String)
    }
    
    // 改变slide的位置
    func changeShowContent(point: CGFloat) {
        switch(point) {
        case CGFloat(0):
            self.btn.hidden = false
            self.segment.hidden = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.barView)
        case CGFloat(1*SW):
            self.btn.hidden = true
            self.segment.hidden = false
            self.navigationItem.rightBarButtonItem = self.explainBtn
        default: break
        }
        // 动画
        UIView.animateWithDuration(1.0) { () -> Void in
            self.slider.frame = CGRect(x: point/2, y: self.btnLeft.frame.maxY-3, width: SW/2, height: 3)
        }
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
    }
    
    // 网页加载完成
    func webViewDidFinishLoad(webView: UIWebView) {
        ProgressHUD.dismiss()
    }
    
    // 当点击之后停止滑动就调用（手指还未放开）时刻监听
    func scrollViewDidScroll(scrollView: UIScrollView) {
        changeShowContent(self.sc.contentOffset.x)
    }
    
    // 当滑动完成之后  放开屏幕之后才调用
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
       
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

//
//  WelcomeController.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/4.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit

class WelcomeController: BaseViewController, UIScrollViewDelegate {
    // 闭包属性 用于跳转页面
    var startClosure: (()->Void)?
    var sc: UIScrollView!
    var imagePath = NSArray()
    var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePath = ["bootstrap_1", "bootstrap_2"]
        print("welcome")
        initLayout()
    }
    
    func initLayout() {
        self.sc = UIScrollView(frame: CGRect(x: 0, y: 0, width: SW, height: SH))
        self.sc.bouncesZoom = false
        self.sc.pagingEnabled = true
        self.sc.contentSize = CGSize(width: SW*2, height: SH)
        self.sc.showsHorizontalScrollIndicator = false
        self.sc.delegate = self
        
       for var i = 0 ; i < 2 ; i++ {
            let image = UIImage(named: self.imagePath[i] as! String)
            let imageView = UIImageView(frame: self.view.frame)
            imageView.image = image
//            var frame = imageView.frame
//            // x轴等于当前的i乘以宽度  等于偏移宽度
//            frame.origin.x = CGFloat(i) * frame.size.width
            // 设置imageView的frame
            imageView.frame.origin.x = CGFloat(i) * SW
            if(i == 1) {
                self.btn = UIButton(frame: CGRect(x: 120, y: imageView.frame.maxY-200, width: SW-240, height: 35))
                self.btn.setTitle("马上体验", forState: UIControlState.Normal)
                self.btn.backgroundColor = barColor
                self.btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                self.btn.layer.cornerRadius = 10
                self.btn.addTarget(self, action: "startAction:", forControlEvents: UIControlEvents.TouchUpInside)
                imageView.addSubview(self.btn)
                imageView.userInteractionEnabled = true
            }
            self.sc.addSubview(imageView)
        }
        
        self.view.addSubview(self.sc)
    }
    
    // 马上体验
    func startAction(sender: UIButton) {
        startClosure!()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
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

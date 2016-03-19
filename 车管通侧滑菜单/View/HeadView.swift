//
//  HeadView.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/1.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit

protocol RootViewDelegate {
    func gestureAction(view: UIView)
    func homeCellTap(view: UIView)
}

class HeadView: UIView {
    
    var num1_1: Int = 0
    var label1_1_2: UILabel!
    var num1_2: Int = 0
    var label1_1_3: UILabel!
    
    var num1_3: Int = 0
    var label1_2_2: UILabel!
    var num1_4: Int = 0
    var label1_3_2: UILabel!
    
    var num2_1: Int = 0
    var label2_1_2: UILabel!
    var num2_2: Int = 0
    var label2_2_2: UILabel!
    var num2_3: Int = 0
    var label2_3_2: UILabel!
    
    var view1 = UIView()
    var view2 = UIView()
    
    var delegate: RootViewDelegate!
    
//    convenience init() {
//        self.init(frame: CGRect(x:0, y:0, width:20, height:20))
//        print("ddd")
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initLayout()
        print("init header")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化布局
    func initLayout() {
        initLayout1()
        initLayout2()
    }
    
    // 视图板块一
    func initLayout1() {
        self.view1.frame = CGRect(x: 5, y: 10, width: SW-10, height: SH/4)
        view1.backgroundColor = UIColor.whiteColor()
        
        /*-----1_1-----*/
        let view1_1 = UIView(frame: CGRect(x: 5, y: 0, width: SW/2-5, height: SH/4))
        view1_1.tag = 1101
        
        //-----机动车登记业务-----
        let label1_1_1 = UILabel(frame: CGRect(x: 10, y: 10, width: view1_1.frame.width-10, height: view1_1.frame.height/6))
        label1_1_1.textAlignment = NSTextAlignment.Left
        label1_1_1.font = UIFont.boldSystemFontOfSize(14)
        label1_1_1.text = "机动车登记业务"
        view1_1.addSubview(label1_1_1)
        
        //-----办理人数-----
        self.label1_1_2 = UILabel(frame: CGRect(x: 10, y: label1_1_1.frame.maxY, width: label1_1_1.frame.width*3/5, height: label1_1_1.frame.height))
        label1_1_2.textAlignment = NSTextAlignment.Left
        label1_1_2.font = UIFont.boldSystemFontOfSize(13)
        label1_1_2.textColor = UIColor.orangeColor()
        label1_1_2.text = "办理人数：\(self.num1_1)"
        view1_1.addSubview(label1_1_2)
        
        //-----排队人数-----
        self.label1_1_3 = UILabel(frame: CGRect(x: 10, y: label1_1_2.frame.maxY, width: label1_1_1.frame.width*3/5, height: label1_1_2.frame.height))
        label1_1_3.textAlignment = NSTextAlignment.Left
        label1_1_3.font = UIFont.boldSystemFontOfSize(13)
        label1_1_3.textColor = UIColor.orangeColor()
        label1_1_3.text = "排队人数：\(self.num1_2)"
        view1_1.addSubview(label1_1_3)
        
        //-----图片-----
        let image1_1 = UIImageView(frame: CGRect(x: label1_1_3.frame.maxX - 10, y: label1_1_3.frame.maxY+5, width: label1_1_1.frame.width*2/5, height: label1_1_1.frame.width*2/7))
        image1_1.image = UIImage(named: "首页3_15")
        view1_1.addSubview(image1_1)
        
        /*-----1_2-----*/
        let view1_2 = UIView(frame: CGRect(x: SW/2, y: 0, width: SW/2-5, height: SH/8))
        view1_2.tag = 1102
        
        //-----路桥刷卡-----
        let label1_2_1 = UILabel(frame: CGRect(x: 10, y: 10, width: view1_2.frame.width*3/5, height: view1_2.frame.height/3))
        label1_2_1.textAlignment = NSTextAlignment.Left
        label1_2_1.font = UIFont.boldSystemFontOfSize(14)
        label1_2_1.text = "路桥刷卡"
        view1_2.addSubview(label1_2_1)
        
        //-----办理人数-----
        self.label1_2_2 = UILabel(frame: CGRect(x: 10, y: label1_2_1.frame.maxY, width: label1_2_1.frame.width, height: label1_2_1.frame.height))
        label1_2_2.textAlignment = NSTextAlignment.Left
        label1_2_2.font = UIFont.boldSystemFontOfSize(13)
        label1_2_2.textColor = UIColor.orangeColor()
        label1_2_2.text = "办理人数：\(self.num1_3)"
        view1_2.addSubview(label1_2_2)
        
        //-----图片-----
        let image1_2 = UIImageView(frame: CGRect(x: label1_2_1.frame.maxX, y: label1_2_1.frame.minY+8, width: label1_2_1.frame.height*8/5, height: label1_2_1.frame.height*8/5))
        image1_2.image = UIImage(named: "首页3_10")
        view1_2.addSubview(image1_2)
        
        /*---1_3---*/
        let view1_3 = UIView(frame: CGRect(x: SW/2, y: SH/8, width: SW/2-5, height: SH/8))
        view1_3.tag = 1103

        //-----交通违法处理-----
        let label1_3_1 = UILabel(frame: CGRect(x: 10, y: 10, width: view1_3.frame.width*3/5, height: view1_3.frame.height/3))
        label1_3_1.textAlignment = NSTextAlignment.Left
        label1_3_1.font = UIFont.boldSystemFontOfSize(14)
        label1_3_1.text = "交通违法处理"
        view1_3.addSubview(label1_3_1)
        
        //-----办理人数-----
        self.label1_3_2 = UILabel(frame: CGRect(x: 10, y: label1_3_1.frame.maxY, width: label1_3_1.frame.width, height: label1_3_1.frame.height))
        label1_3_2.textAlignment = NSTextAlignment.Left
        label1_3_2.font = UIFont.boldSystemFontOfSize(13)
        label1_3_2.textColor = UIColor.orangeColor()
        label1_3_2.text = "办理人数：\(self.num1_4)"
        view1_3.addSubview(label1_3_2)
        
        //-----图片-----
        let image1_3 = UIImageView(frame: CGRect(x: label1_3_1.frame.maxX+10, y: label1_3_1.frame.minY+8, width: label1_3_1.frame.height*8/5, height: label1_3_1.frame.height*8/5))
        image1_3.image = UIImage(named: "首页3_19")
        view1_3.addSubview(image1_3)
        
        // 为各个view添加手势
        let gestureTap1 = UITapGestureRecognizer(target: self, action: "gestureAction:")
        view1_1.addGestureRecognizer(gestureTap1)
        let gestureTap2 = UITapGestureRecognizer(target: self, action: "gestureAction:")
        view1_2.addGestureRecognizer(gestureTap2)
        let gestureTap3 = UITapGestureRecognizer(target: self, action: "gestureAction:")
        view1_3.addGestureRecognizer(gestureTap3)
        
        self.view1.addSubview(view1_1)
        self.view1.addSubview(view1_2)
        self.view1.addSubview(view1_3)
        
        // 描线
        let line1_1 = UIView(frame: CGRect(x: SW/2, y: self.view1.frame.minX-5, width: 1, height: self.view1.frame.height))
        line1_1.backgroundColor = UIColor.lightGrayColor()
        self.view1.addSubview(line1_1)
        let line1_2 = UIView(frame: CGRect(x: SW/2, y: self.view1.frame.height/2, width: self.view1.frame.width/2-5, height: 1))
        line1_2.backgroundColor = UIColor.lightGrayColor()
        self.view1.addSubview(line1_2)
        
        self.addSubview(self.view1)
    }
    
    // 视图板块二
    func initLayout2() {
        self.view2.frame = CGRect(x: 5, y: self.view1.frame.maxY + 7, width: SW-10, height: SH/4)
        view2.backgroundColor = UIColor.whiteColor()
        
        /*-----2_1-----*/
        let view2_1 = UIView(frame: CGRect(x: 5, y: 0, width: SW/2-5, height: SH/8))
        view2_1.tag = 2101
    
        //-----其他机动车业务-----
        let label2_1_1 = UILabel(frame: CGRect(x: 10, y: 10, width: view2_1.frame.width*7/10, height: view2_1.frame.height/3))
        label2_1_1.textAlignment = NSTextAlignment.Left
        label2_1_1.font = UIFont.boldSystemFontOfSize(14)
        label2_1_1.text = "其他机动车业务"
        view2_1.addSubview(label2_1_1)
        
        //-----办理人数-----
        self.label2_1_2 = UILabel(frame: CGRect(x: 10, y: label2_1_1.frame.maxY, width: label2_1_1.frame.width, height: label2_1_1.frame.height))
        label2_1_2.textAlignment = NSTextAlignment.Left
        label2_1_2.font = UIFont.boldSystemFontOfSize(13)
        label2_1_2.textColor = UIColor.orangeColor()
        label2_1_2.text = "办理人数：\(self.num2_1)"
        view2_1.addSubview(label2_1_2)

        //-----图片-----
        let image2_1 = UIImageView(frame: CGRect(x: label2_1_1.frame.maxX-5, y: label2_1_1.frame.minY+8, width: label2_1_1.frame.height*7/5, height: label2_1_1.frame.height*7/5))
        image2_1.image = UIImage(named: "首页3_24")
        view2_1.addSubview(image2_1)
        
        /*-----2_2-----*/
        let view2_2 = UIView(frame: CGRect(x: 5, y: SH/8, width: SW/2-5, height: SH/8))
        view2_2.tag = 2102
        //-----免检业务-----
        let label2_2_1 = UILabel(frame: CGRect(x: 10, y: 10, width: view2_1.frame.width*7/10, height: view2_1.frame.height/3))
        label2_2_1.textAlignment = NSTextAlignment.Left
        label2_2_1.font = UIFont.boldSystemFontOfSize(14)
        label2_2_1.text = "免检业务"
        view2_2.addSubview(label2_2_1)
        
        //-----办理人数-----
        self.label2_2_2 = UILabel(frame: CGRect(x: 10, y: label2_2_1.frame.maxY, width: label2_2_1.frame.width, height: label2_2_1.frame.height))
        label2_2_2.textAlignment = NSTextAlignment.Left
        label2_2_2.font = UIFont.boldSystemFontOfSize(13)
        label2_2_2.textColor = UIColor.orangeColor()
        label2_2_2.text = "办理人数：\(self.num2_2)"
        view2_2.addSubview(label2_2_2)
        
        //-----图片-----
        let image2_2 = UIImageView(frame: CGRect(x: label2_2_1.frame.maxX-5, y: label2_2_1.frame.minY+8, width: label2_2_1.frame.height*7/5, height: label2_2_1.frame.height*7/5))
        image2_2.image = UIImage(named: "首页3_28")
        view2_2.addSubview(image2_2)
        
         /*-----2_3-----*/
        let view2_3 = UIView(frame: CGRect(x: SW/2, y: 0, width: SW/2-5, height: SH/4))
        view2_3.tag = 2103
        
        //-----驾驶证业务-----
        let label2_3_1 = UILabel(frame: CGRect(x: 10, y: 10, width: view2_1.frame.width-10, height: view2.frame.height/6))
        label2_3_1.textAlignment = NSTextAlignment.Left
        label2_3_1.font = UIFont.boldSystemFontOfSize(14)
        label2_3_1.text = "驾驶证业务"
        view2_3.addSubview(label2_3_1)
        
        //-----办理人数-----
        self.label2_3_2 = UILabel(frame: CGRect(x: 10, y: label2_3_1.frame.maxY, width: label2_3_1.frame.width*3/5, height: label2_3_1.frame.height))
        label2_3_2.textAlignment = NSTextAlignment.Left
        label2_3_2.font = UIFont.boldSystemFontOfSize(13)
        label2_3_2.textColor = UIColor.orangeColor()
        label2_3_2.text = "办理人数：\(self.num2_3)"
        view2_3.addSubview(label2_3_2)

        //-----图片-----
        let image2_3 = UIImageView(frame: CGRect(x: label2_3_2.frame.maxX-20, y: label2_3_2.frame.maxY+30, width: label2_3_1.frame.width*2/5, height: label2_3_1.frame.width*2/7))
        image2_3.image = UIImage(named: "首页3_27")
        view2_3.addSubview(image2_3)
        
        // 描线
        let line2_1 = UIView(frame: CGRect(x: SW/2, y: self.view2.frame.minX-5, width: 1, height: self.view2.frame.height))
        line2_1.backgroundColor = UIColor.lightGrayColor()
        self.view2.addSubview(line2_1)
        let line2_2 = UIView(frame: CGRect(x: 5, y: self.view2.frame.height/2, width: self.view1.frame.width/2, height: 1))
        line2_2.backgroundColor = UIColor.lightGrayColor()
        self.view2.addSubview(line2_2)

        // 为各个view添加手势
        let gestureTap1 = UITapGestureRecognizer(target: self, action: "gestureAction:")
        view2_1.addGestureRecognizer(gestureTap1)
        let gestureTap2 = UITapGestureRecognizer(target: self, action: "gestureAction:")
        view2_2.addGestureRecognizer(gestureTap2)
        let gestureTap3 = UITapGestureRecognizer(target: self, action: "gestureAction:")
        view2_3.addGestureRecognizer(gestureTap3)
        
        self.view2.addSubview(view2_1)
        self.view2.addSubview(view2_2)
        self.view2.addSubview(view2_3)
        self.addSubview(self.view2)
    }

    // 手势的事件处理
    func gestureAction(tap: UITapGestureRecognizer) {
        print("headViewgestureAction : \(tap.view?.tag)")
        self.delegate.gestureAction(tap.view!)
    }
    
    // 单元格事件
    func homeCellTap(view: UIView) {
        self.delegate.homeCellTap(view)
    }
    
   /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //获取用语描画的全局对象
        var context = UIGraphicsGetCurrentContext()
        //设置颜色
        CGContextSetRGBStrokeColor(context, 245/255, 245/255, 245/255, 1.0)
        //线宽度
        CGContextSetLineWidth(context, 0.3)
        //开始线性移动
        CGContextAddLineToPoint(context, 100, 200)
        CGContextAddLineToPoint(context, 200, 200)
        
        CGContextMoveToPoint(context, 100, 300)
        CGContextAddLineToPoint(context, 100, 400)
        
        //描画轨迹  
        CGContextStrokePath(context)
    }
    */
}
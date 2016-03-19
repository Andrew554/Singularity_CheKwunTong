//
//  CenterViewController.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/11/6.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SideMenu, RootViewDelegate, RootReturnDelegate {
    
    var sc: UIScrollView!
    var rootView: HeadView!
    var cv: UICollectionView!
    
    var dictionary: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        initLayout()
    }
    
    // 初始化 布局
    func initLayout() {
        self.navigationItem.title = "渝中车管通"
                
        self.setupRightMenuButton()
        
        self.sc = UIScrollView(frame: CGRect(x: 0, y: 0, width: SW, height: SH-20))
        self.sc.scrollEnabled = true
        self.sc.addLegendHeaderWithRefreshingTarget(self, refreshingAction: "refreshing")
        self.rootView = HeadView()
        self.rootView.frame = CGRect(x: 0, y: 0, width: SW, height: SH/2)
//        self.rootView = HeadView(frame: CGRect(x: 0, y: 0, width: SW, height: SH/2))
        self.rootView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0 // 设置cell的最小行距
        layout.minimumLineSpacing = 0
        
        // 设置homeCell数据源
        setCellData()
        
        self.cv = UICollectionView(frame: CGRect(x: 5, y: self.rootView.frame.maxY + 35, width: SW-10, height: SH/3+5), collectionViewLayout: layout)
        self.cv.registerClass(HomeCell.self, forCellWithReuseIdentifier: "homeCell")
        self.cv.backgroundColor = UIColor.whiteColor()
        self.cv.scrollEnabled = false
        
        self.cv.delegate = self
        self.cv.dataSource = self

        self.sc.addSubview(self.rootView)
        self.sc.addSubview(self.cv)
        self.view.addSubview(self.sc)
        
        // 视图加载后自动开始刷新数据
        self.sc.header.beginRefreshing()
    }
    
    // 设置单元格数据源
    func setCellData() {
       self.dictionary = PlistTool.readPlistDic("HomeCellList")
    }
    
    // 数据获取
    func loadData() {
        // SwiftyJSON 与 Alamofire结合使用
        Alamofire.request(.GET, "\(rootPath)\(rootViewPath)").validate().responseJSON { response in
            switch response.result {
            case .Success:
                var valueArray = [Int]()
                if let value = response.result.value {
                     dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let json = JSON(value)
                        print("JSON: \(json)")
                        for arr in 0...json.count {
                            if let num1 = json[arr]["wait_num"].int {
                                valueArray.append(num1)
                            }
                        }
                        print("\(valueArray)")
                        
                        // 获取排队人数
                        Alamofire.request(.GET, "\(rootPath)\(waitPath)").validate().responseJSON { response in
                            switch response.result {
                            case .Success:
                                if let value2 = response.result.value {
                                    let json2 = JSON(value2)
                                    if let waitNum = json2["current_waiting_num"].int {
                                        self.rootView.label1_1_3.text = "排队人数：\(waitNum)"
                                        print("waitNum:\(waitNum)")
                                    }
                                }
                            case .Failure(let error2):
                                print(error2)
                                self.cv.header.endRefreshing()
                                ProgressHUD.showSuccess("加载失败！")
                            }
                        }
                        self.setValueForRootView(valueArray)
                    })
                }
            case .Failure(let error):
                print(error)
                self.cv.header.endRefreshing()
                ProgressHUD.showSuccess("加载失败！")
            }
        }
    }
    
    // 更新数据
    func setValueForRootView(array: NSArray) {
        let strL = "办理人数："
        for i in 0...array.count {
            switch(i) {
            case 0:
                self.rootView.label1_1_2.text = "\(strL)\(array[i])"
            case 1:
                self.rootView.label1_2_2.text = "\(strL)\(array[i])"
            case 2:
                self.rootView.label1_3_2.text = "\(strL)\(array[i])"
            case 3:
                self.rootView.label2_1_2.text = "\(strL)\(array[i])"
            case 4:
                self.rootView.label2_2_2.text = "\(strL)\(array[i])"
            case 5:
                self.rootView.label2_3_2.text = "\(strL)\(array[i])"
            default: print("default")
            }
        }
        self.sc.header.endRefreshing()
        ProgressHUD.showSuccess("加载完成！")
    }

    // 设置右边菜单栏的点击按钮
    func setupRightMenuButton() {
        let rightDrawerButton = MMDrawerBarButtonItem(image: UIImage(named: "setting"), style: UIBarButtonItemStyle.Plain, target: self, action:"rightDrawerButtonPress:")
        self.navigationItem.rightBarButtonItem = rightDrawerButton
    }
    
    // 自动展开侧滑
    func autoShowSlide() {
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Right, animated: true) { (finish) -> Void in
        }
    }
    
    // 导航按钮的点击侧滑事件
    func rightDrawerButtonPress(sender: AnyObject) {
        // 通过侧滑控制器实现点击按钮的侧滑效果
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Right, animated: true) { (finish) -> Void in
        }
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dictionary.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "homeCell"
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as? HomeCell
        if(cell == nil) {
            cell = HomeCell(imagePath: "首页3_32", label: "楼层")
            print("nil")
        }
        let image_name = "image_name\(indexPath.row)" as String
        let array = self.dictionary[image_name] as! NSArray
        cell!.image.image = UIImage(named: array[0] as! String)
        cell!.label.text = "\(array[1] as! String)"
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/2-10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 3:
            let vc = CommonProblemVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = GovernmentVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = AboutBaseController()
            vc.typeID = 1
            vc.path = "\(rootPath)/front/about_vehicle"
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    // 协议中的回调方法
    func clickSideMenuItem(viewController: UIViewController, mark: String) {
        if(mark == "login"){
            viewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.navigationController?.presentViewController(viewController, animated: true, completion: { () -> Void in
                print("loginPresented")
            })
        }else {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // 根视图的手势代理方法
    func gestureAction(view: UIView) {
        let vc = BusinessViewController()   // 业务列表
        let detail = DetailBusinessController() // 业务详情
        detail.showHandleDetailBtn = true
        switch(view.tag) {
        case 1101:
            vc.titleMessage = "选择机动车登记业务"
            vc.plistArrayName = "机动车登记业务"
            vc.typeId = 1
            self.navigationController?.pushViewController(vc, animated: true)
        case 1102:
            detail.businessName = "路桥刷卡"
            detail.typeId = 5
            self.navigationController?.pushViewController(detail, animated: true)
        case 1103:
            detail.businessName = "交通违法处理"
            detail.typeId = 3
            self.navigationController?.pushViewController(detail, animated: true)
        case 2101:
            vc.titleMessage = "选择其他机动车业务"
            vc.plistArrayName = "其他机动车业务"
            vc.typeId = 4
            self.navigationController?.pushViewController(vc, animated: true)
        case 2102:
            detail.businessName = "免检业务"
            detail.typeId = 6
            self.navigationController?.pushViewController(detail, animated: true)
        case 2103:
            vc.titleMessage = "选择驾驶证业务"
            vc.plistArrayName = "驾驶证业务"
            vc.typeId = 2
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("gestureAction")
            print("tag: \(view.tag)")
        }
    }
    
    // 第二板块的cell点击事件
    func homeCellTap(view: UIView) {
        print("homeCellTap")
    }
    
    // 下拉刷新
    func refreshing() {
        ProgressHUD.show("数据加载中")
        self.loadData() // 刷新数据
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

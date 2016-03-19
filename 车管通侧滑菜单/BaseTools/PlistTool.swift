//
//  PlistTool.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/4.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import Foundation

class PlistTool: NSObject {
   static func readPlistDic(listStr: String)-> NSDictionary {
        let plistPath = NSBundle.mainBundle().pathForResource(listStr, ofType: "plist")
        let dictionary = NSDictionary(contentsOfFile: plistPath!)
        return dictionary!
    }

   static func readPlistArr(listStr: String)-> NSMutableArray {
        let plistPath = NSBundle.mainBundle().pathForResource(listStr, ofType: "plist")
        let array = NSMutableArray(contentsOfFile: plistPath!)
        return array!
    }
}

//
//  User.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/8.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import Foundation

class User: NSObject {
    var authentication_token: NSData?
    var id: Int = 0
    var created_at: String = ""
    var name: String = ""
    var organization: String = ""
    var phone: String = ""
    var remark: String = ""
    var updated_at: String = ""
    
    override init() {
        super.init()
    }
    
    convenience init(authentication: NSData, id: Int, name: String) {
        self.init()
        print("convnenience user")
        self.authentication_token = authentication
        self.id = id
        self.name = name
    }
    convenience init(id: Int, name: String) {
        self.init()
        print("convnenience2 user")
        self.id = id
        self.name = name
    }
}

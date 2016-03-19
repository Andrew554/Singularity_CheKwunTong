//
//  HomeCell.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/3.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    var image: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init homeCell frame")
        initLayout()
    }
    
    convenience init(imagePath: String, label: String) {
        self.init(frame: CGRect())
        print("convenience init homeCell")
        initLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化布局
    func initLayout() {
        self.image = UIImageView(frame: CGRect(x: 30, y: 10, width: self.frame.width*1/2, height: self.frame.height/2))
        self.image.highlighted = true
        self.label = UILabel(frame: CGRect(x: 5, y: image.frame.maxY + 10, width: self.frame.width-10, height: 15))
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.grayColor()
        label.font = UIFont(name: "Courier New", size: 13)
        image.center.x = self.frame.width/2
        label.center.x = self.frame.width/2
        self.addSubview(image)
        self.addSubview(label)
    }
}

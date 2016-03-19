//
//  SearchVC.swift
//  车管通侧滑菜单
//
//  Created by SinObjectC on 15/12/12.
//  Copyright © 2015年 SinObjectC. All rights reserved.
//

import UIKit

class SearchVC: BaseViewController, UISearchBarDelegate {
    
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        print("view")
        self.view.backgroundColor = UIColor.whiteColor()
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 30, width: SW, height: 30))
//        self.searchBar.barStyle = UIBarStyle.BlackTranslucent
        self.searchBar.barTintColor = UIColor.whiteColor()
        self.searchBar.backgroundColor = UIColor.whiteColor()
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.view.addSubview(self.searchBar)
        self.searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

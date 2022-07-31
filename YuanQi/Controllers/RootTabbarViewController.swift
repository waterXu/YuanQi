//
//  RootTabbarViewController.swift
//  YuanQi
//
//  Created by xuyanlan on 2022/7/10.
//

import UIKit

class RootTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index:Int = self.selectedIndex
        print("index = %d", index)
    }
}

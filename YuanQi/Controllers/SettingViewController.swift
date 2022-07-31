//
//  SettingViewController.swift
//  YuanQi
//
//  Created by xuyanlan on 2022/7/31.
//

import UIKit

class SettingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let colorLeft:UIColor = hexColor(hex: 0xffe76f)
        let colorRight:UIColor = hexColor(hex: 0x91b822)
        self.setupUI(colorLeft: colorLeft, colorRight: colorRight)
    }

}

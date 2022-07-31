//
//  MorningCallViewController.swift
//  YuanQi
//
//  Created by xuyanlan on 2022/7/10.
//

import UIKit

class MorningCallViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        let colorLeft:UIColor = hexColor(hex: 0xfac03d)
        let colorRight:UIColor = hexColor(hex: 0x697723)
        self.setupUI(colorLeft: colorLeft, colorRight: colorRight)
    }
}

//
//  PhotoViewController.swift
//  YuanQi
//
//  Created by xuyanlan on 2022/7/10.
//
import UIKit

class PhotoViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        let colorLeft:UIColor = hexColor(hex: 0xfaead3)
        let colorRight:UIColor = hexColor(hex: 0xa27e7e)
        self.setupUI(colorLeft: colorLeft, colorRight: colorRight)
    }
}

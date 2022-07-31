//
//  BaseViewController.swift
//  YuanQi
//
//  Created by xuyanlan on 2022/7/10.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI(colorLeft:UIColor, colorRight:UIColor) {
        //分屏背景图
        let bgLeft:UIView = UIView.init(frame:CGRect.init(x: 0, y: 0, width: self.view.frame.size.width * 0.5, height: self.view.frame.size.height))
        self.view.addSubview(bgLeft)
        bgLeft.backgroundColor = colorLeft
        
        let bgRight:UIView = UIView.init(frame:CGRect.init(x: self.view.frame.size.width * 0.5, y: 0, width: self.view.frame.size.width * 0.5, height: self.view.frame.size.height))
        self.view.addSubview(bgRight)
        bgRight.backgroundColor = colorRight
        let w:CGFloat = 150
        let h:CGFloat = 150
        //两个圆形
        let circleTop = UIView.init(frame: CGRect.init(x: (self.view.frame.size.width - w) * 0.5, y:  (self.view.frame.size.height - 64) * 1.0/3.0 - w*0.5, width: w, height: h))
        circleTop.layer.cornerRadius = w*0.5
        circleTop.backgroundColor = colorLeft
        circleTop.layer.borderWidth = 2
        circleTop.layer.borderColor = colorRight.cgColor
        self.view.addSubview(circleTop)
        
        let circleBottom = UIView.init(frame: CGRect.init(x: (self.view.frame.size.width - w) * 0.5, y:  (self.view.frame.size.height - 64) * 2.0/3.0 - w*0.5, width: w, height: h))
        circleBottom.backgroundColor = colorRight
        circleBottom.layer.cornerRadius = w*0.5
        circleBottom.layer.borderWidth = 2
        circleBottom.layer.borderColor = colorLeft.cgColor
        self.view.addSubview(circleBottom)
    }
    func hexColor(hex:UInt32) -> UIColor {
        let divisor:CGFloat = 255.0
        let red:CGFloat =   CGFloat(((hex & 0xFF0000) >> 16)) / divisor
        let green:CGFloat = CGFloat((hex & 0x00FF00) >> 8 ) / divisor
        let blue:CGFloat =  CGFloat((hex & 0x0000FF)) / divisor
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

//
//  BackgoundRunner.swift
//  YuanQi
//  后台保活类
//  Created by xuyanlan on 2022/7/31.
//

import UIKit

class BackgoundRunner: NSObject {
    var aliveTime = 4
    class func sharedInstance() -> BackgoundRunner {
        struct Static {
            static let sharedInstance = BackgoundRunner()
        }
        return Static.sharedInstance
    }
    private override init(){
        super.init()
        //ios16后台保活只有 30s左右，所以定为25s 刷新
        self.aliveTime = UIApplication.shared.backgroundRefreshStatus == UIBackgroundRefreshStatus.denied ? 4 : 25
    }
}

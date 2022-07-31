//
//  MainViewController.swift
//  YuanQi
//
//  Created by xuyanlan on 2022/7/2.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var testButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    func setupUI() {
        let colorLeft:UIColor = hexColor(hex: 0xd8caaf)
        let colorRight:UIColor = hexColor(hex: 0x96a48b)
        self.setupUI(colorLeft: colorLeft, colorRight: colorRight)
        self.view.bringSubviewToFront(self.testButton)
    }
    @IBAction func musicPlay(_ sender: Any) {
        let file:String = Bundle.main.path(forResource: "long", ofType: "mp3")!
        if (MusicPlayCenter.sharedInstance().avplayer != nil) {
            if (MusicPlayCenter.sharedInstance().avplayer!.isPlaying) {
                MusicPlayCenter.sharedInstance().pause()
                print("pause")
            } else {
                MusicPlayCenter.sharedInstance().rePlay()
                print("rePlay")
            }
        } else {
            let res:Bool = MusicPlayCenter.sharedInstance().play(audioFile: file, loopCount: 0, background: true)
            print("play: ", res)
        }
    }
}


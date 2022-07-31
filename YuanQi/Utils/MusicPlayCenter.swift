//
//  MusicPlayCenter.swift
//  YuanQi
//
//  Created by xuyanlan on 2022/7/10.
//

import UIKit
import CoreAudioKit
import AVFoundation
import MediaPlayer
import CloudKit

class MusicConfig : NSObject {
    let name: String = ""
    var image: UIImage? = nil
    var auther: String? = nil
}

typealias PlayBlock = (_ succ:Bool)->Void;
typealias StopBlock = (_ interruption:Bool)->Void;
class MusicPlayCenter: NSObject, AVAudioPlayerDelegate {
    var avplayer:AVAudioPlayer? = nil
    var startPlayBlock : PlayBlock?
    var stopPlayBlock : StopBlock?
    class func sharedInstance() -> MusicPlayCenter {
        struct Static {
            static let sharedInstance = MusicPlayCenter()
        }
        return Static.sharedInstance
    }
    private override init(){
        super.init()
    }
    
    func play(audioFile: String, loopCount: Int, background:Bool) -> Bool {
        let data = NSData.init(contentsOfFile: audioFile)
        if ((data == nil) && data!.length < 4) {
            print("audioFile: %@ is nil", audioFile)
            return false;
        }
        do {
            self.avplayer = try AVAudioPlayer.init(data: data! as Data)
            self.avplayer?.delegate = self;
            self.avplayer?.prepareToPlay();
            self.avplayer?.play()
            self.avplayer?.numberOfLoops = loopCount <= 0 ? Int(INT_MAX) : loopCount;
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options:AVAudioSession.CategoryOptions.defaultToSpeaker)
            } catch {
                print(error)
                return false;
            }
        } catch {
            print(error)
            return false;
        }
        // 注册打断通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.interruptionNotification),
            name: AVAudioSession.interruptionNotification,
            object: nil)
        return true
    }
    
    func rePlay() {
        guard (self.avplayer != nil) else {return}
        self.avplayer?.play()
    }
    
    func stop() {
        guard (self.avplayer != nil) else {return}
        self.avplayer?.stop()
    }
    
    func pause() {
        guard (self.avplayer != nil) else {return}
        self.avplayer?.pause()
    }
    
    @objc func interruptionNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let reasonValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt else { return }
        switch reasonValue {
        case AVAudioSession.InterruptionType.began.rawValue:
            var isOtherAudioSuspend = false  //是否是被其他音频会话打断
            if #available(iOS 10.3, *) {
                if #available(iOS 14.5, *) {
                    // iOS 14.5之后使用InterruptionReasonKey
                    let reasonKey = userInfo[AVAudioSessionInterruptionReasonKey] as! UInt
                    switch reasonKey {
                    case AVAudioSession.InterruptionReason.default.rawValue:
                        //因为另一个会话被激活,音频中断
                        isOtherAudioSuspend = true
                        break
                    case AVAudioSession.InterruptionReason.appWasSuspended.rawValue:
                        //由于APP被系统挂起，音频中断。
                        break
                    case AVAudioSession.InterruptionReason.builtInMicMuted.rawValue:
                        //音频因内置麦克风静音而中断(例如iPad智能关闭套iPad's Smart Folio关闭)
                        break
                    default: break
                    }
                    print(reasonKey)
                } else {
                    // iOS 10.3-14.5，InterruptionWasSuspendedKey为true表示中断是由于系统挂起，false是被另一音频打断
                    let suspendedNumber:NSNumber = userInfo[AVAudioSessionInterruptionWasSuspendedKey] as! NSNumber
                    isOtherAudioSuspend = !suspendedNumber.boolValue
                }
                if (self.stopPlayBlock != nil){
                    self.stopPlayBlock!(isOtherAudioSuspend)
                }
            }
            break
        case AVAudioSession.InterruptionType.ended.rawValue:
            let optionKey = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt
            if optionKey == AVAudioSession.InterruptionOptions.shouldResume.rawValue {
                //指示另一个音频会话的中断已结束，本应用程序可以恢复音频。
                if (self.avplayer != nil){
                    self.avplayer?.play()
                }
            }
            break
        default:
            break
        }
    }
}

//
//  Sound Detection.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 5/9/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVFoundation

class SoundDetection {
    
    let refSoundDetection = K.RTDFirebase.SoundDetection
    var player:AVAudioPlayer = AVAudioPlayer()
    var motor = Motor()

    /// Fetching Sound Detection DATA
    func fetchDetectedSound(on imageSound: UIImageView) {
        let refDetectedSound = K.RTDFirebase.detected
        
        refDetectedSound.observe(.value) { (snapShot) in
            if let value = snapShot.value as? String{
                
                if value == "yes"{
                    DispatchQueue.main.async {
                        imageSound.image = UIImage(named: "sound-on")
                        self.playSound(named: "Baby Crying")
                        self.motor.willMotorTurnOn()
                        imageSound.flash()
                    }
                } else {
                    DispatchQueue.main.async {
                        imageSound.image = UIImage(named: "sound-off")
                    }
                }
            }
            
        }
    }
    
    /// Function to Play Sound Alert When Baby is Crying
    @discardableResult func playSound(named soundName: String) -> AVAudioPlayer {

        let audioPath = Bundle.main.path(forResource: soundName, ofType: "wav")
        player = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        player.play()
        return player
    }
    
}


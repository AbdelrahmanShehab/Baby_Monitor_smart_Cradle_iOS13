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

struct SoundDetection {



    //Fetching Sound Detection DATA
    func fetchDetectedSound(ref: DatabaseReference!, imageSound: UIImageView) {

        ref.observe(.value) { (snapShot) in
            if let value = snapShot.value as? String{
                
                if value == "yes"{
                    DispatchQueue.main.async {
                        imageSound.image = UIImage(named: "listen-on")
//                        self.soundAlert(songTitle: "Baby Crying")
                    }
                } else {
                    DispatchQueue.main.async {
                        imageSound.image = UIImage(named: "listen-off")
                    }
                }
            }
            //            print("fetch sound")

        }
    }

    // Detection Sound Alert
//     func soundAlert(songTitle: String) {
//        var player = AVAudioPlayer()
//        let url = Bundle.main.url(forResource: songTitle, withExtension: "wav")
//        player = try! AVAudioPlayer(contentsOf: url!)
//        player.play()
//
//    }

}


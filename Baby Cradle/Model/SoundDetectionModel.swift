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

    // Fetching Sound Detection DATA
    func fetchDetectedSound(ref: DatabaseReference!, imageSound: UIImageView) {

        ref.observe(.value) { (snapShot) in
            if let value = snapShot.value as? String{
                
                if value == "yes"{
                    DispatchQueue.main.async {
                        imageSound.image = UIImage(named: "sound-on")
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

}


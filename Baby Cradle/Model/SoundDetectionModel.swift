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


struct SoundDetection {
    
    //Fetching Sound Detection DATA
     func fetchDetectedSound(ref: DatabaseReference!, imageSound: UIImageView) {

        ref.observe(.value) { (snapShot) in
            if snapShot.value as! String == "yes"{
                DispatchQueue.main.async {
                    imageSound.image = UIImage(named: "listen-on")
                }
            } else {
                DispatchQueue.main.async {
                    imageSound.image = UIImage(named: "listen-off")
                }
            }
        }
    }

}


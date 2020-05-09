//
//  FanModel.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 5/9/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Fan {

    private var isFanPressed = false

    //Setting DATA
     mutating func setFanStates(ref: DatabaseReference!, button: UIButton) {
        if isFanPressed {
            ref.child("run").setValue(1)
            DispatchQueue.main.async {
                button.setImage(UIImage(named: "fan-on"), for: .normal)
            }
            isFanPressed = !isFanPressed
        } else {
            ref.child("run").setValue(0)
            DispatchQueue.main.async {
                button.setImage(UIImage(named: "fan-off"), for: .normal)
            }
            isFanPressed = !isFanPressed
        }
    }

    // Fetching DATA
     func observeFanStates(ref: DatabaseReference!, button: UIButton) {

        ref.observe(.value) { (snapShot) in
            if snapShot.value as! Int == 1 {
                DispatchQueue.main.async {
                    button.setImage(UIImage(named: "fan-on"), for: .normal)
                }
            } else {
                DispatchQueue.main.async {
                    button.setImage(UIImage(named: "fan-off"), for: .normal)

                }
            }
        }

    }

    // Fetching Level Data
     func observeFanLevel(ref: DatabaseReference! , slider:UISlider) {
        ref.observe(.value) { (snapShot) in
            if let level = snapShot.value as? Float {
                slider.value = level
            }
        }
    }
}

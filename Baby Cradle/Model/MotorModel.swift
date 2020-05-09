//
//  MotorModel.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 5/9/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Motor {

    private var isMotorPressed = false

    //Setting DATA
    mutating func setMotorStates(ref: DatabaseReference!, button: UIButton) {
        if isMotorPressed {
            ref.child("run").setValue(1)
            DispatchQueue.main.async {
                button.setImage(UIImage(named: "power-on"), for: .normal)
            }
            isMotorPressed = !isMotorPressed
        } else {
            ref.child("run").setValue(0)
            DispatchQueue.main.async {
                button.setImage(UIImage(named: "power-off"), for: .normal)
            }
            isMotorPressed = !isMotorPressed
        }
    }

    // Featching DATA
    func observeMotorStates(ref: DatabaseReference!, button: UIButton) {

        ref.observe(.value) { (snapShot) in
            if snapShot.value as! Int == 1 {
                DispatchQueue.main.async {
                    button.setImage(UIImage(named: "power-on"), for: .normal)
                }
            } else {
                DispatchQueue.main.async {
                    button.setImage(UIImage(named: "power-off"), for: .normal)

                }
            }
        }

    }

    // Fetching Level Data
    func observeMotorLevel(ref: DatabaseReference! , slider:UISlider) {
        ref.observe(.value) { (snapShot) in
            if let level = snapShot.value as? Float {
                slider.value = level
            }
        }
    }
}

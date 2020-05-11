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

    //MARK: - Setting Data

    //Setting Motor State
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

    // Setting level Degree State
    func setMotorSlider(ref: DatabaseReference!, slider: UISlider, label: UILabel) {
        slider.value = roundf(slider.value)

        if slider.value == 1 {
            label.text = "Low"
            ref.setValue(1)
        } else if slider.value == 2 {
            label.text = "Medium"
            ref.setValue(2)
        } else {
            label.text = "High"
            ref.setValue(3)
        }
    }

    //MARK: - Fetching Data

    // Featching Motor Data
    func observeMotorStates(ref: DatabaseReference!, button: UIButton) {

        ref.observe(.value) { (snapShot) in
            if let value = snapShot.value as? Int {
                
                if value == 1 {
                    DispatchQueue.main.async {
                        button.setImage(UIImage(named: "power-on"), for: .normal)
                    }
                } else {
                    DispatchQueue.main.async {
                        button.setImage(UIImage(named: "power-off"), for: .normal)

                    }
                }
            }

            //            print("fetch motor")
        }

    }

    // Fetching Level Degree Data
    func observeMotorLevel(ref: DatabaseReference! , slider:UISlider, label: UILabel) {
        ref.observe(.value) { (snapShot) in
            if let level = snapShot.value as? Float {
                slider.value = level
                if slider.value == 1 {
                    label.text = "Low"
                } else if slider.value == 2 {
                    label.text = "Medium"
                } else {
                    label.text = "High"
                }
            }
            //            print("fetch  level motor")

        }
    }
}

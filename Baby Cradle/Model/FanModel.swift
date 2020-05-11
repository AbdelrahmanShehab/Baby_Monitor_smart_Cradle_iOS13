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

    //MARK: - Setting Data

    //Setting Fan State
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

    // Setting level Degree state
    func setFanSlider(ref: DatabaseReference!, slider: UISlider, label: UILabel) {
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

    //MARK: - Featching Data

    // Fetching Fan Data
     func observeFanStates(ref: DatabaseReference!, button: UIButton) {

        ref.observe(.value) { (snapShot) in
            if let value = snapShot.value as? Int {

                if value == 1 {
                    DispatchQueue.main.async {
                        button.setImage(UIImage(named: "fan-on"), for: .normal)
                    }
                } else {
                    DispatchQueue.main.async {
                        button.setImage(UIImage(named: "fan-off"), for: .normal)

                    }
                }
            }
            //            print("fetch fan")

        }

    }

    // Fetching Level Degree Data
     func observeFanLevel(ref: DatabaseReference! , slider:UISlider, label: UILabel) {
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
//            print("fetch level fan")

        }
    }
}

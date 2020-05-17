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

class Fan {

    private var status : Bool?
    private var isFanPressed: Bool {
        get {
            let refFanRun = Database.database().reference()
            refFanRun.observe(.value) { (snapshot) in
                if let value = snapshot.value as? Int {
                    if value == 1 {
                        self.status = true
                    }else {
                        self.status = false
                    }
                }
            }
            return status ?? false
        }

        set {
            status = newValue
        }
    }

    //MARK: - Setting Data

    //Setting Fan State
    func setFanStates(ref: DatabaseReference!, button: UIButton) {
        if !isFanPressed {
            ref.child("run").setValue(1)
            DispatchQueue.main.async {
                button.setImage(UIImage(named: "fan-on"), for: .normal)
                self.isFanPressed = true
            }
            
        } else {
            ref.child("run").setValue(0)
            DispatchQueue.main.async {
                button.setImage(UIImage(named: "fan-off"), for: .normal)
            }
            self.isFanPressed = false
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
                        self.isFanPressed = true
                    }
                } else {
                    DispatchQueue.main.async {
                        button.setImage(UIImage(named: "fan-off"), for: .normal)
                        self.isFanPressed = false
                    }
                }
            }
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

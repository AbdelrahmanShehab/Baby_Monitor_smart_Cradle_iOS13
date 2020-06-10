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
    let refFan = K.RTDFirebase.Fan
    
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
    
    /// Setting Fan State
    func setFanStates(on button: UIButton) {
        let refFanRun = K.RTDFirebase.runFan
        
        if !isFanPressed {
            refFanRun.setValue(1)
            DispatchQueue.main.async {
                button.pulsate()
                button.setImage(UIImage(named: "fan-on"), for: .normal)
                self.isFanPressed = true
            }
            
        } else {
            refFanRun.setValue(0)
            DispatchQueue.main.async {
                button.setImage(UIImage(named: "fan-off"), for: .normal)
            }
            self.isFanPressed = false
        }
    }
    
    /// Setting level Degree state
    func setFanSlider(on slider: UISlider, with label: UILabel) {
        let refFanLevel = K.RTDFirebase.fanLevel
        slider.value = roundf(slider.value)
        
        if slider.value == 1 {
            label.text = "Low"
            refFanLevel.setValue(1)
        } else if slider.value == 2 {
            label.text = "Medium"
            refFanLevel.setValue(2)
        } else {
            label.text = "High"
            refFanLevel.setValue(3)
        }
    }

    /// Monitor Function to Turn Fan On when Temperature is High  and Turn it Off Automatically
    func willFanTurnOn() {
        K.RTDFirebase.runFan.setValue(1)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(60)) {
            self.willFanTurnOff()
            K.RTDFirebase.fanLevel.setValue(1)
        }
    }

    func willFanTurnOff() {
        K.RTDFirebase.runFan.setValue(0)
    }
    
    /// Function To Turn Off Fan Before SignOut  by Setting Zero in Firebase
    func turnFanOffBeforeSignOut() {
        K.RTDFirebase.runFan.setValue(0) { (error, ref) in
            if error == nil {
                try! Auth.auth().signOut()
            }
        }
        K.RTDFirebase.fanLevel.setValue(1) { (error, ref) in
            if error == nil {
                try! Auth.auth().signOut()
            }
        }
    }
    
    /// Function To Turn Off Fan When The App Quits
    func turnFanOffWhenQuit() {
        K.RTDFirebase.runFan.setValue(0)
    }
    
    //MARK: - Fetching Data
    
    /// Fetching Fan Data
    func observeFanStates(on button: UIButton) {
        let refFanRun = K.RTDFirebase.runFan
        
        refFanRun.observe(.value) { (snapShot) in
            if let value = snapShot.value as? Int {
                
                if value == 1 {
                    DispatchQueue.main.async {
                        button.pulsate()
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
    
    /// Fetching Level Degree Data
    func observeFanLevel(on slider:UISlider, with label: UILabel) {
        let refFanLevel = K.RTDFirebase.fanLevel
        
        refFanLevel.observe(.value) { (snapShot) in
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
        }
    }
}

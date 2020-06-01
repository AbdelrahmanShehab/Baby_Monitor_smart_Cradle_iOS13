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

class Motor {
    
    private var status : Bool?
    let refMotor = K.RTDFirebase.Motor
    
    private var isMotorPressed: Bool {
        get {
            let refMotorRun = Database.database().reference()
            refMotorRun.observe(.value) { (snapshot) in
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
    
    /// Setting Motor State
    func setMotorStates(on button: UIButton) {
        let refMotorRun = K.RTDFirebase.runMotor
        
        if !isMotorPressed {
            refMotorRun.setValue(1)
            DispatchQueue.main.async {
                button.pulsate()
                button.setImage(UIImage(named: "power-on"), for: .normal)
                self.isMotorPressed = true
            }
        } else {
            refMotorRun.setValue(0)
            DispatchQueue.main.async {
                button.setImage(UIImage(named: "power-off"), for: .normal)
                self.isMotorPressed = false
            }
        }
    }
    
    /// Setting level Degree State
    func setMotorSlider(on slider: UISlider, with label: UILabel) {
        let refMotorLevel = K.RTDFirebase.motorLevel
        slider.value = roundf(slider.value)
        
        if slider.value == 1 {
            label.text = "Low"
            refMotorLevel.setValue(1)
        } else if slider.value == 2 {
            label.text = "Medium"
            refMotorLevel.setValue(2)
        } else {
            label.text = "High"
            refMotorLevel.setValue(3)
        }
    }
    
    /// Function To Turn Off Motor Before SignOut by Setting Zero in Firebase
    func turnMotorOffBeforeSignOut() {
        K.RTDFirebase.runMotor.setValue(0) { (error, ref) in
            if error == nil {
                try! Auth.auth().signOut()
            }
        }
    }
    
    /// Function To Turn Off Motor When The App Quits
    func turnMotorOffWhenQuit() {
        K.RTDFirebase.runMotor.setValue(0)
    }
    
    //MARK: - Fetching Data
    
    /// Fetching Motor Data
    func observeMotorStates(on button: UIButton) {
        let refMotorRun = K.RTDFirebase.runMotor
        
        refMotorRun.observe(.value) { (snapShot) in
            if let value = snapShot.value as? Int {
                
                if value == 1 {
                    DispatchQueue.main.async {
                        button.pulsate()
                        button.setImage(UIImage(named: "power-on"), for: .normal)
                        self.isMotorPressed = true
                    }
                } else {
                    DispatchQueue.main.async {
                        button.setImage(UIImage(named: "power-off"), for: .normal)
                        self.isMotorPressed = false
                    }
                }
            }
        }
        
    }
    
    /// Fetching Level Degree Data
    func observeMotorLevel(on slider:UISlider, with label: UILabel) {
        let refMotorLevel = K.RTDFirebase.motorLevel
        
        refMotorLevel.observe(.value) { (snapShot) in
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

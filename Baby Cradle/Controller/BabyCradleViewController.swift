//
//  BabyCradleViewController.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 4/26/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import UIKit
import Firebase
import MBCircularProgressBar

class BabyCradleViewController: UIViewController {

    var motor = Motor()
    var fan = Fan()
    var soundDetection = SoundDetection()
    var status = Status()
    var refMotor: DatabaseReference!
    var refFan: DatabaseReference!
    var refStatus: DatabaseReference!
    var refSoundDetection: DatabaseReference!

    //MARK: - IBOUTLETS
    /// Motor
    @IBOutlet weak var motorButton: UIButton!
    @IBOutlet weak var motorSlider: UISlider!
    @IBOutlet weak var motorLevelLabel: UILabel!
    /// FAN
    @IBOutlet weak var fanButton: UIButton!
    @IBOutlet weak var fanSlider: UISlider!
    @IBOutlet weak var fanLevelLabel: UILabel!
    /// Temerature & Humidity
    @IBOutlet weak var temperatureProgressView: MBCircularProgressBarView!
    @IBOutlet weak var humidityProgressView: MBCircularProgressBarView!
    /// Sound Detection
    @IBOutlet weak var soundDetectionImage: UIImageView!
    /// Grid Views of IBOutlets
    @IBOutlet var views : [UIView]!


    override func viewDidLoad() {
        super.viewDidLoad()

        /// Style Views
        for view in views {
            view.setShadow()
        }
        view.setGradientBackground(colorOne: UIColor(cgColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)), colorTwo: UIColor(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)))
        temperatureProgressView.setShadow()
        humidityProgressView.setShadow()
        
        // Fetching Data From Firebase Realtime Database 
        fetchDataFromFirebase()
    }

    //MARK: - MOTOR ACTION
    @IBAction func motorPowerButton(_ sender: UIButton) {
        
        motor.setMotorStates(ref: refMotor, button: motorButton)
    }

    @IBAction func motorLevelSlider(_ sender: UISlider) {
        let refMotorLevel = refMotor.child("level")

        motor.setMotorSlider(ref: refMotorLevel, slider: motorSlider, label: motorLevelLabel)
    }

    //MARK: - FAN ACTION
    @IBAction func fanPressedButton(_ sender: UIButton) {

        fan.setFanStates(ref: refFan, button: fanButton)
    }

    @IBAction func fanLevelSlider(_ sender: UISlider) {
        let refFanLevel = refFan.child("level")

        fan.setFanSlider(ref: refFanLevel, slider: fanSlider, label: fanLevelLabel)
    }

    //MARK: - Sign Out
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {

        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

    }

    //MARK: - Fetching Data From Firebase
    func fetchDataFromFirebase() {

        // Firebase RealTime Database JSON Structure
        refMotor = Database.database().reference(withPath: "Motor")
        let refMotorRun = refMotor.child("run")
        let refMotorLevel = refMotor.child("level")
        refFan = Database.database().reference(withPath: "Fan")
        let refFanRun = refFan.child("run")
        let refFanLevel = refFan.child("level")
        refSoundDetection = Database.database().reference(withPath: "Sound Detection")
        let refDetectedSound = refSoundDetection.child("detected")
        refStatus =  Database.database().reference(withPath: "Status")
        let refTemperatureStatus = refStatus.child("Temperature")
        let refreHumidityStatus  = refStatus.child("Humidity")

        /// Featching Data in StartUp
        DispatchQueue.main.async {
            self.motor.observeMotorStates(ref: refMotorRun, button: self.motorButton)
            self.motor.observeMotorLevel(ref: refMotorLevel, slider: self.motorSlider, label: self.motorLevelLabel)
            self.fan.observeFanStates(ref: refFanRun, button: self.fanButton)
            self.fan.observeFanLevel(ref: refFanLevel, slider: self.fanSlider, label: self.fanLevelLabel)

            self.soundDetection.fetchDetectedSound(ref: refDetectedSound, imageSound: self.soundDetectionImage)
            self.status.fetchStatusData(ref: refreHumidityStatus, progressView: self.humidityProgressView)
            self.status.fetchStatusData(ref: refTemperatureStatus, progressView: self.temperatureProgressView)

            //Hide Spinner
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(1500)) {
                Spinner.sharedInstance.hide()
            }
        }
    }

}

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
    // Motor
    @IBOutlet weak var motorButton: UIButton!
    @IBOutlet weak var motorSlider: UISlider!
    @IBOutlet weak var motorLevelLabel: UILabel!
    // FAN
    @IBOutlet weak var fanButton: UIButton!
    @IBOutlet weak var fanSlider: UISlider!
    @IBOutlet weak var fanLevelLabel: UILabel!
    // Temerature & Humidity
    @IBOutlet weak var temperatureProgressView: MBCircularProgressBarView!
    @IBOutlet weak var humidityProgressView: MBCircularProgressBarView!
    // Sound Detection
    @IBOutlet weak var soundDetectionImage: UIImageView!
    // Grid Views of IBOutlets
    @IBOutlet var views : [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        for view in views {
            view.layer.cornerRadius = 10
        }
        view.setGradientBackground(colorOne: K.BrandColors.blackMoove, colorTwo: K.BrandColors.lightMoove)

        // Firebase RealTime Database JSON Structure

        refMotor = Database.database().reference(withPath: "Motor")
        let refMotorRun = refMotor.child("run")
        let refMotorLevel = refMotor.child("level")
        refFan = Database.database().reference(withPath: "Fan")
        let refFanRun = refFan.child("run")
        let refFanLevel = refFan.child("level")
        refSoundDetection = Database.database().reference(withPath: "Sound Detection")
        let refDetectedSound = refSoundDetection.child("detected")

        // Featching Data in StartUp

        motor.observeMotorStates(ref: refMotorRun, button: motorButton)
        motor.observeMotorLevel(ref: refMotorLevel, slider: motorSlider, label: motorLevelLabel)
        fan.observeFanStates(ref: refFanRun, button: fanButton)
        fan.observeFanLevel(ref: refFanLevel, slider: fanSlider, label: fanLevelLabel)
        soundDetection.fetchDetectedSound(ref: refDetectedSound, imageSound: soundDetectionImage)
    }

    //MARK: - Temperature & Humidity Status
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {

            // Firebase RealTime Database JSON Structure
            self.refStatus =  Database.database().reference(withPath: "Status")
            let refTemperatureStatus = self.refStatus.child("Temperature")
            let refreHumidityStatus  = self.refStatus.child("Humidity")

            // Featching Data in StartUp
            self.status.fetchStatusData(ref: refreHumidityStatus, progressView: self.humidityProgressView)
            self.status.fetchStatusData(ref: refTemperatureStatus, progressView: self.temperatureProgressView)
        }
    }

    //MARK: - MOTOR
    @IBAction func motorPowerButton(_ sender: UIButton) {

        motor.setMotorStates(ref: refMotor, button: motorButton)
    }

    @IBAction func motorLevelSlider(_ sender: UISlider) {
        let refMotorLevel = refMotor.child("level")

        motor.setMotorSlider(ref: refMotorLevel, slider: motorSlider, label: motorLevelLabel)
    }

    //MARK: - FAN
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
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

    }

}

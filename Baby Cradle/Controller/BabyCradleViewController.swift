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
    var music = Music()
    var musicVC = MusicViewController()

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

    
    //MARK: - ViewDidLoad Method
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
        
        motor.setMotorStates(on: motorButton)
    }

    @IBAction func motorLevelSlider(_ sender: UISlider) {

        motor.setMotorSlider(on: motorSlider, with: motorLevelLabel)
    }

    //MARK: - FAN ACTION
    @IBAction func fanPressedButton(_ sender: UIButton) {

        fan.setFanStates(on: fanButton)
    }

    @IBAction func fanLevelSlider(_ sender: UISlider) {

        fan.setFanSlider(on: fanSlider, with: fanLevelLabel)
    }

    //MARK: - Sign Out
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {

        /// Turn Off Actions and Set Them with Zero in Firebase
        let audio = musicVC.audioPlayer
        motor.turnMotorOffBeforeSignOut()
        fan.turnFanOffBeforeSignOut()
        music.turnMusicOffBeforeSignOut(player: audio)
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

    }

//    func finishLoggedOut() {
//        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
//        UserDefaults.standard.synchronize()
//    }

    //MARK: - Fetching Data From Firebase
    func fetchDataFromFirebase() {

        /// Featching Data in StartUp
        DispatchQueue.main.async {
            self.motor.observeMotorStates(on: self.motorButton)
            self.motor.observeMotorLevel(on: self.motorSlider, with: self.motorLevelLabel)
            self.fan.observeFanStates(on: self.fanButton)
            self.fan.observeFanLevel(on: self.fanSlider, with: self.fanLevelLabel)
            self.soundDetection.fetchDetectedSound(on: self.soundDetectionImage)
            self.status.fetchTemperatureStatus(on: self.temperatureProgressView)
            self.status.fetchHumidityStatus(on: self.humidityProgressView)

            //Hide Spinner
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(1500)) {
                Spinner.sharedInstance.hide()
            }
        }
    }

}


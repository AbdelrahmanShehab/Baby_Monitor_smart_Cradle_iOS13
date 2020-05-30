//
//  Constants.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 4/27/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import Foundation
import Firebase
import UIKit

struct K {
    static let appName = "👶🏼 Smart Baby Cradle"

    struct RTDFirebase {
        static let Motor = Database.database().reference(withPath: "Motor")
        static let runMotor = Motor.child("run")
        static let motorLevel = Motor.child("level")
        static let Fan = Database.database().reference(withPath: "Fan")
        static let runFan = Fan.child("run")
        static let fanLevel = Fan.child("level")
        static let SoundDetection = Database.database().reference(withPath: "Sound Detection")
        static let detected = SoundDetection.child("detected")
        static let Status = Database.database().reference(withPath: "Status")
        static let Temperature = Status.child("Temperature")
        static let Humidity = Status.child("Humidity")
        static let Music = Database.database().reference(withPath: "Music")
        static let song = Music.child("song")
        static let volume = Music.child("volume")
    }
    struct BrandColors {
        static let red = UIColor(red: 0.73, green: 0.17, blue: 0.15, alpha: 1.00)
        static let blue = UIColor(red: 0.08, green: 0.40, blue: 0.75, alpha: 1.00)
        static let lightBlue = UIColor(red: 0.48, green: 0.63, blue: 0.82, alpha: 1.00)
        static let blueGreen = UIColor(red: 0.17, green: 0.35, blue: 0.46, alpha: 1.00)
        static let turquoise = UIColor(red: 0.04, green: 0.53, blue: 0.58, alpha: 1.00)
        static let purple = UIColor(red: 0.51, green: 0.38, blue: 0.76, alpha: 1.00)
        static let darkPurple = UIColor(red: 0.21, green: 0.00, blue: 0.20, alpha: 1.00)
        static let lightPurple = UIColor(red: 0.31, green: 0.26, blue: 0.46, alpha: 1.00)
        static let beige = UIColor(red: 0.86, green: 0.83, blue: 0.71, alpha: 1.00)
        static let marron = UIColor(red: 0.50, green: 0.00, blue: 0.00, alpha: 1.00)
    }
}

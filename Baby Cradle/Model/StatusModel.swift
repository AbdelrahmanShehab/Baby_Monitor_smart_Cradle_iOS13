//
//  StatusModel.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 5/9/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import MBCircularProgressBar

struct Status {
    let refStatus =  K.RTDFirebase.Status
    var fan = Fan()

    /// Fetching Temperature Status
    func fetchTemperatureStatus(on progressView: MBCircularProgressBarView) {
        let refTemperatureStatus = K.RTDFirebase.Temperature
        
        refTemperatureStatus.observe(.value) { (snapShot) in
            if let value = snapShot.value as? String {
                
                let progressValue = (value as NSString).floatValue
                progressView.value = CGFloat(progressValue)
                switch progressValue {
                    case 0..<15:
                        progressView.progressColor = #colorLiteral(red: 0, green: 1, blue: 0.7490196078, alpha: 1)
                    case 15..<25:
                        progressView.progressColor = #colorLiteral(red: 0.2053576708, green: 0.9994787574, blue: 0.6023795009, alpha: 1)
                    case 25..<35:
                        progressView.progressColor = #colorLiteral(red: 0, green: 1, blue: 0.2531713843, alpha: 1)
                    case 35..<47:
                        progressView.progressColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 1)
                    case 47..<50:
                        progressView.progressColor = #colorLiteral(red: 1, green: 0.2682470035, blue: 0.1987371575, alpha: 1)
                    case 50..<53:
                        progressView.progressColor = #colorLiteral(red: 0.8763912671, green: 0.2125237124, blue: 0.2470569349, alpha: 1)
                    case 53...55:
                        progressView.progressColor = #colorLiteral(red: 0.8305062072, green: 0, blue: 0, alpha: 1)
                    default:
                        progressView.progressColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                }
                if progressValue >= 35 {
                    self.fan.willFanTurnOn()
                } else if progressValue < 35{
                    self.fan.willFanTurnOff()
                }
            }
            
        }
    }

    func monitorHighTemperature() {
        // TODO Monitor
    }
    
    /// Fetching Humidity Status
    func fetchHumidityStatus(on progressView: MBCircularProgressBarView) {
        
        let refHumidityStatus = K.RTDFirebase.Humidity
        refHumidityStatus.observe(.value) { (snapShot) in
            if let value = snapShot.value as? String {
                
                let progressValue = (value as NSString).floatValue
                progressView.value = CGFloat(progressValue)
                switch progressValue {
                    case 0..<15:
                        progressView.progressColor = #colorLiteral(red: 1, green: 1, blue: 0, alpha: 1)
                    case 15..<30:
                        progressView.progressColor = #colorLiteral(red: 0.9248150587, green: 0.9787808061, blue: 0.5003780723, alpha: 1)
                    case 30..<40:
                        progressView.progressColor = #colorLiteral(red: 0.7490196078, green: 1, blue: 0, alpha: 1)
                    case 40..<50:
                        progressView.progressColor = #colorLiteral(red: 0.5019607843, green: 1, blue: 0, alpha: 1)
                    case 50..<60:
                        progressView.progressColor = #colorLiteral(red: 0.2509803922, green: 1, blue: 0, alpha: 1)
                    case 60..<65:
                        progressView.progressColor = #colorLiteral(red: 0, green: 1, blue: 0.7490196078, alpha: 1)
                    case 65..<70:
                        progressView.progressColor = #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1)
                    case 70..<80:
                        progressView.progressColor = #colorLiteral(red: 0, green: 0.7490196078, blue: 1, alpha: 1)
                    case 80..<90:
                        progressView.progressColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 1, alpha: 1)
                    case 90...100:
                        progressView.progressColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
                    default:
                        progressView.progressColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                }
            }
            
        }
    }
}

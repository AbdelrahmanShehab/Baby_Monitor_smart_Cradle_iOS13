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
    
    /// Fetching Temperature Status
    func fetchTemperatureStatus(on progressView: MBCircularProgressBarView) {
        let refTemperatureStatus = K.RTDFirebase.Temperature
        
        refTemperatureStatus.observe(.value) { (snapShot) in
            if let value = snapShot.value as? String {
                
                let progressValue = (value as NSString).floatValue
                progressView.value = CGFloat(progressValue)
                switch progressValue {
                    case 0..<10:
                        progressView.progressColor = #colorLiteral(red: 0, green: 0.2509803922, blue: 1, alpha: 1)
                    case 10..<20:
                        progressView.progressColor = #colorLiteral(red: 0, green: 0.7490196078, blue: 1, alpha: 1)
                    case 20..<30:
                        progressView.progressColor = #colorLiteral(red: 0, green: 1, blue: 0.7490196078, alpha: 1)
                    case 30..<40:
                        progressView.progressColor = #colorLiteral(red: 0, green: 1, blue: 0.2509803922, alpha: 1)
                    case 40..<50:
                        progressView.progressColor = #colorLiteral(red: 0.5019607843, green: 1, blue: 0, alpha: 1)
                    case 50..<60:
                        progressView.progressColor = #colorLiteral(red: 0.7490196078, green: 1, blue: 0, alpha: 1)
                    case 60..<70:
                        progressView.progressColor = #colorLiteral(red: 1, green: 1, blue: 0, alpha: 1)
                    case 70..<80:
                        progressView.progressColor = #colorLiteral(red: 1, green: 0.7490196078, blue: 0, alpha: 1)
                    case 80..<90:
                        progressView.progressColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 1)
                    case 90...100:
                        progressView.progressColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    default:
                        progressView.progressColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                }
            }
            
        }
    }
    
    /// Fetching Humidity Status
    func fetchHumidityStatus(on progressView: MBCircularProgressBarView) {
        
        let refHumidityStatus = K.RTDFirebase.Humidity
        refHumidityStatus.observe(.value) { (snapShot) in
            if let value = snapShot.value as? String {
                
                let progressValue = (value as NSString).floatValue
                progressView.value = CGFloat(progressValue)
                switch progressValue {
                    case 0..<10:
                        progressView.progressColor = #colorLiteral(red: 0, green: 0.2509803922, blue: 1, alpha: 1)
                    case 10..<20:
                        progressView.progressColor = #colorLiteral(red: 0, green: 0.7490196078, blue: 1, alpha: 1)
                    case 20..<30:
                        progressView.progressColor = #colorLiteral(red: 0, green: 1, blue: 0.7490196078, alpha: 1)
                    case 30..<40:
                        progressView.progressColor = #colorLiteral(red: 0, green: 1, blue: 0.2509803922, alpha: 1)
                    case 40..<50:
                        progressView.progressColor = #colorLiteral(red: 0.5019607843, green: 1, blue: 0, alpha: 1)
                    case 50..<60:
                        progressView.progressColor = #colorLiteral(red: 0.7490196078, green: 1, blue: 0, alpha: 1)
                    case 60..<70:
                        progressView.progressColor = #colorLiteral(red: 1, green: 1, blue: 0, alpha: 1)
                    case 70..<80:
                        progressView.progressColor = #colorLiteral(red: 1, green: 0.7490196078, blue: 0, alpha: 1)
                    case 80..<90:
                        progressView.progressColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 1)
                    case 90...100:
                        progressView.progressColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    default:
                        progressView.progressColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                }
            }
            
        }
    }
}

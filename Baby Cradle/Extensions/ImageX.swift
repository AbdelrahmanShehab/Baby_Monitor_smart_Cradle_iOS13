//
//  ImageX.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 5/18/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func pulsate() {

        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0

        layer.add(pulse, forKey: "pulse")
    }

      func flash() {

        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3

        layer.add(flash, forKey: nil)
    }
    
}

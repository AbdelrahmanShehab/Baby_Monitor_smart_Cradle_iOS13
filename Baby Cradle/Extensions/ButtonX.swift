//
//  ButtonX.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 5/18/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

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

    func shake() {

        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true

        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)

        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)

        shake.fromValue = fromValue
        shake.toValue = toValue

        layer.add(shake, forKey: "position")
    }

    func setBackground() {
        self.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        self.layer.cornerRadius = 3
    }
}

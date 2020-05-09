//
//  GradiantColor.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 4/27/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }

    func setTreboGradientBackground(colorOne: UIColor, colorTwo: UIColor,colorThree: UIColor) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor]
//        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }

    func setShadow() {
        let viewCard = UIView()
        viewCard.layer.shadowColor = UIColor.black.cgColor
        viewCard.layer.shadowOpacity = 1
        viewCard.layer.shadowOffset = .zero
//        viewCard.layer.shadowRadius = 10
        viewCard.layer.shadowPath = UIBezierPath(rect: viewCard.bounds).cgPath
        viewCard.layer.shouldRasterize = true

    }
}

//
//  AlertX.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 5/18/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import Foundation
import UIKit

struct Alert {

    static func showInvalidEmailAlert(on vc: UIViewController,  message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }

    static func showPopUP(on vc: UIViewController)
    {
        let alert = UIAlertController(title: "Alert!", message: "The Mute button is Only Run On your Device Not On Baby Cradle Speaker", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }

}

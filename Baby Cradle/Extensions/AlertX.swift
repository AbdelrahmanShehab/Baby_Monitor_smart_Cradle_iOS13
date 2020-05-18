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


}

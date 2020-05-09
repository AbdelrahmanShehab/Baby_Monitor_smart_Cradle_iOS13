//
//  ViewController.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 4/25/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import UIKit
import Firebase
import CLTypingLabel

class LoginViewController: UIViewController {

    @IBOutlet weak var appNameLabel: CLTypingLabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!

    // Sign in to the Application
    @IBAction func loginPressedButton(_ sender: UIButton) {
        if let email  = loginEmailTextField.text, let password = loginPasswordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.alertLabel.text = e.localizedDescription
                }else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }

            }

        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        appNameLabel.text = K.appName
        // Corner Radius for IBOutlets
        loginView.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 5

        //Change the Name of TextField Placeholder
        loginEmailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        loginPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Passowrd",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        // Setting The Gradiant Colors for Views
        view.setGradientBackground(colorOne: K.BrandColors.purple, colorTwo: K.BrandColors.green)
        loginView.setGradientBackground(colorOne: K.BrandColors.lightPurple, colorTwo: K.BrandColors.lightGreen)
        loginButton.setGradientBackground(colorOne: K.BrandColors.moove, colorTwo: K.BrandColors.blueWater)
    }


}


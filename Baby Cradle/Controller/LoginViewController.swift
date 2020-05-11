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

        self.hideKeyboardWhenTappedAround()
        appNameLabel.text = K.appName

        // Corner Radius for IBOutlets
        loginView.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 5

        // Delegatation Text Fields
        loginEmailTextField.delegate = self
        loginPasswordTextField.delegate = self

        //Change the Name of TextField Placeholder
        loginEmailTextField.setPlaceHolder(with: "E-mail")
        loginPasswordTextField.setPlaceHolder(with: "Password")

        // Setting The Gradiant Colors for Views
        view.setGradientBackground(colorOne: K.BrandColors.purple, colorTwo: K.BrandColors.green)
        loginView.setGradientBackground(colorOne: K.BrandColors.lightPurple, colorTwo: K.BrandColors.lightGreen)
        loginButton.setGradientBackground(colorOne: K.BrandColors.moove, colorTwo: K.BrandColors.blueWater)
    }

    //MARK: - Sign in to the Application
    @IBAction func loginPressedButton(_ sender: UIButton) {
        if let email  = loginEmailTextField.text, let password = loginPasswordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.alertLabel.text = e.localizedDescription
                    print(e.localizedDescription)
                }else {
                    Spinner.sharedInstance.showBlurView(withTitle: "Loading...")
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }

            }

        }

    }

}

//MARK: - UITextField Delgate Method
extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginEmailTextField.endEditing(true)
        loginPasswordTextField.endEditing(true)
        return true
    }

}

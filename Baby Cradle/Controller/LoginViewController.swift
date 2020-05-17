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
    @IBOutlet weak var loginBlurview: UIVisualEffectView!
    @IBOutlet weak var loginButton: UIButton!
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
        
        appNameLabel.text = K.appName
        self.hideKeyboardWhenTappedAround()

        // Delegatation Text Fields
        loginEmailTextField.delegate = self
        loginPasswordTextField.delegate = self

        //Change the Name of TextField Placeholder
        loginEmailTextField.setPlaceHolder(with: "E-mail")
        loginPasswordTextField.setPlaceHolder(with: "Password")

        /// Style Views
        view.setGradientBackground(colorOne: K.BrandColors.blue, colorTwo: K.BrandColors.red)
        loginButton.setGradientBackground(colorOne: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), colorTwo: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))

        // Corner Radius for IBOutlets
        loginBlurview.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 5
    }

    //MARK: - Sign in to the Application
    @IBAction func loginPressedButton(_ sender: UIButton) {
        if let email  = loginEmailTextField.text, let password = loginPasswordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.alertLabel.text = e.localizedDescription
                }else {
                    let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
                    self.present(mainTabController, animated: false) {
                        Spinner.sharedInstance.showBlurView(withTitle: "Loading...")
                    }
                    
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

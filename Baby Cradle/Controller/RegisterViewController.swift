//
//  RegisterViewController.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 4/26/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var raspberry_Pi_Field: UITextField!
    
    //MARK: - ViewDidLoad Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        // Delegation of Text Fields
        registerEmailTextField.delegate = self
        registerPasswordTextField.delegate = self
        raspberry_Pi_Field.delegate = self
        
        //Change the Name of TextField Placeholder
        registerEmailTextField.setPlaceHolder(with: "New E-mail")
        registerPasswordTextField.setPlaceHolder(with: "New Password")
        raspberry_Pi_Field.setPlaceHolder(with: "RaspberryPi ID")
        
        /// Style Views
        view.setGradientBackground(colorOne: K.BrandColors.darkPurple, colorTwo: K.BrandColors.turquoise)
        registerView.setTrioGradientBackground(colorOne: K.BrandColors.purple, colorTwo: K.BrandColors.beige, colorThree: K.BrandColors.lightBlue)
        registerButton.setGradientBackground(colorOne: K.BrandColors.lightPurple, colorTwo: K.BrandColors.blueGreen)
        
        /// Corner Radius for IBOutlets
        registerView.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 5
    }
    
    //MARK: - Sign up to the Application
    @IBAction func registerPressedButton(_ sender: UIButton) {
        
        if let id = raspberry_Pi_Field.text {
            if id == "baby" {
                if let email = registerEmailTextField.text, let password = registerPasswordTextField.text {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let e = error{
                            sender.shake()
                            Alert.showInvalidEmailAlert(on: self, message: e.localizedDescription)
                        } else {
                            let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
                            self.present(mainTabController, animated: false) {
                                Spinner.sharedInstance.showBlurView(withTitle: "Loading...")
                            }
                        }
                    }
                }
            } else {
                Alert.showWarningMsgOfRaspberryID(on: self)
                sender.shake()
            }
        }
        
        
    }
}

//MARK: - UITextField Delgate Method
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        registerEmailTextField.endEditing(true)
        registerPasswordTextField.endEditing(true)
        raspberry_Pi_Field.endEditing(true)
        return true
    }
}

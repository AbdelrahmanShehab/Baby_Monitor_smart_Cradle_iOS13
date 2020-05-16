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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()

        // Delegation of Text Fields
        registerEmailTextField.delegate = self
        registerPasswordTextField.delegate = self

        //Change the Name of TextField Placeholder
        registerEmailTextField.setPlaceHolder(with: "New E-mail")
        registerPasswordTextField.setPlaceHolder(with: "New Password")

        // Style Views
        view.setGradientBackground(colorOne: K.BrandColors.darkPurple, colorTwo: K.BrandColors.turquoise)
        registerView.setTreboGradientBackground(colorOne: K.BrandColors.purple, colorTwo: K.BrandColors.beige, colorThree: K.BrandColors.blue22)
        registerButton.setGradientBackground(colorOne: K.BrandColors.purple22, colorTwo: K.BrandColors.blueGreen)

        // Corner Radius for IBOutlets
        registerView.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 5
    }

    //MARK: - Sign up to the Application
    @IBAction func registerPressedButton(_ sender: UIButton) {

        if let email = registerEmailTextField.text, let password = registerPasswordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.alertLabel.text = e.localizedDescription
                }else{
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
extension RegisterViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        registerEmailTextField.endEditing(true)
        registerPasswordTextField.endEditing(true)
        return true
    }
}

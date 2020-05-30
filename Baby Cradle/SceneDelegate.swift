//
//  SceneDelegate.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 4/25/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var window: UIWindow?
    var music = Music()
    var motor = Motor()
    var fan = Fan()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }

        /// Function To listen Changes Of User Logging IN/OUT
        let auth = Auth.auth()
        auth.addStateDidChangeListener { (_, user) in
            if user != nil {
                let babyVC = self.mainStoryBoard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
                DispatchQueue.main.async {
                    Spinner.sharedInstance.showBlurView(withTitle: "Loading...")
                    self.window?.rootViewController = babyVC
                }

            } else {
                let loginVC = self.mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                DispatchQueue.main.async {
                    Spinner.sharedInstance.showBlurView(withTitle: "Loading...")
                    self.window?.rootViewController = loginVC
                }
            }
        }

//        let userLoginStatus = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
//
//         if(userLoginStatus)
//         {
//             print(userLoginStatus)
//             let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//             let babyVC = mainStoryBoard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
//             window?.rootViewController = babyVC
//             window?.makeKeyAndVisible()
//
//         }
    }

    func sceneDidDisconnect(_ scene: UIScene) {

        DispatchQueue.main.async {
            self.motor.turnMotorOffWhenQuit()
            self.fan.turnFanOffWhenQuit()
            self.music.turnMusicOffWhenQuit()
        }

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


//
//  LoginViewController.swift
//  LoginWithFramework
//
//  Created by Administrator on 11/24/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if FBSDKAccessToken.current() != nil {
            showHome()
        }
    }

    func showHome() {
        performSegue(withIdentifier: "logged", sender: nil)
    }

}


extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        showHome()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
}

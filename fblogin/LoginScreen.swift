//
//  LoginScreen.swift
//  fblogin
//
//  Created by Ken Lu on 4/30/18.
//  Copyright © 2018 Ken Lu. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class LoginScreen: UIViewController, FBSDKLoginButtonDelegate {
    let loginButton : FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email", "public_profile"]
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (error != nil) {
            return
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout complete")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

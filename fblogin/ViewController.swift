//
//  ViewController.swift
//  fblogin
//
//  Created by Ken Lu on 4/30/18.
//  Copyright © 2018 Ken Lu. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {
    var userInfo = [String: Any]()
    var imgView = UIImageView()
    var profileImg = UIImageView()
    var nameLabel : UILabel = {
       return UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
    }()
    var emailLabel : UILabel = {
        return UILabel(frame: CGRect(x: 10, y: 100, width: 100, height: 100))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name.FBSDKProfileDidChange, object: nil)
        getData()
        
    }
    
    @objc func getData() {
        if (FBSDKAccessToken.current() != nil) {
            fetchProfile()
            setupView()
        } else {
            let loginScreen = LoginScreen()
            self.present(loginScreen, animated: true) {
                print("Presented")
            }
        }
    }
    func setupView() {
        let logout = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = logout
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 200).isActive = true
       
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        
        
    }
    
    @objc func handleLogout() {
        print("logout")
        FBSDKLoginManager().logOut()
        self.present(LoginScreen(), animated: true, completion: nil)
    }
    func fetchProfile() {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email, name, picture.type(large)"], httpMethod: "GET").start { (connection, data, error) in
            if error != nil {
                print("error")
                return
            }
            self.userInfo = data as! [String: Any]
            self.showInfo()
        }
    }
    
    func showInfo() {
        if let picture = userInfo["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String {
            getProfilePic(urlString: url)
        }
        
        
    }
    
    func getProfilePic(urlString : String) {
        print("get profile")
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, res, error) in
            if let error = error {
                print("error \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.imgView.image = UIImage(data: data!)
            }
            
        }
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


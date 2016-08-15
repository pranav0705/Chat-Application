//
//  ViewController.swift
//  Chat
//
//  Created by Pranav Bhandari on 8/7/16.
//  Copyright © 2016 Pranav Bhandari. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var anonymousBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBAction func loginAnonymously(sender: AnyObject) {
        // anonymously log users in
        
       Helper.helper.loginAnonymously()
    }
    
    @IBAction func loginGoogle(sender: AnyObject) {
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // MARK: - Setting border for anonymous Login button
        anonymousBtn.layer.borderWidth = 2.0
        anonymousBtn.layer.borderColor = UIColor.whiteColor().CGColor
        
        // MARK: - Setting border for Google Login button
        googleBtn.layer.borderWidth = 2.0
        googleBtn.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        //Setting Google Client ID
        GIDSignIn.sharedInstance().clientID = "941044463097-pg23qdi7ehaq1hhcq480l72rvb8gl1fu.apps.googleusercontent.com"
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if error != nil {
            print(error)
            return
        }else {
            print(user.authentication)
            Helper.helper.loginGoogle(user.authentication)
        }
        
    }
    

}


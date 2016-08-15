//
//  Helper.swift
//  
//
//  Created by Pranav Bhandari on 8/7/16.
//
//

import Foundation
import FirebaseAuth
import UIKit
import GoogleSignIn

class Helper {
    static let helper = Helper()
    
    func loginAnonymously() {
        // anonymously log users in
        
        FIRAuth.auth()?.signInAnonymouslyWithCompletion({ (anonymousUser : FIRUser?, error : NSError?) in
            if error == nil {
                print("userID: \(anonymousUser!.uid)" )
                self.allowLogin()
            }
            else
            {
                print(error!.localizedDescription)
                return
            }
        })
        
        
    }
    
    func loginGoogle(authentication : GIDAuthentication) {
     
        let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken, accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signInWithCredential(credential, completion: { (user : FIRUser?, error : NSError?) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }else {
                print(user?.email)
                print(user?.displayName)
                self.allowLogin()
            }
        })
    }
    
    private func allowLogin() {
    
        // creating a main storyboard instance
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
        //from main storyboard instantiate a navigation controller
        let naviVC = storyBoard.instantiateViewControllerWithIdentifier("NavigationVC") as! UINavigationController
    
        //get the app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
        //set the navigation controller as root view controller
        appDelegate.window?.rootViewController = naviVC

    }
    
}
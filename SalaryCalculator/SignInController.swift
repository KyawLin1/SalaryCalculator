//
//  SignInController.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 26/8/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInController: UIViewController,GIDSignInUIDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Do any additional setup after loading the view.
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
    /*
     let firebaseAuth = Auth.auth()
     do {
     try firebaseAuth.signOut()
     } catch let signOutError as NSError {
     print ("Error signing out: %@", signOutError)
     }
 */

}

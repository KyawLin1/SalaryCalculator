//
//  SignInController.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 17/6/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn

class SignInController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    var databaseRef :FIRDatabaseReference!
    var alertController:UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        databaseRef = FIRDatabase.database().reference()
        if GlobalData.signOut == true{
            GIDSignIn.sharedInstance().signInSilently()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func displayAlert(){
        
        alertController = UIAlertController(title: nil, message: "Signing in", preferredStyle: .alert)
        let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 60.0)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.13)
        alertController.view.addSubview(spinnerIndicator)
        alertController.view.addConstraint(height)
        self.present(alertController, animated: false, completion: nil)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        displayAlert()
        if let error = error {
            print(error)
            return
        }
        print("user signed into google")
        //User signed into Google
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("user signed into firebase")
            //User signed into Firebase
            self.databaseRef = FIRDatabase.database().reference()
            
            self.databaseRef.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                let snapshot = snapshot.value as? NSDictionary
                
                if snapshot == nil{
                    self.databaseRef.child("users").child(user!.uid).child("name").setValue(user!.displayName)
                    self.databaseRef.child("users").child(user!.uid).child("email").setValue(user!.email)
                }
                UserDefaults.standard.setValue(user!.uid, forKey: "uid")
                UserDefaults.standard.setValue(user!.displayName, forKey: "name")
                self.alertController.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "Home", sender: nil)
                /*let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeController: UINavigationController = (mainStoryboard.instantiateViewController(withIdentifier: "Home") as? UINavigationController)!
                self.window?.rootViewController = homeController*/
            })
        }
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

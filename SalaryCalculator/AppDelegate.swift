//
//  AppDelegate.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 16/6/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn
import Google


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var databaseRef: FIRDatabaseReference!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        GlobalData.signOut = true
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: [:])
    }
    
    /*func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
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
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeController: UINavigationController = (mainStoryboard.instantiateViewController(withIdentifier: "Home") as? UINavigationController)!
                self.window?.rootViewController = homeController
            })
        }
    }*/
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Signed out")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


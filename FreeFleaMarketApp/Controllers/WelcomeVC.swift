//
//  ViewController.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/01/21.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseUI

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//          // ...
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        Auth.auth().removeStateDidChangeListener(handle!)
//
//    }
    
    
    // NOT SURE HOW TO USE THIS
//    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
//      // handle user and error as necessary
//    }


    @IBAction func loginPressed(_ sender: UIButton) {
        
        // GET DEFAULT AUTH UI OBJECT
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            // LOG THE ERROR
            return
        } // HOW DO YOU READ THIS IN PLAIN ENGLISH?  MAKE SURE authUI IS NOT NIL?
        
        // SET SELF AS THE DELEGATE
        authUI?.delegate = self
        
        // GET A REFERENCE TO THE AUTH UI VIEW CONTROLLER
        let authViewController = authUI!.authViewController()
        
        // SHOW IT
        present(authViewController, animated: true, completion: nil)
        
    }
    
}

extension WelcomeVC: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        // CHECK IF THERE WAS AN ERROR
        
        guard error == nil else {
            // LOG THE ERROR
            return
        }
        
//        if error != nil {
//            // LOG ERROR
//            return
//        }
        
        //authDataResult?.user.uid
        
        performSegue(withIdentifier: "goToEventList", sender: self)
        
    }
}

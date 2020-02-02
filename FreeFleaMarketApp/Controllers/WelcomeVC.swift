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
    
    // ADDED HANDLER FROM EXAMPLE CODE
    var handle: AuthStateDidChangeListenerHandle?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // ADDED THIS FROM THE EXAMPLE CODE.  WHAT SHOULD I PUT INSTEAD OF self.tableView.reloadData()?
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      // [START auth_listener]
      handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        // [START_EXCLUDE]
        self.setTitleDisplay(user)
        //self.tableView.reloadData()
        // [END_EXCLUDE]
      }
    }
    
    func setTitleDisplay(_ user: User?) {
      if let name = user?.displayName {
        self.navigationItem.title = "Welcome \(name)"
      } else {
        self.navigationItem.title = "Authentication Example"
      }
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

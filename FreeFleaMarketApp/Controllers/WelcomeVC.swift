//
//  ViewController.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/01/21.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import FirebaseUI

class WelcomeVC: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    


    @IBAction func registerPressed(_ sender: UIButton) {
        
        // GET DEFAULT AUTH UI OBJECT
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            // LOG THE ERROR
            return
        } // CHECK THAT authUI IS NOT NIL
        
        // SET SELF AS THE DELEGATE
        authUI?.delegate = self
        // ONLY USING EMAIL/PASSWORD RIGHT NOW
        authUI?.providers = [FUIEmailAuth()]

        
        // GET A REFERENCE TO THE AUTH UI VIEW CONTROLLER
        // THE PRE-BUILT AUTH VC NEEDS TO BE ASSIGNED TO A VARIABLE SO WE CAN USE IT
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
        
        // THE SAME AS
//        if error != nil {
//            // LOG ERROR
//            return
//        }
        
        //authDataResult?.user.uid
        if authUI.auth?.currentUser != nil {
            performSegue(withIdentifier: "EventList", sender: self)
//            let viewController = EventListUITableVC(
//            self.present(viewController, animated: true, completion: nil)

        } else {
            print("not working")
        }
    
    }
}

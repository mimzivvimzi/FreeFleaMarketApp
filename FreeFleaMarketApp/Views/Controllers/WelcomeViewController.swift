//
//  ViewController.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/01/21.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import FirebaseUI

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var appTitle: UILabel!
    
    @IBAction func unwindToWelcome(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appTitle.clipsToBounds = true
        appTitle.layer.cornerRadius = 20
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    

    @IBAction func loginPressed(_ sender: UIButton) {
        goToAuthUI()
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        goToAuthUI()
    }
    
    // USE FIREBASE UI TO LOGIN OR REGISTER
    func goToAuthUI() {

        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            return
        }
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        let authViewController = authUI!.authViewController()
        present(authViewController, animated: true, completion: nil)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "EventListViewController") as! EventListViewController
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    

    
    
}


extension WelcomeViewController: FUIAuthDelegate {

    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        guard error == nil else {
            return
        }
        
        if authUI.auth?.currentUser != nil {
            performSegue(withIdentifier: "EventList", sender: self)
        } else {
            print("not working")
        }
    
    }
}

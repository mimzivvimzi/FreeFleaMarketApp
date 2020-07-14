//
//  CreditsViewController.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/07/14.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var logoTextView: UITextView!
    @IBOutlet weak var backgroundTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoAttributedString = NSMutableAttributedString(string: "I created my free logo at LogoMakr.com.")
        logoAttributedString.addAttribute(.link, value: "https://www.LogoMakr.com", range: NSRange(location: 24, length: 14))
        logoTextView.attributedText = logoAttributedString
        let backgroundAttributedString = NSMutableAttributedString(string: "I customized the background on my login screen at SVGBackgrounds.com.")
        backgroundAttributedString.addAttribute(.link, value: "https://www.SVGBackgrounds.com", range: NSRange(location: 50, length: 18))
        backgroundTextView.attributedText = backgroundAttributedString
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  NewEventVC.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/01/27.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import Firebase

class NewEventVC: UIViewController {
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    let db = Firestore.firestore()
    let postID = UUID().uuidString


//    @IBOutlet weak var eventDate: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter() // CONVERTS BETWEEN DATES AND THEIR TEXTUAL REPRESENTATION
        dateFormatter.locale = Locale(identifier: "en_US") // jp_JP JAPAN: 2020/03/05
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        let dateToString = dateFormatter.string(from: datePicker.date)
        dateField.text = dateToString
    }
    
    @IBAction func saveEvent(_ sender: UIButton) {
        if Auth.auth().currentUser != nil {
            // HAS TO BE INSIDE THE IF STATEMENT
            let ref = Database.database().reference() //(withPath: "events")
            let userID = Auth.auth().currentUser!.uid //(FUIAuth.defaultAuthUI()?.auth?.currentUser?.uid)! // MIGHT HAVE TO CHANGE THIS TO WIEM'S
            
            let newEvent = Event(user: userID, title: titleField.text ?? "", date: dateField.text ?? "", location: locationField.text ?? "", image: nil, description: descriptionField.text ?? "")
            let eventPost = ["userID": newEvent.user,
                             "title" : newEvent.title,
                             "date" : newEvent.date,
                             "startTime": newEvent.date,
                             "endTime" : "",
                             "location" : newEvent.location,
                             "description": newEvent.description] as [String : Any]
            // SAVING TO THE DB
            ref.child("posts").child("\(postID)").setValue(eventPost)  // POST IS A KEYWORD (POINT OF ENTRY)
//            ref.updateChildValues(eventPost)
            self.navigationController?.popViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
        } else {
          print("No one is signed in")
        }

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

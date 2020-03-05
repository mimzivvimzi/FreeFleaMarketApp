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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    let db = Firestore.firestore()
    var ref: DatabaseReference!
    

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
        dateLabel.text = dateToString
    }
    
    @IBAction func saveEvent(_ sender: UIButton) {
        if Auth.auth().currentUser != nil {
            // HAS TO BE INSIDE THE IF STATEMENT
            ref = Database.database().reference()
            let userID = Auth.auth().currentUser!.uid //(FUIAuth.defaultAuthUI()?.auth?.currentUser?.uid)! // MIGHT HAVE TO CHANGE THIS TO WIEM'S
            
            // DATE WILL BE TODAY'S DATE FOR THE TIME BEING
            guard let key = ref.child("posts").childByAutoId().key else { return }

            let newEvent = Event(user: userID, title: titleField.text ?? "", date: Date(), location: locationField.text ?? "", image: nil, description: descriptionField.text ?? "")
            let eventPost = ["userID": newEvent.user,
                             "title" : newEvent.title,
                             "date" : newEvent.date,
                             "startTime": newEvent.date,
                             "endTime" : "",
                             "location" : newEvent.location,
                             "description": newEvent.description] as [String : Any]
            // SAVING TO THE DB
            ref.child("posts").child(userID).childByAutoId()  // POST IS A KEYWORD (POINT OF ENTRY)
            ref.updateChildValues(eventPost)
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

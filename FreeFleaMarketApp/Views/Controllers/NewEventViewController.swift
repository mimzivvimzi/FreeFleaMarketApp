//
//  NewEvent.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/03/25.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//


import UIKit
import Firebase

class NewEventViewController: UITableViewController {
    

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    let db = Firestore.firestore()
    let postID = UUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        let dateToString = dateFormatter.string(from: datePicker.date)
        dateField.text = dateToString
    }

    @IBAction func saveEvent(_ sender: UIButton) {
        if Auth.auth().currentUser != nil {
            let ref = Database.database().reference()
            let userID = Auth.auth().currentUser!.uid
            let newEvent = Event(user: userID, title: titleField.text ?? "", date: dateField.text ?? "", location: locationField.text ?? "", image: nil, details : descriptionField.text ?? "")
            let eventPost = ["userID": newEvent.user,
                             "title" : newEvent.title,
                             "date" : newEvent.date,
                             "startTime": newEvent.date,
                             "endTime" : "",
                             "location" : newEvent.location,
                             "details": newEvent.details] as [String : Any]
            ref.child("posts").child("\(postID)").setValue(eventPost)
            self.navigationController?.popViewController(animated: true)
    //            self.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
          print("No one is signed in")
        }
    }
}

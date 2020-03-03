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
    @IBOutlet weak var dateField: UIDatePicker!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    let db = Firestore.firestore()

    

    
    var ref: DatabaseReference!
    

//    @IBOutlet weak var eventDate: UITextField!
    
//    private var datePicker: UIDatePicker?  // COME BACK TO THIS LATER.  TRYING TO USE A DATEPICKER FOR CREATING A NEW EVENT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let date = Date()
//        let calendar = Calendar.current
//        let hour = calendar.component(.hour, from: date)
//        let minute = calendar.component(.minute, from: date)
//        print("hours = \(hour):\(minute))")
//
        
        // 3/3 I'M MOST LIKELY GOING TO START FROM SCRATCH REGARDING THE DATE PICKER.  I DON'T REMEMBER WHERE I LEFT OFF WITH THIS.  TRIED TO FOLLOW A YOUTUBE TUTORIAL. DO YOU HAVE ANY RESOURCES FOR THIS? 

//        datePicker = UIDatePicker()
//        datePicker?.datePickerMode = .date
//        datePicker?.addTarget(self, action: #selector(NewEventVC.dateChanged(datePicker:)), for: .valueChanged)
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewEventVC.viewTapped(gestureRecognizer:)))
//
//        view.addGestureRecognizer(tapGesture)
//
//        eventDate.inputView = datePicker
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
    
    
    
    
//    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
//        // EDGE CASE.  IF NO SELECTION IS MADE
//        view.endEditing(true) // DISMISSES THE KEYBOARD
//
//    }
//
//    @objc func dateChanged(datePicker: UIDatePicker) {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyy"
//        eventDate.text = dateFormatter.string(from: datePicker.date)
//        view.endEditing(true) // DISMISSES THE KEYBOARD
//
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

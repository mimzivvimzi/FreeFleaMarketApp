//
//  EventDetailsVC.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/03/23.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseStorage

class EventDetailsViewController: UIViewController {


    
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var selectedEvent : FetchedEvent?
    let storageRef = Storage.storage().reference()
    let reference = Database.database().reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationItem.title = "Event Details"
        editButton.isHidden = true
        saveButton.isHidden = true

        eventTitle.isUserInteractionEnabled = false

        eventTitle.text = selectedEvent?.title
        location.text = selectedEvent?.location
        eventDescription.text = selectedEvent?.details
        
        if Auth.auth().currentUser?.uid  == selectedEvent?.user {
            editButton.isHidden = false
        }
        
        if let postID = selectedEvent?.postID {
            let reference = storageRef.child("Images/\(postID).jpg")
            eventImage.sd_setImage(with: reference)
        }
        
        if let dateTime = selectedEvent?.date.split(separator: " ") {
            if dateTime.count != 0 {
                let separatedDate = dateTime[0] + " " + dateTime[1] + " " + dateTime[2]
                let separatedTime = dateTime[4] + " " + dateTime[5]
                date.text = "Date: \(separatedDate)"
                time.text = "Time: \(separatedTime)"
            }
        }
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
//        eventTitle.isUserInteractionEnabled = true
//        date.isUserInteractionEnabled = true
//        time.isUserInteractionEnabled = true
//        location.isUserInteractionEnabled = true
//        eventDescription.isUserInteractionEnabled = true
//
//        eventTitle.borderStyle = .roundedRect
//        date.borderStyle = .roundedRect
//        time.borderStyle = .roundedRect
//        location.borderStyle = .roundedRect
//        eventDescription.borderStyle = .roundedRect
    }
    
    
    @IBAction func saveTapped(_ sender: UIButton) {
//        if Auth.auth().currentUser != nil {
//            let ref = Database.database().reference()
//            let userID = Auth.auth().currentUser!.uid
//            if let postID = selectedEvent?.postID {
//                let eventPost = ["userID": userID,
//                                 "title" : eventTitle.text ?? "",
//                                 "date" : date.text ?? "",
//                                 "startTime": time.text ?? "",
//                                 "endTime" : "",
//                                 "location" : location.text ?? "",
//                                 "imageURL" : selectedEvent?.imageURL ?? "",
//                                 "details": eventDescription.text ?? ""] as [String : Any]
//                ref.child("posts").child("\(postID)").updateChildValues(eventPost)
//            }
//            self.navigationController?.popViewController(animated: true)
//        } else {
//          print("No one is signed in")
//        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit" {
            let destinationVC = segue.destination as! EditEventViewController
            destinationVC.selectedEvent = selectedEvent
        }
    }
    
    
    
    
}

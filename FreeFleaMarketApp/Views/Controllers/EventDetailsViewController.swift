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

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var testTitle: UITextField!
    @IBOutlet weak var editButton: UIButton!
    
    var selectedEvent : FetchedEvent?
    let storageRef = Storage.storage().reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Event Details"
        editButton.isHidden = true
        testTitle.isUserInteractionEnabled = false

        testTitle.text = selectedEvent?.title
        location.text = selectedEvent?.location
        eventDescription.text = selectedEvent?.details
        
        if Auth.auth().currentUser?.uid  == selectedEvent?.user {
            editButton.isHidden = false
        }
        
        if let postID = selectedEvent?.postID {
            let reference = storageRef.child("Images/\(postID).jpg")
            print(reference)
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
        testTitle.isUserInteractionEnabled = true
    }
}

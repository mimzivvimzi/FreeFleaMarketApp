//
//  NewEventVC.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/01/27.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseStorage get it by adding this pod to the podfile then run pod install as usual  pod 'Firebase/Storage'

class NewEventViewController: UIViewController {
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
            // SAVING TO THE DB
            ref.child("posts").child("\(postID)").setValue(eventPost)  // POST IS A KEYWORD (POINT OF ENTRY)
            self.navigationController?.popViewController(animated: true)
//            self.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
          print("No one is signed in")
        }

    }
    
    //uncomment the import statement then uncomment the function
//    func saveImageToFirebase(){
//        let image = UIImage(named: "AppIcon")!
//        let imageRef = Storage.storage().reference().child("test_image.jpg")
//        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
//            guard let downloadURL = downloadURL else {
//                return
//            }
//
//            let urlString = downloadURL.absoluteString
//            print("image url: \(urlString)")
//        }
//
//    }
}


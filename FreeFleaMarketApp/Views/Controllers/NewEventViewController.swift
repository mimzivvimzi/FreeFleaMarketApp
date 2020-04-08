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
    
    @IBOutlet weak var testImage: UIImageView!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
//    let db = Firestore.firestore()
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
    
    
    @IBAction func testButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Upload a photo", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            print("User clicked the camera button")
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))

        alert.addAction(UIAlertAction(title: "Photo album", style: .default, handler: { (_) in
            print("User clicked the photo album button")
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User clicked the dismiss button")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
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


extension NewEventViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
    // imageViewPic.contentMode = .scaleToFill
            testImage.image = pickedImage
            }
            picker.dismiss(animated: true, completion: nil)
    }
}

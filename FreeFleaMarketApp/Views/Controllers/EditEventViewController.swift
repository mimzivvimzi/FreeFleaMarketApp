//
//  EditEventViewController.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/04/18.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import Firebase

class EditEventViewController: UITableViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var selectedImage: UIImageView!

    var selectedEvent : FetchedEvent?
    let storageRef = Storage.storage().reference()
    let reference = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            navigationItem.title = "Edit Event"
        
        titleField.text = selectedEvent?.title
        dateField.text = selectedEvent?.date
        locationField.text = selectedEvent?.location
        descriptionField.text = selectedEvent?.details
        
        if let postID = selectedEvent?.postID {
            let reference = storageRef.child("Images/\(postID).jpg")
            print(reference)
            selectedImage.sd_setImage(with: reference)
        }
        
    }

    @IBAction func dateSelected(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        let dateToString = dateFormatter.string(from: datePicker.date)
        dateField.text = dateToString
    }
    
    @IBAction func uploadPhoto(_ sender: UIButton) {
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
            if let postID = selectedEvent?.postID {
                let eventPost = ["userID": userID,
                                "title" : titleField.text ?? "",
                                "date" : dateField.text ?? "",
                                "startTime": dateField.text ?? "",
                                "endTime" : "",
                                "location" : locationField.text ?? "",
                                "imageURL" : selectedEvent?.imageURL,
                                "details": descriptionField.text ?? ""] as [String : Any]
                ref.child("posts").child("\(postID)").updateChildValues(eventPost)
            }
            let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventList") as! UINavigationController
            self.view.window?.rootViewController = ViewController
        } else {
          print("No one is signed in")
        }
        //        let postID = selectedEvent?.postID
        //        let image = selectedImage.image!
        //        let imageRef = Storage.storage().reference().child("Images/\(postID).jpg")
        //        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
        //            guard let downloadURL = downloadURL else {
        //                return
        //            }
        //            let urlString = downloadURL.absoluteString
        //            print("image url: \(urlString)")
        //            self.saveEvent(imageURL: urlString)
        //        }
    }
    
//    func saveEvent(imageURL: String) {
//
//    }
    
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete Event", message: "Are you sure you want to permanently delete this event?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            if let postID = self.selectedEvent?.postID {
                self.remove(postID: postID)
            }
            let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventList") as! UINavigationController
            self.view.window?.rootViewController = ViewController
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func remove(postID: String) {
        let reference = self.reference.child("posts").child("\(postID)")
        reference.removeValue { error, _ in
            print(error)
        }
    }
    
   
}
        
extension EditEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            selectedImage.image = pickedImage
            }
            picker.dismiss(animated: true, completion: nil)
    }
}

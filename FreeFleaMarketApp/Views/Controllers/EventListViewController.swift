//
//  EventListUITableVC.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/01/21.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseStorage
import SwiftyJSON


class EventListViewController: UITableViewController {

    var selectedIndexPath: Int?
    var eventList : [FetchedEvent] = []
    var myImageView = UIImageView()
    let storageRef = Storage.storage().reference()
    var eventListCount: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        fetch()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        navigationItem.title = "Events"
        tableView.rowHeight = 300
    }
    
    // LOG OUT AND RETURN TO THE WELCOME VIEW CONTROLLER
    @IBAction func logoutPressed(_ sender: Any) {
        let authUI: FUIAuth = FUIAuth.defaultAuthUI()!
        do {
            try authUI.signOut()
//            print(authUI.auth?.currentUser)
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! UINavigationController
            self.view.window?.rootViewController = loginViewController
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
        
    // FETCH ALL EVENTS IN THE FIREBASE REALTIME DATABASE
    func fetch() {
        eventList = []
        let ref: DatabaseReference! = Database.database().reference()
        ref.observe(.childAdded , with: { (snapshot) in
            if let value = snapshot.value as? [String : [String : String?]] {
                let json = JSON(value)
                let keys = value.keys
                for element in keys {
                    var postID = ""
//                    var previousPostID = "test"
                    for key in keys {
                        if element == key {
                            postID = key
//                            guard previousPostID != postID else {
//                                print("return because \(previousPostID) == \(postID)")
//                                return
//                            }
                        }
//                        previousPostID = postID
                    }
                    let fetchedEvent = FetchedEvent(json: json[element], postID: postID)
                    self.eventList.append(fetchedEvent)
//                    guard keys.count != 1 else {
//                        print("return \n")
//                        return
//                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) {(error) in
        print(error.localizedDescription)
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventListTableCell
        let event = eventList[indexPath.row]
        cell.eventTitle.text = event.title
        let dateTime = event.date.split(separator: " ")
        if dateTime.count != 0 {
            let date = dateTime[0] + " " + dateTime[1] + " " + dateTime[2]
            let time = dateTime[4] + " " + dateTime[5]
            cell.date.text = "Date: \(date)"
            cell.time.text = "Time: \(time)"
        }
        cell.location.text = event.location
        let reference = storageRef.child("Images/\(event.postID!).jpg")
        cell.eventImage.sd_setImage(with: reference)
        cell.eventDescriptionLabel.text = event.details
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath.row
        performSegue(withIdentifier: "goToDetails", sender: selectedIndexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let event = eventList[indexPath.row]
                let destinationVC = segue.destination as! EventDetailsViewController
                destinationVC.selectedEvent = event
            }
        }
    }
}

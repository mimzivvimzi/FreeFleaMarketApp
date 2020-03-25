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


class EventListVC: UITableViewController {
    
//    let db = Firestore.firestore()
//    var databaseHandle : DatabaseHandle?
    var selectedIndexPath: Int?
    var eventList : [Event] = []
//    [Event(user: "someone", title: "Clothing Swap at Cafe 123", date: "", location: "Cafe 123", image: UIImage(named: "waterfall"), details: "woow")]
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        let authUI: FUIAuth = FUIAuth.defaultAuthUI()!
        do {
            try authUI.signOut()
            print(authUI.auth?.currentUser)
//            performSegue(withIdentifier: "goToLogin", sender: self)

            // DISPLAY THE WELCOMEVC - NOT WORKING
            //navigationController?.popToRootViewController(animated: true)
            
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
        // take to login screen

        
        // OR YOU CAN CHAIN IT LIKE
//        do {
//          try Auth.auth().signOut()
//        } catch let signOutError as NSError {
//          print ("Error signing out: %@", signOutError)
//        }
        
        
//        let authUI: FUIAuth = FUIAuth.defaultAuthUI()!
//        do {
//            try authUI.signOut()
//        } catch{
//            //handle error
//            print(error)
//        }
        

    func fetch() {
        eventList = []
        let ref: DatabaseReference! = Database.database().reference()
        ref.observe(.childAdded , with: { (snapshot) in
//        ref.child("posts").observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String : [String : String?]] {
                print("Value of the snapshot: \(value)")
//                for (name, path) in dict {
//                    print("The path to '\(name)' is '\(path)'.")
//                }
                for element in value.keys {
                    print("This is the value.keys count: \(value.keys.count)")
                    let fetchedEvent = Event(user: value[element]!["userID"]! ?? "", title: value[element]!["title"]! ?? "", date: value[element]!["date"]! ?? "", location: value[element]!["location"]! ?? "", image: nil, details: value[element]!["details"]! ?? "")
                    print("fetched event title: \(fetchedEvent.title)")
                    self.eventList.append(fetchedEvent)
                }
                print("This is the eventList.count: \(self.eventList.count)")
                print("Event 0's title: \(self.eventList[0].title)")
                print("------------")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) {(error) in
        print(error.localizedDescription)
        }
    }

//    func fetch() {
//        let ref: DatabaseReference! = Database.database().reference()
//        // TODO: APPEND THE EVENTS TO THE EVENTLIST ARRAY
////        ref?.child("posts").observe(.value, with: { (snapshot) in
//        ref.child("posts").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let value = snapshot.value as? [String : [String : String?]] {
//                print(value)
////                for (name, path) in dict {
////                    print("The path to '\(name)' is '\(path)'.")
////                }
//                for element in value.keys {
//                    let fetchedEvent = Event(user: value[element]!["userID"]! ?? "", title: value[element]!["title"]! ?? "", date: value[element]!["date"]! ?? "", location: value[element]!["location"]! ?? "", image: nil, details: value[element]!["details"]! ?? "")
//                    self.eventList.append(fetchedEvent)
//                    print(self.eventList[1].title)
//                }
//            }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }) {(error) in
//        print(error.localizedDescription)
//        }
//
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetch()
        self.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // THIS VC THAT WE'RE IN RIGHT NOW WILL TAKE ON THE TASK OF RECEIVING THE TABLEVIEW 
        self.tableView.delegate = self
        fetch()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // CURRENTLY THE NUMBER OF ITEMS IN THE ARRAY
        return eventList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // CREATING A REUSABLE CELL CALLED "CELL"
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventListTableCell
        // TAKING THE 0TH EVENT
//        let currentEvent = eventList[0]
        
        /*
         // TAKING THE CURRENT DATE/TIME AS A TIMESTAMP
         let date = Date()
         // USING THE GREGORIAN CALENDAR
         let calendar = Calendar.current
         // SEPARATE OUT THE DAY FROM THE CALENDAR
         let day = calendar.component(.day, from: date)
         // SEPARATE OUT THE HOUR
         let hour = calendar.component(.hour, from: date)
         // SEPARATE OUT THE MINUTES
         let minute = calendar.component(.minute, from: date)
         */

        
        // SETTING EACH LABEL ON THE CELL TO THE EVENT OBJECT.
//        for element in 0..<eventList.count {
//            cell.eventTitle.text = eventList[element].title
//            cell.date.text = "On the \(eventList[element].date)"
////            cell.time.text = "\(hour):\(minute)"
//            cell.location.text = eventList[element].location
//            cell.eventImage.image = eventList[element].image
//            cell.eventDescriptionLabel.text = eventList[element].details
//        }
        
        cell.eventTitle.text = eventList[indexPath.row].title
        cell.date.text = "Date and Time: \(eventList[indexPath.row].date)"
//            cell.time.text = "\(hour):\(minute)"
        cell.location.text = eventList[indexPath.row].location
        cell.eventImage.image = eventList[indexPath.row].image
        cell.eventDescriptionLabel.text = eventList[indexPath.row].details
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath.row
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "goToDetails", sender: cell)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            let event = eventList[indexPath!.row]
            let destinationVC = segue.destination as! EventDetailsVC
            destinationVC.theTitle = event.title
            destinationVC.theDate = event.date
            destinationVC.theLocation = event.location
            destinationVC.theDescription = event.details
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

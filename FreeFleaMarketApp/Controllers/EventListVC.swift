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
    
    let db = Firestore.firestore()
    var ref: DatabaseReference!
    var databaseHandle : DatabaseHandle?

    
    
    // THIS IS CREATING AN ARRAY OF TYPE "EVENT" AND HARD CODING AN INSTANCE OF A TEST EVENT IN THAT ARRAY.
    
    var eventList : [Event] = [Event(user: "someone", title: "Clothing Swap at Cafe 123", date: "", location: "Cafe 123", image: UIImage(named: "waterfall"), details: "woow")]
    
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
        //take to login screen
        
        // THIS KEEPS ADDING VCs ON TOP OF VCs.  NOT THE RIGHT SOLUTION
//        if let storyboard = self.storyboard {
//            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
//            // WHY IS IT self.present?  NOT IN A CLOSURE, BUT...
//            self.present(vc, animated: true, completion: nil)
//            }
        
//        let loginVC = self.storyboard?.instantiateViewController(identifier: "loginVC")
//
//        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        appDel.window?.rootViewController = loginVC
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // THIS VC THAT WE'RE IN RIGHT NOW WILL TAKE ON THE TASK OF RECEIVING THE TABLEVIEW 
        self.tableView.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        ref = Database.database().reference()

//        ref.observeSingleEvent(of: .value) { (snapshot) in
//            if let data = snapshot.value as? [String : Any] {
//                print(data["posts"])
//            }
//        }
        
//        let postRef = self.ref.child("postID")
//        postRef.observe(.value, with: { (snapshot) in
//            for child in snapshot.children {
//                let childSnap = child as! DataSnapshot
//                let dict = childSnap.value as! [String: Any]
//                let title = dict["title"] as! String
//                let date = dict["date"] as! String
//                print(childSnap.key, title, date)
//            }
//            DispatchQueue.main.async {
//            self.tableView.reloadData()
//            }
//        })
        
        
        
        // TODO: APPEND THE EVENTS TO THE EVENTLIST ARRAY
        databaseHandle = ref?.child("posts").observe(.value, with: { (snapshot) in
            if let value = snapshot.value as? [String : [String : String?]] {
//                for (name, path) in dict {
//                    print("The path to '\(name)' is '\(path)'.")
//                }
                for element in value.keys {
                    let fetchedEvent = Event(user: value[element]!["userID"]! ?? "", title: value[element]!["title"]! ?? "", date: value[element]!["date"]! ?? "", location: value[element]!["location"]! ?? "", image: nil, details: value[element]!["details"]! ?? "")
                    self.eventList.append(fetchedEvent)
                    print(self.eventList[1].title)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) {(error) in
        print(error.localizedDescription)
        }
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

//
//  EventDetailsVC.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/03/23.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit

class EventDetailsVC: UIViewController {

    @IBOutlet weak var eventTitle: UILabel!
    var theTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTitle.text = theTitle
        // Do any additional setup after loading the view.
    }
    

    /*
             cell.eventTitle.text = eventList[indexPath.row].title
             cell.date.text = "Date and Time: \(eventList[indexPath.row].date)"
     //            cell.time.text = "\(hour):\(minute)"
             cell.location.text = eventList[indexPath.row].location
             cell.eventImage.image = eventList[indexPath.row].image
             cell.eventDescriptionLabel.text = eventList[indexPath.row].details
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
}

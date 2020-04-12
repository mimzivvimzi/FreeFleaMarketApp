//
//  EventDetailsVC.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/03/23.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    var selectedEvent : FetchedEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTitle.text = selectedEvent?.title
        location.text = selectedEvent?.location
        eventDescription.text = selectedEvent?.details
        navigationItem.title = "Event Details"
        if let dateTime = selectedEvent?.date.split(separator: " ") {
            if dateTime.count != 0 {
                let separatedDate = dateTime[0] + " " + dateTime[1] + " " + dateTime[2]
                let separatedTime = dateTime[4] + " " + dateTime[5]
                date.text = "Date: \(separatedDate)"
                time.text = "Time: \(separatedTime)"
            }
        }
    }
}

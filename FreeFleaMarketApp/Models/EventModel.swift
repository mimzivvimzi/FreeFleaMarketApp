//
//  Event.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/01/24.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import Foundation
import FirebaseAuth


class Event {
    var owner: String
    var title: String
    var date:  Date // MAYBE USE DateFormatter() IN A DIFFERENT PART OF THIS PROJECT?
    // NEED TO FIGURE OUT WHAT 'TIME' WILL BE.  JUST USE date FOR THE DATE AND TIME?  SINCE IT CAN HOLD DATE AND TIME INFO?
    var location: String // NEED TO FIGURE OUT HOW TO USE LOCATION INFO.  IT WOULDN'T BE A STRING, IT WOULD BE SOME OTHER DATA TYPE.
    var image: UIImage?
    var description: String

    init(owner: String, title: String, date: Date, location: String, image: UIImage?, description: String) {
        self.owner = owner
        self.title = title
        self.date = date
        self.location = location
        self.image = image
        self.description = description
    }

}


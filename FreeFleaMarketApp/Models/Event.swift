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
    var user: String
    var title: String
    var date:  String
    var location: String 
    var image: String
    var details: String

    init(user: String, title: String, date: String, location: String, image: String, details: String) {
        self.user = user
        self.title = title
        self.date = date
        self.location = location
        self.image = image
        self.details = details
    }

}


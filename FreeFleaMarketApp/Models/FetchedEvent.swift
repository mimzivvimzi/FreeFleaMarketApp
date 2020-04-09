//
//  FetchedEvent.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/04/09.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import Foundation
import SwiftyJSON

class FetchedEvent {
    var user: String
    var title: String
    var date:  String
    var location: String
    var details: String
    var imageURL: String

    init(json: JSON) {
        self.user = json["userID"].stringValue
        self.title = json["title"].stringValue
        self.date = json["date"].stringValue
        self.location = json["location"].stringValue
        self.details = json["details"].stringValue
        self.imageURL = json["imageURL"].stringValue
    }
}



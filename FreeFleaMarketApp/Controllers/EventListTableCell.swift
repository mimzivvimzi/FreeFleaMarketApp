//
//  EventListTableCell.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/01/21.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import Foundation

class EventListTableCell: UITableViewCell {
    
    // CONNECT ALL OF THE LABELS IN THE TABLEVIEW CELL IN THE MAIN STORYBOARD
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var eventDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

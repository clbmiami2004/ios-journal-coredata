//
//  EntryTableViewCell.swift
//  iOS Journal-CoreData
//
//  Created by Lambda_School_Loaner_201 on 12/4/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    var entry: Entry? {
        didSet {
            setUpViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    

    private func setUpViews() {
        guard let entry = entry else {return}
        titleLabel?.text = entry.title
        let formDate = DateFormatter()
        formDate.dateFormat = "yyy-MM-dd  hh:mm a"
        timeStampLabel?.text = formDate.string(from: entry.timestamp!)
        bodyLabel?.text = entry.bodyText
    }
}

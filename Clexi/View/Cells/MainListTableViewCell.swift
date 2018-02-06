//
//  MainListTableViewCell.swift
//  Clexi
//
//  Created by Hassan Shahbazi on 2018-02-05.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class MainListTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var url: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

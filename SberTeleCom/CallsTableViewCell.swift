//
//  CallsTableViewCell.swift
//  SberTeleCom
//
//  Created by Mikhail Seregin on 18.12.2018.
//  Copyright © 2018 Mikhail Seregin. All rights reserved.
//

import UIKit

class CallsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var managerLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var callTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  StatusTableViewCell.swift
//  TableViewExpandAndCollpase
//
//  Created by R.Unnikrishnan on 18/05/23.
//

import UIKit

class StatusTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

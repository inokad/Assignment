//
//  DataViewTableCell.swift
//  SPHAssignment
//
//  Created by Inoka Dissanayaka on 12/20/18.
//  Copyright © 2018 Inoka Dissanayaka. All rights reserved.
//

import UIKit

class DataViewTableCell: UITableViewCell {

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var dataUsageLabel: UILabel!
    @IBOutlet weak var decreasedDataImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

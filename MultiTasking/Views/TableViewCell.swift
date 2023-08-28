//
//  TableViewCell.swift
//  MultiTasking
//
//  Created by Dinesh Sharma on 27/08/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

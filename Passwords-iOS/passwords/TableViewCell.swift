//
//  TableViewCell.swift
//  passwords
//
//  Created by Valeria Conde on 6/12/19.
//  Copyright © 2019 Valeria Conde. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lbRed: UILabel!
    @IBOutlet weak var imLogo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

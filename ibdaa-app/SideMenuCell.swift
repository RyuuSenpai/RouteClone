//
//  SideMenuCell.swift
//  White_Label
//
//  Created by Killvak on 23/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var sideMenuImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

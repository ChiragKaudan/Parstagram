//
//  CommentCell.swift
//  Parstagram
//
//  Created by Chirag Kaudan on 10/8/20.
//  Copyright © 2020 fmoonlclassic. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

 
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

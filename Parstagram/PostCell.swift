//
//  PostCell.swift
//  Parstagram
//
//  Created by Chirag Kaudan on 10/1/20.
//  Copyright © 2020 fmoonlclassic. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

  
    @IBOutlet weak var photoView: UIImageView!
    
  
    
    @IBOutlet weak var usernameLabel: UILabel!

    @IBOutlet weak var captionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

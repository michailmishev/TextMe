//
//  CustomTableViewCell.swift
//  TextMe
//
//  Created by Michail Mishev on 6/12/17.
//  Copyright © 2017 Michail Mishev. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundMessage: UIView!
    @IBOutlet weak var avatarImageVIew: UIImageView!
    @IBOutlet weak var senderUsername: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }

   
    
}



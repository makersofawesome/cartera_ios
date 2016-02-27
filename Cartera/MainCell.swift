//
//  MainCellTableViewCell.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImage = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        avatarImage.layer.cornerRadius = 8.0
        avatarImage.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

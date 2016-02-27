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
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var requestStatusText: UILabel!
    @IBOutlet weak var distanceStamp: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    var user: User!
    
    var request: Request! {
        didSet {
            name.text = "\(request.user.username!)"
            print(name.text)
//            avatarImage = UIImageView(frame: CGRectMake(0, 0, 100, 100))
//            avatarImage.layer.cornerRadius = 8.0
//            avatarImage.clipsToBounds = true
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

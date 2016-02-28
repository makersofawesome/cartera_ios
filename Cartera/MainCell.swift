//
//  MainCellTableViewCell.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class MainCell: UITableViewCell//MGSwipeTableCell 
{
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var requestStatusText: UILabel!
    @IBOutlet weak var distanceStamp: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    var request: Request! {
        didSet {
            let amt = String(format: "%\(0.2)f", request.amount!)
            amount.text = "$\(amt)"
            //            avatarImage = UIImageView(frame: CGRectMake(0, 0, 100, 100))
//            avatarImage.layer.cornerRadius = 8.0
//            avatarImage.clipsToBounds = true
            
        }
    }
    var user: User! {
        didSet {
            print(user.username)
            self.name.text = "\(user.username!)"
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

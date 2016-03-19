//
//  MainCellTableViewCell.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import FGInitialsCircleSwift
import ChameleonFramework

class MainCell: UITableViewCell//MGSwipeTableCell
{
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    var amount: Float = 0.0
    var request: Request! {
        didSet {
            amount = request.amount!
            timeStamp.text = "\(getTimeDifference()!)"
            
        }
    }
    var user: User! {
        didSet {
            	
            let first = user.firstName!
            let last = user.lastName!
            let amt = String(format: "%\(0.2)f", amount)

            name.text = "\(first) \(last) has requested $\(amt)"
            self.avatarImage.image = FGInitialCircleImage.circleImage(first, lastName: last, size: avatarImage.frame.size.width, borderWidth: 5, borderColor: FlatPurpleDark(), backgroundColor: FlatPurpleDark(), textColor: UIColor.whiteColor())
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
    }
    
    
    func getTimeDifference() -> String! {
        let elapsedTime = NSDate().timeIntervalSinceDate(request.createdAt!)
        let time_in_int = NSInteger(elapsedTime)
        let (year, month, day, hours, minutes, seconds)  = convertSeconds(time_in_int)
        if year > 1 {
            return "\(year)y"
        }
        else if month > 1 {
            return "\(month)m"
        }
        else if day > 1 {
            return "\(day)d"
        }
        else if hours > 1 {
            return "\(hours)h"
        }
        else if minutes > 1 {
            return "\(minutes)m"
        }
        else {
            return "\(seconds)s"
        }
    }
    func convertSeconds (seconds : Int) -> (Int, Int, Int, Int, Int, Int) {
        return (seconds / 31557600, seconds / 2628000, seconds / (3600 * 24), seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

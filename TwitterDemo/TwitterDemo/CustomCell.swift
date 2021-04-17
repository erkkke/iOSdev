//
//  CustomCell.swift
//  TwitterDemo
//
//  Created by Erkebulan on 15.04.2021.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var email: UILabel!

    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var hashtag: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.frame.height/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

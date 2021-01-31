//
//  CustomTableViewCell.swift
//  sideMenuPractic
//
//  Created by heawon on 2021/01/28.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var tilteLabel: UILabel!
    @IBOutlet weak var authorName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundImage.contentMode = .scaleToFill
        
        //저자 이미지 원형으로 만들기
        authorImage.contentMode = .scaleToFill
        authorImage.layer.cornerRadius = authorImage.frame.width / 2
        authorImage.layer.masksToBounds = true

        tilteLabel.textColor = .white

        tilteLabel.numberOfLines = 0
        tilteLabel.adjustsFontSizeToFitWidth = true
        
        tilteLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        authorName.textColor = .white
        authorName.alpha = 0.8
    }
    
    

}

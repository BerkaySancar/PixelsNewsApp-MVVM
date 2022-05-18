//
//  HomeTableViewCell.swift
//  PixelsNews
//
//  Created by Berkay Sancar on 17.05.2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    
    }

}

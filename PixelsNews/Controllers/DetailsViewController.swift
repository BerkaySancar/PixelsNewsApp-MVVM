//
//  SettingsViewController.swift
//  PixelsNews
//
//  Created by Berkay Sancar on 12.05.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    var incomingTitle : String?
    var incomingImage : String?
    var incomingDescription : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleLabel.adjustsFontSizeToFitWidth = true  // dene ! gelen yazı ile aynı boyutta olması için
        
        // Do any additional setup after loading the view.
        
        titleLabel.text = incomingTitle
        imageView.load(url: URL(string: incomingImage ?? "PixelsLogo")!)
        descriptionTextView.text = incomingDescription
        
        
        
    }
    
    
}


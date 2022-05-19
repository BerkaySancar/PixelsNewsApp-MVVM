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
    
    
    var article = ArticleUIModel()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleLabel.adjustsFontSizeToFitWidth = true  // dene ! gelen yazı ile aynı boyutta olması için
        
        
        // Do any additional setup after loading the view.
        
        titleLabel.text = article.title
        imageView.load(url: URL(string: article.urlToImage ?? "PixelsLogo")!)
        descriptionTextView.text = article.description
        
        
        
    }
    
    
}


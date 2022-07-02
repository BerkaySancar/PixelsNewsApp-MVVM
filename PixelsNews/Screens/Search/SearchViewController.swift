//
//  SearchViewController.swift
//  PixelsNews
//
//  Created by Berkay Sancar on 12.05.2022.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
   
    @IBOutlet weak var searchController: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.delegate = self
    }
   
    
    //search bar için kullanılacak func.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
  
    @IBAction func firstTopicButton(_ sender: Any) {
    }
    
    @IBAction func secondTopicButton(_ sender: Any) {
    }
    
    @IBAction func thirdTopicButton(_ sender: Any) {
    }
}


//
//  ViewController.swift
//  PixelsNews
//
//  Created by Berkay Sancar on 12.05.2022.
//

import UIKit

class SelectTopicsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goToHomeButton(_ sender: Any) {
        
        print("buton tiklandı")
        performSegue(withIdentifier: "toHomeVC", sender: nil)
    }
    
}


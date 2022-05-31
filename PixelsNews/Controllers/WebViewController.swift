//
//  WebViewController.swift
//  PixelsNews
//
//  Created by Berkay Sancar on 19.05.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var article = ArticleUIModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.navigationDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let urlString = article.url
        let url = URL(string: urlString!)
        
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
    }
    

}

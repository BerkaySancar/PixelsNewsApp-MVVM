import UIKit
import WebKit

final class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var upcomingURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let url = URL(string: upcomingURL) else {return}
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
}

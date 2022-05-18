//
//  HomeViewController.swift
//  PixelsNews
//
//  Created by Berkay Sancar on 12.05.2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var titleArr = [String?]()
    var urlToImageArr = [String?]()
    var descriptionArr = [String?]()
    
    var selectedTitle : String?
    var selectedImage : String?
    var selectedDescription : String?
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
        
        
        
    }
    
    /* ------------- TableView ------------- */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
        
        cell.cellTitle.text = titleArr[indexPath.row]
        
        let imageUrl = urlToImageArr[indexPath.row] ?? "PixelsLogo" // image gelmezse
        cell.cellImage.load(url: URL(string: imageUrl)!)//load -> extension
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTitle = titleArr[indexPath.row]
        selectedImage = urlToImageArr[indexPath.row]
        selectedDescription = descriptionArr[indexPath.row]
        
        performSegue(withIdentifier: "toDetailsVC", sender: selectedTitle)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            
            let destinationVC = segue.destination as! DetailsViewController
            
            destinationVC.incomingTitle = selectedTitle
            destinationVC.incomingImage = selectedImage
            destinationVC.incomingDescription = selectedDescription
            
            
        
            
        }
       
    }
    
    /* ------------- M E T H O D S ------------- */
    
    func loadData() {
        
        
        titleArr = []
        urlToImageArr = []
        
        
        let jsonUrl = "https://newsapi.org/v2/top-headlines?country=tr&apiKey=\(Config.API_KEY)"
        
       
        guard let url = URL(string: jsonUrl) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            guard let data = data else { return }
            
            do {
                let baseResponse = try JSONDecoder().decode(BaseResponse.self, from: data)
                
                
                for elements in baseResponse.articles {
                    self.titleArr.append(elements.title)
                    self.urlToImageArr.append(elements.urlToImage)
                    self.descriptionArr.append(elements.description)
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    
                }
                
            } catch let jsonErr {
                print("error serializing json:", jsonErr)
            }

        }.resume()
    }
    
}

/* jsondan url olarak gelen resmi image a çevirmek için */

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}



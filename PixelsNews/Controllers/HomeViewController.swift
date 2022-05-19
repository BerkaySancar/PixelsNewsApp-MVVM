//
//  HomeViewController.swift
//  PixelsNews
//
//  Created by Berkay Sancar on 12.05.2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var articleList = [ArticleResponse]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    
    }
    
    /* ------------- TableView ------------- */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
        
        let row = articleList[indexPath.row]
        

        //Title
        cell.cellTitle.text = row.title
        
        //Image
        let imageUrl = row.urlToImage ?? "PixelsLogo" // image gelmezse
        cell.cellImage.load(url: URL(string: imageUrl)!)//load -> extension
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedArticle = articleList[indexPath.row]
        
        performSegue(withIdentifier: "toDetailsVC", sender: selectedArticle)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            
            let destinationVC = segue.destination as! DetailsViewController
            
            let article = sender as! ArticleResponse
            
            
            let artictleUIModel = ArticleUIModel(
                author: article.author,
                title: article.title,
                description: article.description,
                url: article.url,
                urlToImage: article.urlToImage,
                publishedAt: article.publishedAt,
                content: article.content
            )
            
            destinationVC.article = artictleUIModel
            
            
        }
       
    }
    
    /* ------------- M E T H O D S ------------- */
    
    func loadData() {
        
        
        let jsonUrl = "https://newsapi.org/v2/top-headlines?country=tr&apiKey=\(Config.API_KEY)"
        
       
        guard let url = URL(string: jsonUrl) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            guard let data = data else { return }
            
            do {
                let baseResponse = try JSONDecoder().decode(BaseResponse.self, from: data)
                
                self.articleList = baseResponse.articles
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    
                }
                
            } catch let jsonErr {
                print("error serializing json:", jsonErr)
            }

        }.resume()
    }
    
}


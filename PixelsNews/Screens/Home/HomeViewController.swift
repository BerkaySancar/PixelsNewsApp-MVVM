import UIKit

protocol HomeViewControllerOutput {
    
    func newsData(news: [Article])
}

final class HomeViewController: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleCollectionView: UICollectionView!
    
    private var articleList = [Article]()
    lazy var viewModel: HomeViewControllerDelegate = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        titleCollectionView.delegate = self
        titleCollectionView.dataSource = self
        
        viewModel.fetchNews()
        viewModel.setDelegate(output: self)
    }
}
//MARK: - HomeViewControllerOutput
extension HomeViewController: HomeViewControllerOutput {
    
    func newsData(news: [Article]) {
        DispatchQueue.main.async {
            self.articleList = news
            self.tableView.reloadData()
        }
    }
}
// MARK: - COLLECTIONVIEW
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = titleCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HomeTitlesCollectionViewCell else { return UICollectionViewCell()}
        
        
        return cell
    }
}
// MARK: - TABLEVIEW
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HomeTableViewCell else {return UITableViewCell()}
        
        let row = articleList[indexPath.row]
        cell.cellTitle.text = row.title
        
        let imageUrl = row.urlToImage ?? "PixelsLogo"
        cell.cellImage.load(url: URL(string: imageUrl)!)  //load -> extension
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedNewsURL = articleList[indexPath.row].url else {return}
        print(selectedNewsURL)
        
        performSegue(withIdentifier: "toWebVC", sender: selectedNewsURL)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toWebVC" {
            
            guard let destinationVC = segue.destination as? WebViewController else { return }
            let indexPath = self.tableView.indexPathForSelectedRow
            guard let indexUrl = articleList[(indexPath?.row)!].url else {return}
            destinationVC.upcomingURL = indexUrl
        }
    }
}

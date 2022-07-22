import UIKit

protocol HomeViewControllerOutput {
    
    func newsData(news: [Article])
    func businessData(news: [Article])
    func entertainmentData(news: [Article])
    func healthData(news: [Article])
    func scienceData(news: [Article])
    func sportsData(news: [Article])
    func technologyData(news: [Article])
}

final class HomeViewController: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleCollectionView: UICollectionView!
    @IBOutlet weak var topicLabel: UILabel!

    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    lazy var viewModel: HomeViewControllerDelegate = HomeViewModel()
    
    private var articleList: [Article] = [Article]()
    private var businessList: [Article] = [Article]()
    private var entertainmentList: [Article] = [Article]()
    private var healthList: [Article] = [Article]()
    private var scienceList: [Article] = [Article]()
    private var sportList: [Article] = [Article]()
    private var technologyList: [Article] = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        titleCollectionView.delegate = self
        titleCollectionView.dataSource = self
        
        self.viewModel.fetchNews()
        self.viewModel.getTopics()
        self.viewModel.setDelegate(output: self)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.tableView.refreshControl = refreshControl
    }
//MARK: - Refresh Func for TableView
    @objc func refresh(sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
//MARK: - Did tap topic button
    @objc func topicTapped(_ sender: UIButton) {
        
        if sender.currentTitle == "İş" {
            articleList = businessList
            topicLabel.text = "İş Dünyası"
            tableView.reloadData()
        } else if sender.currentTitle == "Eğlence" {
            articleList = entertainmentList
            topicLabel.text = "Eğlence"
            tableView.reloadData()
        } else if sender.currentTitle == "Sağlık" {
            articleList = healthList
            topicLabel.text = "Sağlık Haberleri"
            tableView.reloadData()
        } else if sender.currentTitle == "Bilim" {
            articleList = scienceList
            topicLabel.text = "Bilim"
            tableView.reloadData()
        } else if sender.currentTitle == "Spor" {
            articleList = sportList
            topicLabel.text = "Spor Haberleri"
            tableView.reloadData()
        } else if sender.currentTitle == "Teknoloji" {
            articleList = technologyList
            topicLabel.text = "Teknoloji"
            tableView.reloadData()
        }
//MARK: - Topic Buttons Animation
        UIView.animate(withDuration: 0.6,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.6) {
                sender.transform = CGAffineTransform.identity
            }
        })
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
    func businessData(news: [Article]) {
        DispatchQueue.main.async {
            self.businessList = news
            self.tableView.reloadData()
        }
    }
    func entertainmentData(news: [Article]) {
        DispatchQueue.main.async {
            self.entertainmentList = news
            self.tableView.reloadData()
        }
    }
    func healthData(news: [Article]) {
        DispatchQueue.main.async {
            self.healthList = news
            self.tableView.reloadData()
        }
    }
    func scienceData(news: [Article]) {
        DispatchQueue.main.async {
            self.scienceList = news
            self.tableView.reloadData()
        }
    }
    func sportsData(news: [Article]) {
        DispatchQueue.main.async {
            self.sportList = news
            self.tableView.reloadData()
        }
    }
    func technologyData(news: [Article]) {
        DispatchQueue.main.async {
            self.technologyList = news
            self.tableView.reloadData()
        }
    }
}
// MARK: - TOPICS COLLECTIONVIEW
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = titleCollectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as? HomeTitlesCollectionViewCell else { return UICollectionViewCell()}
        
        cell.titleButton.setTitle(viewModel.topics[indexPath.row].topicName, for: UIControl.State.normal)
        cell.titleButton.backgroundColor = AppColor.pixelsColor
        cell.titleButton.layer.cornerRadius = 10
        cell.titleButton.setTitleColor(.white, for: UIControl.State.normal)

        cell.titleButton.addTarget(self, action: #selector(topicTapped(_:)), for: UIControl.Event.touchUpInside)
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 106, height: 50)
    }
}
// MARK: - TABLEVIEW
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HomeTableViewCell else {return UITableViewCell()}
        
        cell.cellTitle.text = articleList[indexPath.row].title
        
        let imageUrl = articleList[indexPath.row].urlToImage ?? "PixelsLogo"
        cell.cellImage.load(url: URL(string: imageUrl)!)  //load -> extension
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "toWebVC", sender: nil)
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

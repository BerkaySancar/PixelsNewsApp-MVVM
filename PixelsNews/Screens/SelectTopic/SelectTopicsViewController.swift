import UIKit

class SelectTopicsViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    
    private let viewModel: SelectTopicViewModel = SelectTopicViewModel()
    
    private let colors: [UIColor] = [UIColor.systemGreen, UIColor.magenta, UIColor.red, UIColor.systemOrange, UIColor.purple, UIColor.systemBlue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        continueButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.viewModel.getItems()
            self.tableView.reloadData()
        }
    }
    
    @IBAction func didTapContinueButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toHomeVC", sender: nil)
    }
    
    @objc func followUnfollowTapped(_ sender: UIButton!) {
        
        viewModel.updateTopic(item: viewModel.items[sender.tag])
        
        self.tableView.reloadData()
        
        continueButton.isEnabled = true
    }
}
//MARK: - TABLEVIEW
extension SelectTopicsViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.baseTopics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SelectTopicCell else { return UITableViewCell() }
        
        cell.topicNameLabel.text = viewModel.baseTopics[indexPath.row]
        cell.firstLetterLabel.text = viewModel.letters[indexPath.row]
        cell.firstLetterLabel.backgroundColor = self.colors[indexPath.row % self.colors.count]
        cell.firstLetterLabel.layer.masksToBounds = true
        cell.firstLetterLabel.layer.cornerRadius = 25
        cell.followUnfButton.tag = indexPath.row
        cell.followUnfButton.addTarget(self,
                                       action: #selector(followUnfollowTapped),
                                       for: UIControl.Event.touchUpInside)
        cell.followUnfButton.tintColor = .white
        cell.followUnfButton.layer.cornerRadius = 5
    
        if viewModel.items[indexPath.row].isFollow {
            cell.followUnfButton.setTitle("Takip Etme", for: UIControl.State.normal)
            cell.followUnfButton.backgroundColor = .systemRed
        } else {
            cell.followUnfButton.setTitle("Takip Et", for: UIControl.State.normal)
            cell.followUnfButton.backgroundColor = AppColor.pixelsColor
        }
        return cell
    }
}

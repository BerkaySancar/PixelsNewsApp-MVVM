import Foundation

protocol HomeViewControllerDelegate {
    
    var newsList: [Article] { get set }
    var businessList: [Article] { get set }
    var entertainmentList: [Article] { get set }
    var healthList: [Article] { get set }
    var scienceList: [Article] { get set }
    var sportsList: [Article] { get set }
    var technologyList: [Article] { get set }
    
    var topics: [SelectTopicModel] { get set }
    
    var newsService: NewsService { get }
    var homeScreenOutput: HomeViewControllerOutput? { get }
    
    func setDelegate(output: HomeViewControllerOutput)
    func fetchNews()
    
    func getTopics()
}

final class HomeViewModel: HomeViewControllerDelegate {
    
    var topics: [SelectTopicModel] = []

    var newsList: [Article] = []
    var businessList: [Article] = []
    var entertainmentList: [Article] = []
    var healthList: [Article] = []
    var scienceList: [Article] = []
    var sportsList: [Article] = []
    var technologyList: [Article] = []
    
    var newsService: NewsService
    var homeScreenOutput: HomeViewControllerOutput?
    
    init() {
        newsService = NewsService()
    }
    
    func setDelegate(output: HomeViewControllerOutput) {
        homeScreenOutput = output
    }
    
//MARK: - FETCH DATAS
    
    func fetchNews() {
        newsService.fetchGeneralNews(category: "general") { [weak self] (completion) in
            self?.newsList = completion ?? []
            self?.homeScreenOutput?.newsData(news: self?.newsList ?? [])
        }
        newsService.fetchGeneralNews(category: "business") { [weak self] (completion) in
            self?.businessList = completion ?? []
            self?.homeScreenOutput?.businessData(news: self?.businessList ?? [])
        }
        newsService.fetchGeneralNews(category: "entertainment") { [weak self] (completion) in
            self?.entertainmentList = completion ?? []
            self?.homeScreenOutput?.entertainmentData(news: self?.entertainmentList ?? [])
        }
        newsService.fetchGeneralNews(category: "health") { [weak self] (completion) in
            self?.healthList = completion ?? []
            self?.homeScreenOutput?.healthData(news: self?.healthList ?? [])
        }
        newsService.fetchGeneralNews(category: "science") { [weak self] (completion) in
            self?.scienceList = completion ?? []
            self?.homeScreenOutput?.scienceData(news: self?.scienceList ?? [])
        }
        newsService.fetchGeneralNews(category: "sports") { [weak self] (completion) in
            self?.sportsList = completion ?? []
            self?.homeScreenOutput?.sportsData(news: self?.sportsList ?? [])
        }
        newsService.fetchGeneralNews(category: "technology") { [weak self] (completion) in
            self?.technologyList = completion ?? []
            self?.homeScreenOutput?.technologyData(news: self?.technologyList ?? [])
        }
    }
    
//MARK: - GET TOPICS DATA
    func getTopics() {
        guard
            let data = UserDefaults.standard.data(forKey: "basliklar"),
            let savedTopics = try? JSONDecoder().decode([SelectTopicModel].self, from: data)
        else { return }
        
        for item in savedTopics {
            if item.isFollow {
                self.topics.append(item)
            }
        }
    }
}

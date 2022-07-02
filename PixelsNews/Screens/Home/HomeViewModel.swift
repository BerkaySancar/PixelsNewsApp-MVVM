import Foundation

protocol HomeViewControllerDelegate {
    
    var newsList: [Article] { get set }
    var newsService: NewsService { get }
    var homeScreenOutput: HomeViewControllerOutput? { get }
    
    func fetchNews()
    func setDelegate(output: HomeViewControllerOutput)
    
}

final class HomeViewModel: HomeViewControllerDelegate {

    var newsList: [Article] = []
    var newsService: NewsService
    var homeScreenOutput: HomeViewControllerOutput?
    
    init() {
        newsService = NewsService()
    }
    
    func fetchNews() {
        newsService.fetchTrendingMovies { [weak self] (response) in
            self?.newsList = response ?? []
            self?.homeScreenOutput?.newsData(news: self?.newsList ?? [])
        
        }
    }
    func setDelegate(output: HomeViewControllerOutput) {
        homeScreenOutput = output
    }
}

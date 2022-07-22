import Foundation

protocol SearchViewModelDelegate {
    
    var searchList: [Article] { get set }
    var newsService: NewsService { get }
    var searchScreenOutput: SearchViewControllerOutput? { get }
    
    func setDelegate(output: SearchViewControllerOutput)
    func searchNews(query: String)
}

class SearchViewModel: SearchViewModelDelegate {
    
    init() {
        newsService = NewsService()
    }
    
    var searchList: [Article] = []
    var newsService: NewsService
    var searchScreenOutput: SearchViewControllerOutput?

    func setDelegate(output: SearchViewControllerOutput) {
        searchScreenOutput = output
    }
    
//MARK: - FETCH SEARCH DATAS
    
    func searchNews(query: String) {
        
        newsService.fetchSearchingNews(query: query) { [weak self] (completion) in
            self?.searchList = completion ?? []
            self?.searchScreenOutput?.searchingData(news: self?.searchList ?? [])
        }
    }
}

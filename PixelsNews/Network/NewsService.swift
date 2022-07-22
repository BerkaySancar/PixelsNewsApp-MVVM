import Foundation

struct NewsService {
    
    static let shared = NewsService()

    func fetchGeneralNews(category: String, completion: @escaping ([Article]?) -> Void) {
        
        guard let url = URL(string: "\(Constants.BASE_URL)top-headlines?country=tr&category=\(category)&apiKey=\(Constants.API_KEY)") else { return }
           let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in

               guard let data = data, error == nil else {
                   completion(nil)
                   return
               }
               
               do {
                   let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                   completion(results.articles)
               } catch {
                   print(error.localizedDescription)
               }
           }
           task.resume()
       }
    
    func fetchSearchingNews(query: String, completion: @escaping ([Article]?) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.BASE_URL)everything?q=\(query)&from=2022-07-06&sortBy=popularity&language=tr&apiKey=\(Constants.API_KEY)") else { return }
           
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in

               guard let data = data, error == nil else {
                   completion(nil)
                   return
               }
               
               do {
                   let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                   completion(results.articles)
               } catch {
                   print(error.localizedDescription)
               }
           }
           task.resume()
       }
}

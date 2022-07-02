import Foundation

struct NewsService {

    func fetchTrendingMovies(response: @escaping ([Article]?) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)top-headlines?country=tr&apiKey=\(Constants.API_KEY)") else { return }
           let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in

               guard let data = data, error == nil else {
                   response(nil)
                   return
               }
               
               do {
                   let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                   response(results.articles)
               } catch {
                   print(error.localizedDescription)
               }
           }
           task.resume()
       }
}

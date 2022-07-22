import Foundation

class SelectTopicViewModel {
    
    var items: [SelectTopicModel] = [
                                     SelectTopicModel(topicName: "İş", isFollow: false),
                                     SelectTopicModel(topicName: "Eğlence", isFollow: false),
                                     SelectTopicModel(topicName: "Sağlık", isFollow: false),
                                     SelectTopicModel(topicName: "Bilim", isFollow: false),
                                     SelectTopicModel(topicName: "Spor", isFollow: false),
                                     SelectTopicModel(topicName: "Teknoloji", isFollow: false) ] {
        didSet {
            saveTopic()
        }
    }
    init() {
        getItems()
    }
    
    let baseTopics: [String] = ["İş", "Eğlence", "Sağlık", "Bilim", "Spor", "Teknoloji"]
    let letters: [String] = ["İ", "E", "S", "B", "S", "T"]

    func updateTopic(item: SelectTopicModel) {
        if let index = items.firstIndex(where: {$0.topicName == item.topicName}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveTopic() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: "basliklar")
        }
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: "basliklar"),
            let savedTopics = try? JSONDecoder().decode([SelectTopicModel].self, from: data)
        else { return }
        
        self.items = savedTopics
    }
}

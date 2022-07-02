import Foundation

class SelectTopicViewModel {
    
    var items: [SelectTopicModel] = [] {
        didSet {
            saveTopic()
        }
    }
    init() {
        getItems()
        addTopic()
    }
    
    let baseTopics: [String] = ["İş", "Eğlence", "Genel", "Sağlık", "Bilim", "Spor", "Teknoloji"]
    let letters: [String] = ["İ","E","G","S","B","S","T"]
    
    func addTopic() {
        let business = SelectTopicModel(topicName: "business", isFollow: false)
        let entertainment = SelectTopicModel(topicName: "entertainment", isFollow: false)
        let general = SelectTopicModel(topicName: "general", isFollow: false)
        let health = SelectTopicModel(topicName: "health", isFollow: false)
        let science = SelectTopicModel(topicName: "science", isFollow: false)
        let sport = SelectTopicModel(topicName: "sport", isFollow: false)
        let technology = SelectTopicModel(topicName: "technology", isFollow: false)
        
        items.append(business)
        items.append(entertainment)
        items.append(general)
        items.append(health)
        items.append(science)
        items.append(sport)
        items.append(technology)
    }
    
    func updateTopic(item: SelectTopicModel) {
        if let index = items.firstIndex(where: {$0.topicName == item.topicName}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func deleteTopic(topicName: String) {
        if let index = items.firstIndex(where: {$0.topicName == topicName}) {
            items.remove(at: index)
        }
    }
    func saveTopic() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: "selectedTopic")
        }
    }
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: "selectedTopic"),
            let savedTopics = try? JSONDecoder().decode([SelectTopicModel].self, from: data)
        else { return }
        
        self.items = savedTopics
    }
}



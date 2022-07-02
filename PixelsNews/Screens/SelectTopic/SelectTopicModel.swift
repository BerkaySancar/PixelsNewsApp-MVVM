import Foundation

struct SelectTopicModel: Codable {
    
    var topicName: String = ""
    var isFollow: Bool = false

    func updateCompletion() -> SelectTopicModel {
        return SelectTopicModel(topicName: topicName, isFollow: !isFollow)
    }
}

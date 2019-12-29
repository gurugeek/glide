import MongoKitten
import Meow

struct Pokemon: Codable, Model {
  static let collectionName = "pokemon"
  var _id = ObjectId()
  var name: String
  var type: String
  var HP: Int
  
  init(name: String,
       type: String,
       HP: Int) {
    self.name = name
    self.type = type
    self.HP = HP
  }
}

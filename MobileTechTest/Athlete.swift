import Foundation

struct Athlete: Decodable {
    let firstName: String
    let lastName: String
    let id: Int
    let imageURL: URL?
    let username: String
    let squadIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case id
        case image
        case username
        case squadIds = "squad_ids"
    }
    
    enum ImageKeys: String, CodingKey {
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        id = try container.decode(Int.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        squadIds = try container.decode([Int].self, forKey: .squadIds)
        
        let imageContainer = try? container.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
        let imageURL = try? imageContainer?.decode(String.self, forKey: .url)
        if let imageURL {
            self.imageURL =  URL(string: imageURL)
        }
        else {
            self.imageURL = nil
        }
    }
}

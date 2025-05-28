import Foundation

struct Squad: Decodable {
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id
        case name
        case organisationId = "organisation_id"
        case updatedAt = "updated_at"
    }
    
    static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    let createdAt: Date
    let id: Int
    let name: String
    let organisationId: Int
    let updatedAt: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        organisationId = try container.decode(Int.self, forKey: .organisationId)
        
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        guard let createdAtDate = Self.dateFormatter.date(from: createdAtString) else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt, in: container, debugDescription: "Invalid createdAt date format")
        }
        createdAt = createdAtDate
        
        let updatedAtString = try container.decode(String.self, forKey: .updatedAt)
        guard let updatedAtDate = Self.dateFormatter.date(from: updatedAtString) else {
            throw DecodingError.dataCorruptedError(forKey: .updatedAt, in: container, debugDescription: "Invalid updatedAt date format")
        }
        updatedAt = updatedAtDate
    }
}

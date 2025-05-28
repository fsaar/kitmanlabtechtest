import Foundation

extension Bundle {
    
    static func jsonData(for filename: String) throws -> Data {
        let module = Bundle(for: MockURLProtocol.self)
        let url = module.url(forResource: filename, withExtension: "json")!
        let data = try Data(contentsOf: url)
        return data
    }
    
    
    static func decodeType<T:Decodable>(from filename: String) throws -> T {
        let data = try Bundle.jsonData(for: filename)
        let decoder = JSONDecoder()
        let response = try decoder.decode(T.self, from: data)
        return response
    }
}

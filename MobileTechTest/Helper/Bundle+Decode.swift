import Foundation

extension Bundle {
    
    func jsonData(for filename: String) -> Data? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try? Data(contentsOf: url)
        return data
    }
    
    
    func decodeType<T:Decodable>(from filename: String) -> T? {
        guard let data = self.jsonData(for: filename) else {
            return nil
        }
        let decoder = JSONDecoder()
        let response = try? decoder.decode(T.self, from: data)
        return response
    }
}

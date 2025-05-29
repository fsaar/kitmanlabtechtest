
import Foundation
import CoreLocation

protocol APIConformable {
    func getSquads() async throws -> [Squad]
    func getAthletes() async throws -> [Athlete]
}

public final class APIClient: APIConformable {
   
    private let apiManager: APIRequestable
    private static let jsonDecoder = JSONDecoder()

    init(_ manager: APIRequestable = APIRequestManager()) {
        self.apiManager = manager
    }
    
    func getSquads() async throws -> [Squad] {
        let data = try await apiManager.dataWithPath(.squads)
        let squads = try Self.jsonDecoder.decode([Squad].self,from: data)
        return squads
    }
    
    func getAthletes() async throws -> [Athlete] {
        let data = try await apiManager.dataWithPath(.athletes)
        let athletes = try Self.jsonDecoder.decode([Athlete].self,from: data)
        return athletes
    }
    
    func logon(with credential: Credential) async throws -> Bool {
        let data = try await apiManager.logon(with: credential)
        let dict = try JSONSerialization.jsonObject(with: data)
        guard let dict = dict as? [String:Any] else {
            return false
        }
        return dict.keys.count > 0
    }
}




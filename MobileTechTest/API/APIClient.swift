
import Foundation
import CoreLocation

public final class APIClient {
   
    private let apiManager: APIRequestable
    
    init(_ manager: APIRequestable = APIRequestManager()) {
        self.apiManager = manager
    }
    static let jsonDecoder = JSONDecoder()
    
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
}




import Testing
import Foundation

@testable import MobileTechTest

class MockAPIRequestable: APIRequestable {
    var mockData: Data?
    var mockError: Error?
    
    func dataWithPath(_ path: APIRequestManager.Path) async throws -> Data {
        if let error = mockError {
            throw error
        }
        return mockData ?? Data()
    }
}

@Suite("APIClientTests")
struct APIClientTests {
    
    @Suite("squads")
    struct SquadTests {
        @Test("APIClient fetches squads successfully")
        func testFetchSquadsSuccess() async throws {
            let squadsJSON = """
            [
               {
                  "created_at":"2015-09-14T18:26:11.000Z",
                  "id":78,
                  "name":"staff",
                  "organisation_id":6,
                  "updated_at":"2015-09-14T18:26:11.000Z"
               },
               {
                  "created_at":"2015-09-02T19:42:22.000Z",
                  "id":72,
                  "name":"Active Roster",
                  "organisation_id":6,
                  "updated_at":"2015-09-02T19:42:22.000Z"
               }
            ]
            """
            
            let mockRequestable = MockAPIRequestable()
            mockRequestable.mockData = squadsJSON.data(using: .utf8)!
            
            let apiClient = APIClient(mockRequestable)
            let squads = try await apiClient.getSquads()
            
            #expect(squads.count == 2)
            #expect(squads[0].id == 78)
            #expect(squads[0].name == "staff")
            #expect(squads[0].organisationId == 6)
            #expect(squads[1].id == 72)
            #expect(squads[1].name == "Active Roster")
        }
        
        @Test("APIClient handles network error")
        func testFetchSquadsNetworkError() async throws {
            let mockRequestable = MockAPIRequestable()
            mockRequestable.mockError = URLError(.notConnectedToInternet)
            
            let apiClient = APIClient(mockRequestable)
            
            await #expect(throws: URLError.self) {
                try await apiClient.getSquads()
            }
        }
        
        @Test("APIClient handles invalid JSON")
        func testFetchSquadsInvalidJSON() async throws {
            let invalidJSON = "invalid json"
            
            let mockRequestable = MockAPIRequestable()
            mockRequestable.mockData = invalidJSON.data(using: .utf8)!
            
            let apiClient = APIClient(mockRequestable)
            
            await #expect(throws: DecodingError.self) {
                try await apiClient.getSquads()
            }
        }
        
        @Test("APIClient handles custom error")
        func testFetchSquadsCustomError() async throws {
            enum CustomError: Error {
                case testError
            }
            
            let mockRequestable = MockAPIRequestable()
            mockRequestable.mockError = CustomError.testError
            
            let apiClient = APIClient(mockRequestable)
            
            await #expect(throws: CustomError.self) {
                try await apiClient.getSquads()
            }
        }
    }
    
    @Suite("Athletes")
    struct AthleteTests {
        @Test("APIClient fetches athletes successfully")
        func testFetchAthletesSuccess() async throws {
            let athletesJSON = """
            [
               {
                  "first_name":"Adam",
                  "last_name":"Beard",
                  "id":1964,
                  "image":{
                     "url":"https://kitman.imgix.net/avatar.jpg"
                  },
                  "username":"abeardathlete",
                  "squad_ids":[
                     78
                  ]
               },
               {
                  "first_name":"Al",
                  "last_name":"Saunders",
                  "id":5011,
                  "image":{
                     "url":"https://kitman.imgix.net/avatar.jpg"
                  },
                  "username":"asaunders",
                  "squad_ids":[
                     78
                  ]
               }
            ]
            """
            
            let mockRequestable = MockAPIRequestable()
            mockRequestable.mockData = athletesJSON.data(using: .utf8)!
            
            let apiClient = APIClient(mockRequestable)
            let athletes = try await apiClient.getAthletes()
            
            #expect(athletes.count == 2)
            #expect(athletes[0].id == 1964)
            #expect(athletes[0].firstName == "Adam")
            #expect(athletes[0].lastName == "Beard")
            #expect(athletes[0].username == "abeardathlete")
            #expect(athletes[0].squadIds == [78])
            #expect(athletes[1].id == 5011)
            #expect(athletes[1].firstName == "Al")
            #expect(athletes[1].lastName == "Saunders")
        }
        
        @Test("APIClient handles network error")
        func testFetchAthletesNetworkError() async throws {
            let mockRequestable = MockAPIRequestable()
            mockRequestable.mockError = URLError(.timedOut)
            
            let apiClient = APIClient(mockRequestable)
            
            await #expect(throws: URLError.self) {
                try await apiClient.getAthletes()
            }
        }
        
        @Test("APIClient handles invalid JSON")
        func testFetchAthletesInvalidJSON() async throws {
            let invalidJSON = "{ invalid json }"
            
            let mockRequestable = MockAPIRequestable()
            mockRequestable.mockData = invalidJSON.data(using: .utf8)!
            
            let apiClient = APIClient(mockRequestable)
            
            await #expect(throws: DecodingError.self) {
                try await apiClient.getAthletes()
            }
        }
        
        @Test("APIClient handles custom error")
        func testFetchAthletesCustomError() async throws {
            enum NetworkError: Error {
                case serverError
            }
            
            let mockRequestable = MockAPIRequestable()
            mockRequestable.mockError = NetworkError.serverError
            
            let apiClient = APIClient(mockRequestable)
            
            await #expect(throws: NetworkError.self) {
                try await apiClient.getAthletes()
            }
        }
    }
}


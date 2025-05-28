import Testing
import Foundation

@testable import MobileTechTest


// Tests need to be serialised due to URLProtocol
@Suite("APIRequestManagerTests", .serialized)
struct APIRequestManagerTests {
    
    @Test("APIRequestManager returns valid JSON")
    func testRequestManagerValidJSON() async throws {
        
        // Setup mock response
        let data = try Bundle.jsonData(for: "squads")
        MockURLProtocol.mockData = data
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: "https://kml-tech-test.glitch.me/squads")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let requestManager = APIRequestManager()
        requestManager.protocolClasses = [MockURLProtocol.self]
        
        let responseData = try await requestManager.dataWithPath(.squads)
        #expect(responseData.count == 347)
    }
    
    @Test("APIRequestManager returns valid JSON handles network error")
    func testRequestManagerNetworkError() async throws {
        MockURLProtocol.mockError = URLError(.notConnectedToInternet)
        
        let requestManager = APIRequestManager()
        requestManager.protocolClasses = [MockURLProtocol.self]
        
        await #expect(throws: URLError.self) {
            try await requestManager.dataWithPath(.squads)
        }
    }
}



import Testing
import Foundation

@testable import MobileTechTest


// Tests need to be serialised due to URLProtocol
@Suite("APIRequestManagerTests", .serialized)
struct APIRequestManagerTests {
    
    
    @Suite("dataWithPath tests", .serialized)
    struct dataWithPathTests {
        @Test("APIRequestManager returns valid JSON")
        func testRequestManagerValidJSON() async throws {
            
            // Setup mock response
            let data = Bundle.test.jsonData(for: "squads")!
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
   
    @Suite("logonTests", .serialized)
    struct logonTests {
        @Test("APIRequestManager logon with valid credentials",.disabled())
        func testLogonSuccess() async throws {
            let mockResponseData = """
            {
                "username": "sampleUsername"
            }
            """.data(using: .utf8)!
            
            MockURLProtocol.mockData = mockResponseData
            MockURLProtocol.mockResponse = HTTPURLResponse(
                url: URL(string: "https://kml-tech-test.glitch.me/session")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )
            
            let requestManager = APIRequestManager()
            requestManager.protocolClasses = [MockURLProtocol.self]
            
            let credential = Credential(username: "testuser", password: "testpass")
            let responseData = try await requestManager.logon(with: credential)
            
            #expect(responseData == mockResponseData)
        }
        
        
        @Test("APIRequestManager logon handles network error")
        func testLogonNetworkError() async throws {
            MockURLProtocol.mockError = URLError(.networkConnectionLost)
            
            let requestManager = APIRequestManager()
            requestManager.protocolClasses = [MockURLProtocol.self]
            
            let credential = Credential(username: "testuser", password: "testpass")
            
            await #expect(throws: URLError.self) {
                try await requestManager.logon(with: credential)
            }
        }
    }
}



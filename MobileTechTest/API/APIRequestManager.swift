import Foundation

protocol APIRequestable {
    func dataWithPath(_ path: APIRequestManager.Path) async throws -> Data
    func logon(with credential: Credential) async throws -> Data
}


class APIRequestManager: APIRequestable {
    enum RequestManagerErrorType : Error {
        case invalidPath(Path)
    }
    enum Path: String {
        case squads
        case athletes
        case session
        var url: URL? {
            URL(string:"\(APIRequestManagerBaseURL)\(self.rawValue)")
        }
    }
    private static let APIRequestManagerBaseURL = "https://kml-tech-test.glitch.me/"

    var protocolClasses : [AnyClass] = [] {
        didSet {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = self.protocolClasses
            self.session = URLSession(configuration:configuration)
        }
    }
    
    lazy var session : URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForResource = 120
        configuration.timeoutIntervalForRequest = 60
        let session = URLSession(configuration:  configuration,delegate:nil,delegateQueue:nil)
        return session
    }()

    func dataWithPath(_ path: APIRequestManager.Path) async throws -> Data {
        guard let url =  path.url else {
            throw RequestManagerErrorType.invalidPath(path)
        }
        let (data,_) = try await session.data(from: url)
        return data
    }
    
    func logon(with credential: Credential) async throws -> Data {
        guard let url = Path.session.url else {
            throw RequestManagerErrorType.invalidPath(.session)
        }
        let request = try await request(with: url, with: credential)
        let (data,_) = try await session.data(for: request)
        return data
    }
    
    private func request(with url: URL, with credential: Credential) async throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = try JSONEncoder().encode(credential)
        request.httpBody = bodyData
        return request
    }
}

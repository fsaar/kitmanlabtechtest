import Observation


@Observable
class LogonViewModel {
    private let client: APIClient
    var loggedIn = false
    
    init(client: APIClient = APIClient()) {
        self.client = client
    }
    
    func logon(username: String, password: String) async {
        let credentials = Credential(username: username, password: password)
        let loggedIn =  (try? await self.client.logon(with: credentials)) ?? false
        Task { @MainActor in
            self.loggedIn = loggedIn
        }
    }
    
}


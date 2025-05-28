import Observation


@Observable
class SquadViewModel {
    private let client: APIClient
    var squads: [Squad] = []
    
    init(client: APIClient = APIClient()) {
        self.client = client
    }
    
    func loadSquads() async {
        if let squads =  try? await client.getSquads()  {
            Task { @MainActor in
                self.squads = squads.sorted(by: { $0.name < $1.name })
            }
        }
    }
    
}


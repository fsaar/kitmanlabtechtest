import Observation


@Observable
class AthleteViewModel {
    private let client: APIClient
    var athletes: [Athlete] = []
    
    init(client: APIClient = APIClient()) {
        self.client = client
    }
    
    func loadAthletes() async {
        if let squads =  try? await client.getAthletes()  {
            Task { @MainActor in
                self.athletes = squads.sorted(by: { $0.lastName < $1.lastName })
            }
        }
    }
    
    func athletesInSquad(_ squadId: Int) -> [Athlete] {
        self.athletes.filter { $0.squadIds.contains(squadId) }
    }
}


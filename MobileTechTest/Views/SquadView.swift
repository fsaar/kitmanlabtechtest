
import SwiftUI

struct SquadView: View {
    @State var model = AthleteViewModel()
    
    let squadId: Int
    let squads: [Squad]
    var body: some View {
        List {
            ForEach(model.athletesInSquad(squadId)) { athlete in
                HStack {
                    NavigationLink(value: athlete) {
                        ProfileView(athlete: athlete)
                    }
                    Spacer()
                }
            }
        }
        .navigationDestination(for: Athlete.self) { athlete in
            let squads = squadsWithIds(athlete.squadIds)
            AthleteView(athlete: athlete, squads: squads)
        }
        .task {
            await model.loadAthletes()
        }
        
    }
    
    private func squadsWithIds(_ ids: [Int]) -> [Squad] {
        squads.filter { squad in ids.contains( squad.id) }
    }
}

#Preview {
    let data = Bundle.main.jsonData(for: "squads")!
    let squads = try! JSONDecoder().decode([Squad].self, from: data)
    SquadView(squadId: 72, squads: squads).environmentObject(ImageCache())
}




import SwiftUI

struct SquadView: View {
    @Binding var path: NavigationPath
    @State var model = AthleteViewModel()
    
    let squadId: Int
    let squads: [Squad]
    var body: some View {
        List {
            ForEach(model.athletesInSquad(squadId)) { athlete in
                HStack {
                    NavigationLink(value: Route.athleteView(athlete, squadsWithIds(athlete.squadIds))) {
                        ProfileView(athlete: athlete)
                    }
                    Spacer()
                }
            }
        }
        .task {
            await model.loadAthletes()
        }
        
    }
    
    private func squadsWithIds(_ ids: [Int]) -> [Squad] {
        squads.filter { squad in ids.contains( squad.id) }
    }
}

//#Preview {
//    let data = Bundle.main.jsonData(for: "squads")!
//    let squads = try! JSONDecoder().decode([Squad].self, from: data)
//    SquadView(squadId: 72, squads: squads).environmentObject(ImageCache())
//}



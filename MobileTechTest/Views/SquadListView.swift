import SwiftUI

struct SquadListView: View {
    @State var model : SquadViewModel
   
    var body: some View {
        List {
            ForEach(model.squads) { squad in
                HStack {
                    NavigationLink(value: squad) {
                        Text(squad.name)
                    }
                    Spacer()
                }
            }
            
        }
        .navigationDestination(for: Squad.self) { squad in
            SquadView(squadId: squad.id, squads: model.squads)
        }
        
        .task {
            await model.loadSquads()
        }
        
    }
}
//
//#Preview {
//    let data = Bundle.main.jsonData(for: "squads")!
//    let squads = try! JSONDecoder().decode([Squad].self, from: data)
//    SquadListView(squads: squads)
//}
//


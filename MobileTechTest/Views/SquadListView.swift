import SwiftUI

struct SquadListView: View {
    @Binding var path: NavigationPath
    @State var model : SquadViewModel
    var body: some View {
        List {
            ForEach(model.squads) { squad in
                HStack {
                    NavigationLink(value: Route.squadView(squad.id, model.squads)) {
                        Text(squad.name)
                    }
                    Spacer()
                }
            }
            
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

